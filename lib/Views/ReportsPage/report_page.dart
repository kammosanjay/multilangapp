import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_localization_app/Views/ReportsPage/report_provider.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // StreamController<List<Map<String, dynamic>>> streamController =
  //     StreamController<List<Map<String, dynamic>>>();

  void initState() {
    super.initState();
    // Fetch data once the widget is loaded
    Future.delayed(Duration.zero, () {
      context.read<ReportProvider>().fetchReport();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<ReportProvider>(
              builder: (context, reportProvider, child) {
                if (reportProvider != null) {
                  return ListView.builder(
                    itemCount: reportProvider.getList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Text(
                          reportProvider.getList[index]['id'].toString(),
                        ),
                        title: Text(reportProvider.getList[index]['title']),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              context.read<ReportProvider>().insertData();
            },
            child: Text("insert"),
          ),
        ],
      ),
    );
  }
}
