import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:multi_localization_app/MyPageRoute/route_provider.dart';
import 'package:multi_localization_app/Views/home/login_circle_avtar_button.dart';
import 'package:multi_localization_app/Views/home/task_page.dart';
import 'package:multi_localization_app/constant/appColor.dart';
import 'package:multi_localization_app/constant/constant_widget.dart';
import 'package:multi_localization_app/l10n/app_localizations.dart';
import 'package:multi_localization_app/utils/custom_widgets.dart';
import 'package:provider/provider.dart';

class MyMapLocation extends StatefulWidget {
  const MyMapLocation({super.key});

  @override
  State<MyMapLocation> createState() => _MyMapLocationState();
}

class _MyMapLocationState extends State<MyMapLocation>
    with SingleTickerProviderStateMixin {
  String formattedTime = DateFormat('hh:mm a').format(DateTime.now());

  late AnimationController _controller;
  bool isLogin = true;
  LatLng myLatlng = LatLng(26.850000, 80.949997); // default: Lucknow
  String address = "Tap Login";
  GoogleMapController? _mapController;
  var tasklist;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    // _determinePosition();

    // call on startup
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() async {
    await _controller.forward(from: 0); // Start rotation
    setState(() {
      isLogin = !isLogin; // Toggle Login ↔ Logout
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    await _controller.forward(from: 0); // Start rotation
    setState(() {
      isLogin = !isLogin; // Toggle Login ↔ Logout
    });
    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      FlutterToastr.show(
        "Location services are disabled",
        context,
        position: FlutterToastr.center,
      );
      return;
    }

    // Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        FlutterToastr.show(
          "Location permission denied",
          context,
          position: FlutterToastr.center,
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      FlutterToastr.show(
        "Location permission permanently denied",
        context,
        position: FlutterToastr.center,
      );
      return;
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setMarker(LatLng(position.latitude, position.longitude));

    // Move map to current location
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        14,
      ),
    );
  }

  Future<void> setMarker(LatLng value) async {
    myLatlng = value;
    List<Placemark> result = await placemarkFromCoordinates(
      value.latitude,
      value.longitude,
    );
    if (result.isNotEmpty) {
      address =
          '${result[0].name}, ${result[0].locality}, ${result[0].administrativeArea}';
    }

    setState(() {
      FlutterToastr.show(
        address,
        context,
        duration: 1,
        position: FlutterToastr.center,
      );
    });
    context.read<RouteProvider>().navigateTo("/task", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: myLatlng, zoom: 12),
            markers: {
              Marker(
                markerId: MarkerId('1'),
                infoWindow: InfoWindow(title: address),
                draggable: true,
                position: myLatlng,
                onDragEnd: (value) {
                  setMarker(value);
                },
              ),
            },
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: (argument) {
              setMarker(argument);
              _mapController?.animateCamera(CameraUpdate.newLatLng(argument));
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            trafficEnabled: true,
          ),

          // Bottom sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(radius: 25),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Field Employee",
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: AppColor.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SizedBox(height: 8),
                          SizedBox(
                            width: 280,
                            height: 20,
                            child: FittedBox(
                              child: Text(
                                address,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          login(),

          // Visibility(
          //   visible: isLogin,
          //   child: Positioned(
          //     left: 0,
          //     right: 0,
          //     bottom: 70,
          //     child: GestureDetector(
          //       onTap: _determinePosition,
          //       child: AnimatedBuilder(
          //         animation: _controller,
          //         builder: (_, child) {
          //           return Transform.rotate(
          //             angle:
          //                 _controller.value * 2 * 3.14 * 1, // 10 full rotations
          //             child: child,
          //           );
          //         },
          //         child: CircleAvatar(
          //           radius: 60.0,
          //           backgroundColor: isLogin
          //               ? AppColor.primaryColor
          //               : Colors.green.withAlpha(50),
          //           child: CircleAvatar(
          //             radius: 50,
          //             backgroundColor: AppColor.secondaryColor,
          //             child: Text(
          //               isLogin
          //                   ? AppLocalizations.of(context)!.login
          //                   : AppLocalizations.of(context)!.logout,
          //               style: MyCustomWidgets.textstyle(
          //                 textColor: Colors.white,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // Visibility(
          //   visible: !isLogin,
          //   child: Positioned(
          //     left: 0,
          //     right: 0,
          //     bottom: 70,
          //     child: Container(
          //       child: Column(
          //         children: [
          //           Text(
          //             "Logged In",
          //             style: MyCustomWidgets.textstyle(
          //               textColor: AppColor.secondaryColor,
          //               fontSize: 16,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           Text(
          //             formattedTime,
          //             style: MyCustomWidgets.textstyle(
          //               fontSize: 25,
          //               fontWeight: FontWeight.w600,
          //               textColor: AppColor.textColor,
          //             ),
          //           ),
          //           Text(
          //             "You are on Time ! Great",
          //             style: MyCustomWidgets.textstyle(
          //               textColor: AppColor.secondaryColor,
          //               fontSize: 16,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  login() {
    if (isLogin) {
      return Positioned(
        left: 0,
        right: 0,
        bottom: 70,
        child: GestureDetector(
          onTap: _determinePosition,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * 3.14 * 1, // 10 full rotations
                child: child,
              );
            },
            child: CircleAvatar(
              radius: 60.0,
              backgroundColor: isLogin
                  ? AppColor.primaryColor
                  : Colors.green.withAlpha(50),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColor.secondaryColor,
                child: Text(
                  isLogin
                      ? AppLocalizations.of(context)!.login
                      : AppLocalizations.of(context)!.logout,
                  style: MyCustomWidgets.textstyle(
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      Container(
        child: Column(
          children: [
            Text("Logged In"),
            Text(formattedTime),
            Text("Yor are on Time! Great"),
          ],
        ),
      );
    }
    return Container(
      child: Column(
        children: [
          Text("Logged In"),
          Text(formattedTime),
          Text("Yor are on Time! Great"),
        ],
      ),
    );
  }
}
