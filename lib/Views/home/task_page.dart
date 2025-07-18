import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:multi_localization_app/constant/appColor.dart';
import 'package:multi_localization_app/constant/constant_widget.dart';
import 'package:multi_localization_app/utils/custom_widgets.dart';

class TaskPage extends StatefulWidget {
  bool? islogin = true;
  TaskPage({super.key, this.islogin});

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
          backgroundColor: AppColor.primaryColor,
          title: Text('New Meeting', style: MyCustomWidgets.textstyle()),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomWidgets.customTextFeild(
                context: context,
                hint: 'Task list',
                controller: tasklistController,
                maxLines: 10,
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
                  btnColor: AppColor.primaryColor,
                  buttonName: 'Submit',
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          SnackBar(
                            content: Text(
                              "Task Created Successfully!",
                              style: MyCustomWidgets.textstyle(
                                textColor: AppColor.textColor,
                              ),
                            ),
                            backgroundColor: AppColor.primaryColor,
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
                          Navigator.of(
                            context,
                          ).pop(); // Navigate back after snackbar disappears
                        });

                    // Navigator.of(context).pop(tasklistController.text);
                    print("task=>${tasklistController.text}");
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
