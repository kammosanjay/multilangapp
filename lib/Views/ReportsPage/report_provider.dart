import 'package:flutter/widgets.dart';
import 'package:multi_localization_app/database/newDatabase.dart';

class ReportProvider with ChangeNotifier {
  //
  final DataBaseHelper _dBHelper = DataBaseHelper.getInstance;

  List<Map<String, dynamic>> _list = [];

  List<Map<String, dynamic>> get getList {
    return _list;
  }

  Future<void> insertData() async {
    await _dBHelper.insert();

    print(getList.length);
    notifyListeners();
  }

  Future<void> fetchReport() async {
    _list = await _dBHelper.fetch();
    print(_list);
    notifyListeners();
  }
}
