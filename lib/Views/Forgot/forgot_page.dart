import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_localization_app/Views/loginpage/login_page.dart';
import 'package:multi_localization_app/constant/appColor.dart';
import 'package:multi_localization_app/constant/constant_widget.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  bool isShown = true;
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
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
                        color: AppColor.textColor(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome User !',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: AppColor.textColor(context),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Employee, e-Attendance & Tracking',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColor.textColor(context),
                  ),
                ),
                SizedBox(height: 40),
                CustomWidgets.customTextFeild(
                  context: context,
                  label: 'New Password',
                  fontwgt: FontWeight.normal,
                  headingcolor: AppColor.textColor(context),
                  hint: 'New Password',
                  // isObstructed: isShown,
                  hintColor: AppColor.textColor(context),
                  controller: oldPassController,
                  keyboardtype: TextInputType.emailAddress,
                  icon: Icon(Icons.email),
                ),
                SizedBox(height: 20),
                CustomWidgets.customTextFeild(
                  context: context,
                  label: 'Confirm Password',
                  suffIcons: InkWell(
                    onTap: () {
                      setState(() {
                        isShown = !isShown;
                      });
                    },
                    child: isShown
                        ? Icon(Icons.remove_red_eye, color: AppColor.textColor(context))
                        : Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColor.textColor(context),
                          ),
                  ),

                  fontwgt: FontWeight.normal,

                  headingcolor: AppColor.textColor(context),
                  hint: 'Confirm Password',
                  hintColor: AppColor.textColor(context),
                  controller: newPassController,
                  isObstructed: isShown,
                  icon: Icon(Icons.lock),
                ),

                SizedBox(height: 30),
                CustomWidgets.customButton(
                  context: context,
                  height: 55,
                  buttonName: 'Submit',
                  onPressed: () {},
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "If password remember ! ",
                      style: TextStyle(color: AppColor.textColor(context), fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            color: AppColor.textColor(context),
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
