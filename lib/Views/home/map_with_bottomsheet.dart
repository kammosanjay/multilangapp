import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart' as lotti;
import 'package:multi_localization_app/MyPageRoute/route_provider.dart';
import 'package:multi_localization_app/Views/home/check_in_circle.dart';

import 'package:multi_localization_app/Views/home/login_circle.dart';
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
  bool taskCreated = false;
  late AnimationController _controller;
  bool isLogin = true;
  LatLng myLatlng = LatLng(26.850000, 80.949997); // default: Lucknow
  String address = "Tap Login to Get Location";
  GoogleMapController? _mapController;
  var tasklist;
  bool isloading = false;

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
    setState(() {
      isloading = true;
    });
    bool serviceEnabled;
    LocationPermission permission;

    await _controller.forward(from: 0); // Start rotation

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
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLogin = !isLogin; // Toggle Login ↔ Logout
      });
    });
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
      isloading = false;
    });
    // setState(() {
    //   FlutterToastr.show(
    //     address,
    //     context,
    //     duration: 4,
    //     position: FlutterToastr.center,
    //   );
    // });
    Future.delayed(Duration(seconds: 4), () async {
      final resultArg = await context.read<RouteProvider>().navigateTo(
        "/task",
        context,
      );
      setState(() {
        taskCreated = true;
      });

      if (resultArg == "taskCreated") {
        print("✅ Task was created!");
        // Perform any success action
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            bottom: 320,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: myLatlng,
                  zoom: 12,
                ),
                compassEnabled: true,

                // liteModeEnabled: true,
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
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLng(argument),
                  );
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                trafficEnabled: true,
              ),
            ),
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
                border: BoxBorder.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFFeffdff)
                      : Color(0xFFeffdff),
                ),
                color: AppColor.primaryColor(context),
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
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xFFeffdff)
                          : Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Color(0xFFeffdff)
                            : Colors.black,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Employee Name",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Color(0xFFeffdff)
                                    : Colors.black,
                              ),
                            ),
                          ),
                          // SizedBox(height: 8),
                          isloading
                              ? Container(
                                  width: 300,
                                  height: 2,
                                  child: LinearProgressIndicator(
                                    backgroundColor: AppColor.primaryColor(
                                      context,
                                    ),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColor.textColor(context),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 290,
                                  child: Text(
                                    address,

                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        color:
                                            Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Color(0xFFeffdff)
                                            : Colors.black,
                                      ),
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
        child: NeumorphicCircleButton(
          isLogin: isLogin,
          onTap: _determinePosition,
          isTaskCreated: taskCreated,
        ),
      );
    } else if (taskCreated) {
      return Positioned(
        left: 0,
        right: 0,
        bottom: 70,
        child: NeumorphicCircleButtonCheckIn(
          // isLogin: isLogin,
          isTaskCreated: taskCreated,
        ),
      );
    }

    return Positioned(
      left: 0,
      right: 0,
      bottom: 70,
      child: Column(
        children: [
          Text(
            "Logged In",
            style: MyCustomWidgets.textstyle(
              textColor: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFFeffdff)
                  : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            formattedTime,
            style: MyCustomWidgets.textstyle(
              textColor: const Color.fromARGB(255, 68, 66, 66),
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Yor are on Time! Great",
            style: MyCustomWidgets.textstyle(
              textColor: const Color.fromARGB(255, 70, 66, 66),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
