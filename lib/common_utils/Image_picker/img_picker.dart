import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource src) async {
  ImagePicker _imgPicker = ImagePicker();

  XFile? _file = await _imgPicker.pickImage(source: src);
  if (_file != null) {
    // return File(_file.path); // dart:io isnt available for web
    return await _file.readAsBytes();
  } else {
    Fluttertoast.showToast(msg: "No image Selected");
  }
}
