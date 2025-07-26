import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_localization_app/MyPageRoute/route_provider.dart';
import 'package:multi_localization_app/Views/Forgot/forgot_page.dart';
import 'package:multi_localization_app/Views/signUpPage/signup_page.dart';
import 'package:multi_localization_app/constant/appColor.dart';
import 'package:multi_localization_app/constant/constant_widget.dart';
import 'package:multi_localization_app/utils/custom_widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShown = true;
  TextEditingController passController = TextEditingController();
  TextEditingController phoneEmaiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.transparent,
              
              child: Image.asset('assets/images/softgenLogo.png', height: 100),

              // ),
            ),

            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.track_changes),
                    SizedBox(width: 8),
                    Text(
                      'EATA',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColor.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome User !',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: AppColor.headingColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Employee, e-Attendance & Tracking',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColor.textColor,
                  ),
                ),
                SizedBox(height: 40),
                CustomWidgets.customTextFeild(
                  context: context,
                  label: 'Phone/Email',
                  fontwgt: FontWeight.normal,
                  headingcolor: AppColor.headingColor,
                  hint: 'Phone/Email',

                  hintColor: AppColor.textColor,
                  controller: phoneEmaiController,
                  keyboardtype: TextInputType.emailAddress,
                  icon: Icon(Icons.email),
                ),
                SizedBox(height: 20),
                CustomWidgets.customTextFeild(
                  context: context,
                  label: 'Password',
                  suffIcons: InkWell(
                    onTap: () {
                      setState(() {
                        isShown = !isShown;
                      });
                    },
                    child: isShown
                        ? Icon(Icons.remove_red_eye, color: AppColor.textColor)
                        : Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColor.textColor,
                          ),
                  ),

                  fontwgt: FontWeight.normal,

                  headingcolor: AppColor.headingColor,
                  hint: 'Password',
                  hintColor: AppColor.textColor,
                  controller: passController,
                  isObstructed: isShown,
                  icon: Icon(Icons.lock),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Removes all padding
                      minimumSize: Size(
                        10,
                        10,
                      ), // Optional: removes minimum tap area
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Optional: tight layout
                    ),
                    child: Text("Forgot Password ?"),
                  ),
                ),
                SizedBox(height: 30),
                CustomWidgets.customButton(
                  context: context,
                  height: 55,
                  buttonName: 'Sign In',
                  onPressed: () {
                    context.read<RouteProvider>().navigateTo('/home', context);
                  },
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  btnColor: Colors.indigoAccent,
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    // context.read<RouteProvider>().navigateTo(
                    //   '/signup',
                    //   context,
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an Account? ",
                      style: TextStyle(color: AppColor.textColor, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: AppColor.headingColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: ' 👋', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
