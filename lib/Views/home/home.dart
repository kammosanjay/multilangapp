// import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multi_localization_app/OSM/osm.dart';
import 'package:multi_localization_app/Views/home/home_providers.dart';
import 'package:multi_localization_app/Views/theme/theme_provider.dart';
import 'package:multi_localization_app/constant/appColor.dart';
import 'package:multi_localization_app/l10n/app_localizations.dart';
import 'package:multi_localization_app/Views/language/language.dart';
import 'package:multi_localization_app/utils/custom_widgets.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    print("build");
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          elevation: 5,
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(appLoc.welcome),
                decoration: BoxDecoration(color: AppColor.primaryColor),
              ),
              ListTile(
                title: Text("appLoc.changeTheme"),
                onTap: () {
                  // context.read<ThemeProvider>().toggleTheme();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("appLoc.changeLanguage"),
                onTap: () {
                  // This will be handled by the dropdown in the app bar
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              width: double.infinity,
              child: SearchLocationScreen(),
            ),

            // Consumer<HomeProviders>(
            //   builder: (ctx, homeProvider, child) {
            //     return ListTile(s
            //       title: Text(
            //         "${AppLocalizations.of(ctx)!.hello} : ${homeProvider.counter.toString()}",
            //         style: CustomWidgets.textstyle(),
            //       ),
            //       onTap: () {
            //         // Handle tap
            //       },
            //     );
            //   },
            // ),
            // Spacer(),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Center(
            //           child: ElevatedButton(
            //             onPressed: () {
            //               context.read<HomeProviders>().incrementCounter();
            //             },
            //             style: CustomWidgets.buttonStyle(height: 20),
            //             child: Text(
            //               "increment",
            //               style: CustomWidgets.textstyle(
            //                 textColor: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Center(
            //           child: ElevatedButton(
            //             onPressed: () {
            //               context.read<HomeProviders>().decrementCounter();
            //               // context.read<HomeProviders>().changeName("New Name");
            //             },
            //             style: CustomWidgets.buttonStyle(
            //               height: 20,
            //               backgroundColor: Colors.red,
            //               textColor: Colors.white,
            //             ),
            //             child: Text(
            //               "decrement",
            //               style: CustomWidgets.textstyle(
            //                 textColor: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
