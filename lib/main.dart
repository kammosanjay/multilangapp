import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:multi_localization_app/MyPageRoute/myPage_routes.dart';
import 'package:multi_localization_app/MyPageRoute/route_provider.dart';
// Ensure that 'myPage_routes.dart' defines a class named 'MyPageRoutes' with a static 'routes' property.
import 'package:multi_localization_app/Views/home/home_providers.dart';
import 'package:multi_localization_app/Views/home/home.dart';
import 'package:multi_localization_app/Views/home/task_page.dart';
import 'package:multi_localization_app/Views/home/tasklist_page.dart';
import 'package:multi_localization_app/Views/splash/splash_provider.dart';
import 'package:multi_localization_app/Views/splash/splash_screen.dart';
import 'package:multi_localization_app/firebase_options.dart';
import 'package:multi_localization_app/l10n/app_localizations.dart';
import 'package:multi_localization_app/Views/language/language.dart';
import 'package:multi_localization_app/Views/themeColor.dart';
import 'package:multi_localization_app/Views/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => Language(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),
        ChangeNotifierProvider<HomeProviders>(create: (_) => HomeProviders()),
        ChangeNotifierProvider<RouteProvider>(create: (_) => RouteProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',

        supportedLocales: [
          Locale('en'),
          Locale('hi'),
          Locale('es'),
          Locale('bn'),
          Locale('ta'),
          Locale('te'),
          Locale('mr'),
          Locale('kn'),
          Locale('as'),
          Locale('ur'),
        ],
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeProvider().themeData,
        locale: context.watch<Language>().selectectLocale,

        // If 'MyPageRoutes' is not defined, replace with the correct class or variable that holds your route definitions.
        // home: SplashScreen(),
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const MyHome(),
          '/task': (context) => TaskPage(),
          '/CreateTaskList': (context) => CreateTaskList(),
        },
      ),
    );
  }
}
