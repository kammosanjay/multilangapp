// import 'package:flutter/material.dart';
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:multi_localization_app/Views/home/map_with_bottomsheet.dart';
import 'package:multi_localization_app/Views/theme/theme_provider.dart';

import 'package:multi_localization_app/constant/appColor.dart';
import 'package:multi_localization_app/l10n/app_localizations.dart';
import 'package:multi_localization_app/Views/language/language.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var locationController = TextEditingController();
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    MyMapLocation(),
    Center(child: Container(color: AppColor.primaryColor)),
    Center(child: Container(color: AppColor.secondaryColor)),
    Center(child: Container(color: AppColor.buttonColor)),
    Center(child: Container(color: AppColor.errorColor)),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // update selected index
    });
  }

  String? imagePath;

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    print("build");
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // This shows all 5 items
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/attendance.png'),
              size: 30.0,
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/track.png'),
              size: 30.0,
              color: Colors.black,
            ),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/task.png'),
              size: 30.0,
              color: Colors.green,
            ),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/leads.png'),
              size: 30.0,
              color: Colors.indigo,
            ),
            label: 'Leads',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/more.png'),
              size: 30.0,
              color: Colors.red,
            ),
            label: 'More',
          ),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: AppColor.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 50,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: imagePath != null
                              ? Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColor.primaryColor,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      File(imagePath!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Image.asset(
                                  'assets/images/student_as.png',
                                  fit: BoxFit.cover,
                                  color: AppColor.primaryColor,
                                  height: 40,
                                ),
                        ),
                      ),
                      Positioned(
                        left: 100,
                        right: 15,

                        bottom: 60,
                        child: InkWell(
                          onTap: () {
                            ImagePicker()
                                .pickImage(source: ImageSource.gallery)
                                .then((value) {
                                  if (value != null) {
                                    setState(() {
                                      imagePath =
                                          value.path; // ✅ This rebuilds the UI
                                    });
                                    print("Selected image: ${value.path}");
                                  }
                                });
                          },
                          child: Icon(
                            Icons.camera_alt,
                            size: 25,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      // SvgPicture.asset(
                      //   'assets/svgImages/refresh.svg',
                      //   height: 50,
                      //   width: 50,
                      // ),
                      const SizedBox(height: 10),
                      Positioned(
                        left: 40,
                        right: 30,
                        top: 100,
                        bottom: 10,
                        child: Text(
                          appLoc.welcome,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  spacing: 2,
                  children: [
                    ListTile(
                      title: Text(appLoc.theme),

                      style: ListTileStyle.list,
                      tileColor: AppColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        // context.read<ThemeProvider>().toggleTheme();
                        showDialog(
                          context: context,
                          builder: (context) {
                            ThemeMode currentMode = ThemeMode.light;

                            return AlertDialog(
                              title: Text('Select Theme'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile<ThemeMode>(
                                    title: Text('Light'),
                                    value: ThemeMode.light,
                                    groupValue: currentMode,
                                    onChanged: (value) {
                                      if (value != null) {
                                        context
                                            .read<ThemeProvider>()
                                            .changeColor(Colors.red);
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                  RadioListTile<ThemeMode>(
                                    title: Text('Dark'),
                                    value: ThemeMode.dark,
                                    groupValue: currentMode,
                                    onChanged: (value) {
                                      if (value != null) {
                                        // context.read<ThemeProvider>().setTheme(
                                        //   value,
                                        // );
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                  RadioListTile<ThemeMode>(
                                    title: Text('System Default'),
                                    value: ThemeMode.system,
                                    groupValue: currentMode,
                                    onChanged: (value) {
                                      if (value != null) {
                                        // context.read<ThemeProvider>().setTheme(
                                        //   value,
                                        // );
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),

                    ListTile(
                      title: Text(appLoc.contact_us),
                      tileColor: AppColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        // context.read<HomeProvider>().logout();
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      title: Text(appLoc.feedback),
                      tileColor: AppColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        // Show contact us dialog or navigate to contact page
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(appLoc.about_us),
                      tileColor: AppColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        // Show settings dialog or navigate to settings page
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(appLoc.support),
                      tileColor: AppColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        // Show help dialog or navigate to help page
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(appLoc.privacy_policy),
                      tileColor: AppColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        // Show feedback dialog or navigate to feedback page
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(appLoc.terms_and_conditions),
                      tileColor: AppColor.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onTap: () {
                        // Show terms and conditions dialog or navigate to terms page
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        //  DrawerButtonIcon(
        // elevation: 5,
        // child: ListView(
        //   children: [
        //     DrawerHeader(
        //       child: Text(appLoc.welcome),
        //       decoration: BoxDecoration(color: AppColor.primaryColor),
        //     ),
        //     ListTile(
        //       title: Text("appLoc.changeTheme"),
        //       onTap: () {
        //         // context.read<ThemeProvider>().toggleTheme();
        //         Navigator.pop(context);
        //       },
        //     ),
        //     ListTile(
        //       title: Text("appLoc.changeLanguage"),
        //       onTap: () {
        //         // This will be handled by the dropdown in the app bar
        //         Navigator.pop(context);
        //       },
        //     ),
        //   ],
        // ),
        // ),
      ),
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text(appLoc.welcome),
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  // shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,

                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(5, 5),
                    ),
                    // BoxShadow(
                    //   color: Colors.grey,
                    //   blurRadius: 5,
                    //   spreadRadius: 2,
                    //   offset: const Offset(-5, -5),
                    // ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/app-drawer.png',
                  height: 10,
                  width: 10,
                ),
              ),
            );
          },
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColor.primaryColor,
                      title: const Text("Language"),
                      content: DropdownButton<String>(
                        alignment: Alignment(0, 10),
                        autofocus: true,
                        dropdownColor: AppColor.primaryColor,
                        icon: Icon(Icons.language_outlined),
                        menuWidth: 110.0,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        value: context
                            .watch<Language>()
                            .selectectLocale
                            .languageCode,
                        items: Language.languages
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e['locale'],
                                child: Text(e['name']),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<Language>().changeLanguage(value);
                            print(value);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 10,
                      // spreadRadius: 5,
                      offset: Offset(10, 5),
                    ),
                    // BoxShadow(
                    //   color: Colors.grey.shade500,
                    //   blurRadius: 10,
                    //   // spreadRadius: 5,
                    //   offset: Offset(-10, -5),
                    // ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/translation.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
          // PopupMenuButton(
          //   itemBuilder: (context) {
          //     return [
          //       PopupMenuItem(
          //         child: Text("appLoc.changeTheme"),
          //         onTap: () {
          //           // context.read<ThemeProvider>().toggleTheme();
          //         },
          //       ),
          //       PopupMenuItem(
          //         child: Text("appLoc.changeLanguage"),
          //         onTap: () {
          //           // This will be handled by the dropdown below
          //         },
          //       ),
          //     ];
          //   },
          // ),
          // Theme(
          //   data: Theme.of(context).copyWith(
          //     inputDecorationTheme: const InputDecorationTheme(
          //       border: InputBorder.none,
          //       enabledBorder: InputBorder.none,
          //       focusedBorder: InputBorder.none,
          //       disabledBorder: InputBorder.none,
          //     ),
          //   ),
          //   child: DropdownMenu(
          //     label: FittedBox(child: Text("Lang")),
          //     initialSelection: context.watch<Language>().selectectLocale,
          //     textStyle: TextStyle(color: Colors.red),
          //     dropdownMenuEntries: Language.languages
          //         .map(
          //           (e) =>
          //               DropdownMenuEntry(value: e['locale'], label: e['name']),
          //         )
          //         .toList(),
          //     onSelected: (value) {
          //       context.read<Language>().changeLanguage(value as String);
          //     },
          //   ),
          // ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
