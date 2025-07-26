import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
  final TextEditingController _controller = TextEditingController();

  DateTime? _selectedDay = DateTime.now();

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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        String? selectedOption = 'Low';
        DateTime? _selectedDay = DateTime.now(); // local to bottom sheet

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
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
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    onDaySelected: (selectedDay, focusedDay) {
                      setModalState(() {
                        _selectedDay = selectedDay;
                      });
                    },
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        return _buildDayCell(day, Colors.white, Colors.black);
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
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Low',
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setModalState(() {
                                  selectedOption = value;
                                });
                              },
                            ),
                            Text(
                              'Low',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColor.headingColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Medium',
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setModalState(() {
                                  selectedOption = value;
                                });
                              },
                            ),
                            Text(
                              'Medium',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColor.headingColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'High',
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setModalState(() {
                                  selectedOption = value;
                                });
                              },
                            ),
                            Text(
                              'High',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColor.headingColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Expanded(
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
                                  width: 80,
                                  height: 40,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Consumer<TodoProvider>(
                              builder: (context, todoProvider, child) {
                                return CustomWidgets.customButton(
                                  context: context,
                                  onPressed: () {
                                    if (_controller.text.isNotEmpty) {
                                      todoProvider.addTask(_controller.text);
                                      _controller.clear();
                                    }
                                    Navigator.pop(context);
                                  },
                                  buttonName: 'Add',
                                  fontSize: 14,
                                  btnColor: AppColor.primaryColor,
                                  radius: 5,
                                  width: 80,
                                  height: 40,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // void bottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) {
  //       String? selectedOption = 'Low'; // Initial priority
  //       DateTime? _selectedDay = DateTime.now();
  //       return StatefulBuilder(
  //         builder: (context, setModalState) {
  //           return Container(
  //             height: 500,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(16),
  //                 topRight: Radius.circular(16),
  //               ),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 TableCalendar(
  //                   firstDay: DateTime(2024, 1, 1),
  //                   lastDay: DateTime(2028, 12, 31),
  //                   focusedDay: _selectedDay!,
  //                   daysOfWeekVisible: false,
  //                   calendarFormat: CalendarFormat.week,
  //                   availableCalendarFormats: const {
  //                     CalendarFormat.week: 'Week',
  //                   },
  //                   rowHeight: 60,
  //                   selectedDayPredicate: (day) {
  //                     return isSameDay(day, _selectedDay);
  //                   },
  //                   onDaySelected: (selectedDay, focusedDay) {
  //                     setState(() {
  //                       _selectedDay = selectedDay;
  //                     });
  //                   },
  //                   calendarBuilders: CalendarBuilders(
  //                     defaultBuilder: (context, day, focusedDay) {
  //                       return _buildDayCell(day, Colors.white, Colors.black);
  //                     },
  //                     todayBuilder: (context, day, focusedDay) {
  //                       return _buildDayCell(
  //                         day,
  //                         Colors.orange.shade100,
  //                         Colors.orange,
  //                       );
  //                     },
  //                     selectedBuilder: (context, day, focusedDay) {
  //                       return _buildDayCell(
  //                         day,
  //                         Colors.blue.shade100,
  //                         Colors.blueAccent,
  //                       );
  //                     },
  //                   ),
  //                 ),

  //                 const SizedBox(height: 1),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                   child: CustomWidgets.customTextFeild(
  //                     context: context,
  //                     maxLines: 5,
  //                     controller: _controller,
  //                     hint: 'Add a new task',
  //                     fillcolor: Colors.grey.shade200,
  //                     hintColor: AppColor.textColor,
  //                     onTap: () {
  //                       FocusScope.of(context).unfocus();
  //                     },
  //                     width: MediaQuery.of(context).size.width,
  //                     height: 80,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 10),
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 10.0),
  //                   child: Text(
  //                     'Task Priority',
  //                     style: GoogleFonts.poppins(
  //                       fontSize: 14,
  //                       color: AppColor.headingColor,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 5),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           Radio<String>(
  //                             value: 'Low',
  //                             groupValue: selectedOption,
  //                             onChanged: (value) {
  //                               setModalState(() {
  //                                 selectedOption = value;
  //                               });
  //                             },
  //                           ),
  //                           Text(
  //                             'Low',
  //                             style: GoogleFonts.poppins(
  //                               fontSize: 12,
  //                               color: AppColor.headingColor,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           Radio<String>(
  //                             value: 'Medium',
  //                             groupValue: selectedOption,
  //                             onChanged: (value) {
  //                               setModalState(() {
  //                                 selectedOption = value;
  //                               });
  //                             },
  //                           ),
  //                           Text(
  //                             'Medium',
  //                             style: GoogleFonts.poppins(
  //                               fontSize: 12,
  //                               color: AppColor.headingColor,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Row(
  //                         children: [
  //                           Radio<String>(
  //                             value: 'High',
  //                             groupValue: selectedOption,
  //                             onChanged: (value) {
  //                               setModalState(() {
  //                                 selectedOption = value;
  //                               });
  //                             },
  //                           ),
  //                           Text(
  //                             'High',
  //                             style: GoogleFonts.poppins(
  //                               fontSize: 12,
  //                               color: AppColor.headingColor,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Expanded(
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //                     child: Row(
  //                       children: [
  //                         Expanded(
  //                           child: Consumer<TodoProvider>(
  //                             builder: (context, todoProvider, child) {
  //                               return CustomWidgets.customButton(
  //                                 context: context,
  //                                 onPressed: () {
  //                                   todoProvider.clearTasks();
  //                                 },
  //                                 buttonName: 'Clear',
  //                                 fontSize: 14,
  //                                 btnColor: AppColor.primaryColor,
  //                                 radius: 5,
  //                                 width: 80,
  //                                 height: 40,
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                         const SizedBox(width: 10),
  //                         Expanded(
  //                           child: Consumer<TodoProvider>(
  //                             builder: (context, todoProvider, child) {
  //                               return CustomWidgets.customButton(
  //                                 context: context,
  //                                 onPressed: () {
  //                                   if (_controller.text.isNotEmpty) {
  //                                     todoProvider.addTask(_controller.text);
  //                                     _controller.clear();
  //                                   }
  //                                   Navigator.pop(context);
  //                                 },
  //                                 buttonName: 'Add',
  //                                 fontSize: 14,
  //                                 btnColor: AppColor.primaryColor,
  //                                 radius: 5,
  //                                 width: 80,
  //                                 height: 40,
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final tasklist = context.watch<TodoProvider>().tasks;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: Colors.grey.shade100,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // bottomSheet(context);
            _showBottomSheet(context);
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
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                  color: Colors.white,
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  child: SizedBox(
                                    height: 100,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            leading: Checkbox(
                                              value: task.startsWith('✓ '),
                                              onChanged: (value) {
                                                todoProvider.toggleTask(index);
                                              },
                                            ),
                                            title: Text(
                                              task,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: AppColor.headingColor,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Expanded(
                                              child: IconButton(
                                                icon: const Icon(
                                                  UniconsLine.edit,
                                                ),
                                                onPressed: () => "",
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
                                                onPressed: () => todoProvider
                                                    .removeTask(index),
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
                                    horizontal: 12.0,
                                  ),
                                  child: Text(
                                    "data",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: AppColor.headingColor,
                                    ),
                                  ),
                                ),
                              ],
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
