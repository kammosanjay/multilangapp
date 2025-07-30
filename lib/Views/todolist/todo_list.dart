import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_localization_app/Views/Modals/task_modal.dart';
import 'package:multi_localization_app/Views/todolist/todo_provider.dart';
import 'package:multi_localization_app/constant/appColor.dart';
import 'package:multi_localization_app/constant/constant_widget.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unicons/unicons.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  DateTime? _selectedDay = DateTime.now();
  String? selectedOption = 'Low';
  bool ischecked = false;

  ///
  ///
  Widget _buildDayCell(DateTime day, Color bgColor, Color textColor) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat.E().format(day), // Mon, Tue, etc.
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${day.day}',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  showBottomSheet(BuildContext context, {TaskModel? taskToEdit}) {
    // Set initial values only once
    if (taskToEdit != null) {
      _controller.text = taskToEdit.title;
      selectedOption = taskToEdit.priority;
      _selectedDay = taskToEdit.date;
    } else {
      _controller.clear();
      selectedOption = null;
      _selectedDay = DateTime.now();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        Future.delayed(Duration(milliseconds: 200), () {
          // ignore: use_build_context_synchronously
          FocusScope.of(context).requestFocus(_focusNode);
        });
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TableCalendar(
                        firstDay: DateTime(2024, 1, 1),
                        lastDay: DateTime(2028, 12, 31),
                        focusedDay: _selectedDay!,
                        daysOfWeekVisible: false,
                        calendarFormat: CalendarFormat.week,
                        availableCalendarFormats: const {
                          CalendarFormat.week: 'Week',
                        },
                        rowHeight: 60,
                        selectedDayPredicate: (day) =>
                            isSameDay(day, _selectedDay),
                        onDaySelected: (selectedDay, focusedDay) {
                          setModalState(() {
                            _selectedDay = selectedDay;
                          });
                        },
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            return _buildDayCell(
                              day,
                              Colors.white,
                              Colors.black,
                            );
                          },
                          todayBuilder: (context, day, focusedDay) {
                            return _buildDayCell(
                              day,
                              Colors.orange.shade100,
                              Colors.orange,
                            );
                          },
                          selectedBuilder: (context, day, focusedDay) {
                            return _buildDayCell(
                              day,
                              Colors.blue.shade100,
                              Colors.blueAccent,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: CustomWidgets.customTextFeild(
                          context: context,
                          maxLines: 5,
                          focusNode: _focusNode,
                          controller: _controller,
                          hint: 'Add a new task',
                          fillcolor: Colors.grey.shade200,
                          hintColor: AppColor.textColor,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Task Priority',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColor.headingColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildRadio(setModalState, 'Low'),
                          _buildRadio(setModalState, 'Medium'),
                          _buildRadio(setModalState, 'High'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 15,
                        ),
                        child: Row(
                          children: [
                            if (taskToEdit == null)
                              Flexible(
                                child: Consumer<TodoProvider>(
                                  builder: (context, todoProvider, child) {
                                    return CustomWidgets.customButton(
                                      context: context,
                                      onPressed: () {
                                        todoProvider.clearTasks();
                                      },
                                      buttonName: 'Clear',
                                      fontSize: 14,
                                      btnColor: AppColor.primaryColor,
                                      radius: 5,
                                    );
                                  },
                                ),
                              ),

                            const SizedBox(width: 10),
                            Flexible(
                              child: Consumer<TodoProvider>(
                                builder: (context, todoProvider, child) {
                                  return CustomWidgets.customButton(
                                    context: context,
                                    onPressed: () {
                                      if (_controller.text.isEmpty ||
                                          selectedOption == null)
                                        return;

                                      final task = TaskModel(
                                        title: _controller.text,
                                        date: _selectedDay!,
                                        priority: selectedOption!,
                                        index:
                                            taskToEdit?.index ??
                                            DateTime.now()
                                                .millisecondsSinceEpoch,
                                      );

                                      if (taskToEdit != null) {
                                        todoProvider.updateTask(task);
                                      } else {
                                        todoProvider.addTask(task);
                                      }

                                      _controller.clear();
                                      Navigator.pop(context);
                                    },
                                    buttonName: taskToEdit != null
                                        ? "Update"
                                        : 'Add',
                                    fontSize: 14,
                                    btnColor: AppColor.primaryColor,
                                    radius: 5,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRadio(StateSetter setModalState, String value) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: selectedOption,
            onChanged: (val) {
              setModalState(() {
                selectedOption = val;
              });
            },
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColor.headingColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: Colors.grey.shade100,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // bottomSheet(context);
            showBottomSheet(context);
          },
          child: Icon(Icons.add),
        ),

        body: Column(
          children: [
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return Expanded(
                  child: (todoProvider.tasks.isEmpty)
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/lottie/noTask.json',
                                height: 200,
                                width: 200,
                              ),
                              Text(
                                "No Task is added yet.",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: AppColor.textColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: todoProvider.tasks.length,

                          itemBuilder: (context, index) {
                            final task = todoProvider.tasks[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    // elevation: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      color: task.priority == "Low"
                                          ? Colors.amber.shade50
                                          : task.priority == "Medium"
                                          ? Colors.green.shade50
                                          : Colors.red.shade50,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 10,
                                          offset: Offset(3, 3),
                                        ),
                                      ],
                                    ),

                                    child: SizedBox(
                                      height: 80,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 0,
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              leading: Checkbox(
                                                value: task.ischecked,
                                                onChanged: (value) {
                                                  todoProvider.toggleTask(
                                                    index,
                                                  );
                                                },
                                              ),
                                              title: SizedBox(
                                                height: 70,
                                                child: ListView(
                                                  children: [
                                                    Text(
                                                      task.title,
                                                      style: GoogleFonts.poppins(
                                                        decoration:
                                                            task.ischecked
                                                            ? TextDecoration
                                                                  .lineThrough
                                                            : TextDecoration
                                                                  .none,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: AppColor
                                                            .headingColor,
                                                      ),
                                                      // maxLines: 3,
                                                      // overflow:
                                                      // TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Expanded(
                                                child: IconButton(
                                                  icon: const Icon(
                                                    UniconsLine.edit,
                                                    size: 20,
                                                  ),
                                                  onPressed: () {
                                                    print(
                                                      "helo==>" + task.title,
                                                    );
                                                    showBottomSheet(
                                                      context,
                                                      taskToEdit: TaskModel(
                                                        title: task.title,
                                                        date: task.date,
                                                        priority: task.priority,
                                                        index: task.index,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                  icon: const Icon(
                                                    UniconsLine.trash,

                                                    color: Color.fromARGB(
                                                      255,
                                                      240,
                                                      169,
                                                      164,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            "Are You Sure ? You want to delete this task.",
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: AppColor
                                                                  .headingColor,
                                                            ),
                                                          ),
                                                          actions: [
                                                            Row(
                                                              spacing: 10,
                                                              children: [
                                                                Expanded(
                                                                  child: Container(
                                                                    child: CustomWidgets.customButton(
                                                                      context:
                                                                          context,
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          40,
                                                                      btnColor:
                                                                          AppColor
                                                                              .primaryColor,
                                                                      buttonName:
                                                                          "Yes",
                                                                      onPressed: () {
                                                                        todoProvider.removeTask(
                                                                          index,
                                                                        );
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Container(
                                                                    child: CustomWidgets.customButton(
                                                                      context:
                                                                          context,
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          40,

                                                                      buttonName:
                                                                          "No",
                                                                      btnColor:
                                                                          Colors
                                                                              .red,
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      spacing: 10,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Date : ', // First part
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.headingColor,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: task.date
                                                    .toIso8601String()
                                                    .split('T')
                                                    .first,

                                                // text: _selectedDay!
                                                //     .toIso8601String()
                                                //     .split('T')
                                                //     .first,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: task.priority == "Low"
                                                      ? Colors.amber
                                                      : task.priority ==
                                                            "Medium"
                                                      ? Colors.green
                                                      : AppColor.errorColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Priority : ', // First part
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.headingColor,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: task.priority,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: task.priority == "Low"
                                                      ? Colors.amber
                                                      : task.priority ==
                                                            "Medium"
                                                      ? Colors.green
                                                      : AppColor.errorColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
