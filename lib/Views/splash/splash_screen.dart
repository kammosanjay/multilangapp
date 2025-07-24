import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen_bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_localization_app/Views/splash/splash_provider.dart';
import 'package:multi_localization_app/constant/appColor.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PageController _pageController;
  List<Widget>? slideList;
  int? initialPage;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [

  //           Image.asset(
  //             'assets/images/student_as.png', // Replace with your splash image
  //             width: 200,
  //             height: 200,
  //           ),
  //           const SizedBox(height: 20),
  //           const Text(
  //             'Welcome to Multi Localization App',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryColor, Colors.yellow],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GFIntroScreen(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.amber,
          // borderRadius: BorderRadius.circular(40),
          // border: Border.all(color: Colors.grey),
          slides: slides(),
          pageController: _pageController,
          introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
            pageController: _pageController,
            pageCount: slideList!.length,
            currentIndex: initialPage!,
            backButtonText: 'Previous',
            forwardButton: const Icon(Icons.arrow_forward, color: Colors.white),
            backButton: const Icon(Icons.arrow_back, color: Colors.white),

            forwardButtonText: 'Next',
            skipButtonText: 'Skip',
            doneButtonText: 'Done',
            onDoneTap: () {
              context.read<SplashProvider>().initializeApp(context);
            },
            onSkipTap: () {
              context.read<SplashProvider>().initializeApp(context);
            },
            doneButton: const Icon(Icons.check, color: Colors.white),
            navigationBarHeight: 55,
            navigationBarWidth: double.infinity,
            navigationBarShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            navigationBarColor: AppColor.primaryColor,
            showDivider: true,
            dotHeight: 10,
            dotWidth: 10,
            dotShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            // inActiveColor: Colors.grey[200],
            activeColor: GFColors.SUCCESS,
            inactiveColor: GFColors.WHITE,
            dotMargin: EdgeInsets.symmetric(horizontal: 6),
            showPagination: true,
          ),
          currentIndex: initialPage!,
          pageCount: _pageController.initialPage,
        ),
      ),
    );
  }

  List<Widget> slides() {
    slideList = [
      ListView(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Lottie.asset(
                'assets/lottie/business.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  text: 'Welcome to ',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 44, 43, 43),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '"Before we dive into the final app flow, I’d like to propose adding a short intro or onboarding screen — something users see only once when they open the app for the first time. The goal is to quickly highlight the app’s main benefits like scanning QR codes for cashback, tracking rewards, and navigating the dashboard. This helps users immediately understand what the app offers without needing a demo or support.',
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 44, 43, 43),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      ListView(
        children: [
          Center(
            child: Container(
              child: Lottie.asset(
                'assets/lottie/Meeting.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  text:
                      'This app is designed to help you manage your tasks efficiently.',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 44, 43, 43),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          ' You can easily create, edit, and delete tasks, set reminders, and track your progress.',
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 44, 43, 43),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      ListView(
        children: [
          Center(
            child: Container(
              child: Lottie.asset(
                'assets/lottie/gpsnavigation.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  text:
                      'The app also allows you to set priorities for your tasks, so you can focus on what’s most important.',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 44, 43, 43),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          ' You can also view your tasks in a list or calendar format, making it easy to see what needs to be done.',
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 44, 43, 43),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ];
    return slideList!;
  }
}
