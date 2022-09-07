import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/services/fireauth/fire_auth.dart';

class StorageMethods {
  final FirebaseStorage _storageService = FirebaseStorage.instance;

  Future uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    final uid = FireAuth().getCurrentUser()!.uid;
    final storageRef = _storageService.ref().child(childName).child(uid);
    TaskSnapshot snap = await storageRef.putData(file);
    String url = await snap.ref.getDownloadURL();
    return url;
  }
}
