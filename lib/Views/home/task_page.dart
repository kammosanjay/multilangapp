import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_localization_app/constant/appColor.dart';
import 'package:multi_localization_app/constant/constant_widget.dart';
import 'package:multi_localization_app/utils/custom_widgets.dart';

class TaskPage extends StatefulWidget {
  TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var tasklistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor(context),
          title: Text(
            'New Meeting',
            style: TextStyle(color: AppColor.headingColor(context)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomWidgets.customTextFeild(
                context: context,
                hint: 'Task list',
                hintColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Color(0xFFeffdff),
                controller: tasklistController,
                maxLines: 10,
                fillcolor: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFFeffdff)
                    : Color(0xFFeffdff),
                keyboardtype: TextInputType.text,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: CustomWidgets.customButton(
                  context: context,
                  width: 150,
                  height: 30,
                  radius: 5.0,
                  btnColor: AppColor.buttonColor(context),
                  buttonName: 'Submit',
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          SnackBar(
                            content: Text(
                              "Task Created Successfully!",
                              style: MyCustomWidgets.textstyle(
                                textColor: AppColor.textColor(context),
                              ),
                            ),
                            backgroundColor: AppColor.primaryColor(context),
                            elevation: 5,
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.only(
                              bottom: 20,
                              left: 16,
                              right: 16,
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        )
                        .closed
                        .then((_) {
                          Navigator.pop(
                            context,
                            true,
                          ); // Navigate back after snackbar disappears
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
