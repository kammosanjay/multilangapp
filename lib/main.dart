import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_localization_app/MyPageRoute/myPage_routes.dart';
import 'package:multi_localization_app/MyPageRoute/route_provider.dart';
import 'package:multi_localization_app/Views/Forgot/forgot_page.dart';
import 'package:multi_localization_app/Views/ReportsPage/report_provider.dart';
// Ensure that 'myPage_routes.dart' defines a class named 'MyPageRoutes' with a static 'routes' property.
import 'package:multi_localization_app/Views/home/home_providers.dart';
import 'package:multi_localization_app/Views/home/home.dart';
import 'package:multi_localization_app/Views/home/task_page.dart';
import 'package:multi_localization_app/Views/home/tasklist_page.dart';
import 'package:multi_localization_app/Views/loginpage/login_page.dart';
import 'package:multi_localization_app/Views/signUpPage/signup_page.dart';
import 'package:multi_localization_app/Views/splash/splash_provider.dart';
import 'package:multi_localization_app/Views/splash/splash_screen.dart';
import 'package:multi_localization_app/Views/todolist/todo_provider.dart';
import 'package:multi_localization_app/database/newDatabase.dart';
import 'package:multi_localization_app/firebase_options.dart';
import 'package:multi_localization_app/l10n/app_localizations.dart';
import 'package:multi_localization_app/Views/language/language.dart';
import 'package:multi_localization_app/Views/themeColor.dart';
import 'package:multi_localization_app/Views/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => Language(),
//       child: ChangeNotifierProvider(
//         create: (context) => ThemeProvider(),
//         child: MyApp(),
//       ),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
//         ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),
//         ChangeNotifierProvider<HomeProviders>(create: (_) => HomeProviders()),
//         ChangeNotifierProvider<RouteProvider>(create: (_) => RouteProvider()),
//         ChangeNotifierProvider<TodoProvider>(create: (_) => TodoProvider()),
//         ChangeNotifierProvider<ReportProvider>(create: (_) => ReportProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',

//         supportedLocales: [
//           Locale('en'),
//           Locale('hi'),
//           Locale('es'),
//           Locale('bn'),
//           Locale('ta'),
//           Locale('te'),
//           Locale('mr'),
//           Locale('kn'),
//           Locale('as'),
//           Locale('ur'),
//         ],
//         debugShowCheckedModeBanner: false,
//         localizationsDelegates: [
//           AppLocalizations.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         theme: Provider.of<ThemeProvider>(context).lightTheme,
//         themeMode: Provider.of<ThemeProvider>(context).themeMode,
//         darkTheme: Provider.of<ThemeProvider>(context).darkTheme,

//         locale: context.watch<Language>().selectectLocale,

//         // If 'MyPageRoutes' is not defined, replace with the correct class or variable that holds your route definitions.
//         // home: LoginPage(),
//         routes: {
//           '/': (context) => const SplashScreen(),
//           '/home': (context) => const MyHome(),
//           '/task': (context) => TaskPage(),
//           '/CreateTaskList': (context) => CreateTaskList(),
//           '/loginpage': (context) => LoginPage(),
//           '/forgotpage': (context) => ForgotPage(),
//           '/signUpPage': (context) => SignupPage(),
//         },
//       ),
//     );
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Language>(create: (_) => Language()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),
        ChangeNotifierProvider<HomeProviders>(create: (_) => HomeProviders()),
        ChangeNotifierProvider<RouteProvider>(create: (_) => RouteProvider()),
        ChangeNotifierProvider<TodoProvider>(create: (_) => TodoProvider()),
        ChangeNotifierProvider<ReportProvider>(create: (_) => ReportProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final langProvider = Provider.of<Language>(context, listen: true);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: langProvider.selectectLocale,
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MyHome(),
        '/task': (context) => TaskPage(),
        '/CreateTaskList': (context) => CreateTaskList(),
        '/loginpage': (context) => LoginPage(),
        '/forgotpage': (context) => ForgotPage(),
        '/signUpPage': (context) => SignupPage(),
      },
    );
  }
}
