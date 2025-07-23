import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeProviders with ChangeNotifier {
  int _counter = 0;
  String _name = "sdfsfsd";
  int get counter => _counter;
  String get name => _name;
  XFile? _image;
  XFile? get image => _image;
  FilePickerResult? result;
  FilePickerResult? get resultFile => result;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  String changeName(String newName) {
    if (newName.isNotEmpty) {
      _name = newName;
      notifyListeners();
    }
    return _name;
  }

  final ImagePicker _imagePicker = ImagePicker();
  Future<XFile?> pickImage() async {
    try {
      _image = await _imagePicker.pickImage(source: ImageSource.gallery);
      notifyListeners();
      return _image;
    } catch (e) {
      debugPrint("Error picking image: $e");
      return null;
    }
  }

  Future<XFile?> pickImageFromCamera() async {
    try {
      _image = await _imagePicker.pickImage(source: ImageSource.camera);
      notifyListeners();
      return _image;
    } catch (e) {
      debugPrint("Error picking image from camera: $e");
      return null;
    }
  }

  Future<List<PlatformFile>?> pickFiles() async {
    try {
      result = await FilePicker.platform.pickFiles();
      if (result != null && result!.files.isNotEmpty) {
        notifyListeners();
        return result!.files;
      }
      return null;
    } catch (e) {
      debugPrint("Error picking files: $e");
      return null;
    }
  }
}
