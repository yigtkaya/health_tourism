import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user.dart';
import '../repositories/customer_repo.dart';
import 'package:path/path.dart' as Path;


class UserRepositoryImpl extends UserRepo {
  CollectionReference users =
  FirebaseFirestore.instance.collection("users");


  @override
  Future<void> createUser(
      User user) async {
    final data = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    if (!data.exists) {
      FirebaseFirestore.instance
          .collection("users")
          .doc()
          .set({
        "name": user.name,
        "surname": user.surname,
        "email": user.email,
        "birthday": user.birthday.toDate(),
        "photoURL": user.profilePhoto,
        "alcoholOrSmoke": user.alcoholOrSmoke,
        "supplements": user.supplements,
        "medications": user.medications,
        "allergies": user.allergies,
        "surgeryHistory": user.surgeryHistory,
        "skinDiseases": user.skinDiseases,
        "chronicConditions": user.chronicConditions,
        "hairTransplantOperations": user.hairTransplantOperations,
        "uid": user.uid
      });
    }
  }

  @override
  Future<void> deleteUser(String uid) async {
    users.doc(uid).delete();
  }

  @override
  Stream<DocumentSnapshot> getUserSnapshot(String uid) {
    return users.doc(uid).snapshots();
  }

  @override
  Future<void> updateUser(User user) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set({
      "name": user.name,
      "surname": user.surname,
      "email": user.email,
      "birthday": user.birthday.toDate(),
      "photoURL": user.profilePhoto,
      "alcoholOrSmoke": user.alcoholOrSmoke,
      "supplements": user.supplements,
      "medications": user.medications,
      "allergies": user.allergies,
      "previousOperations": user.surgeryHistory,
      "skinDiseases": user.skinDiseases,
      "chronicConditions": user.chronicConditions,
      "hairTransplantOperations": user.hairTransplantOperations,
      "uid": user.uid
    });
  }

  @override
  Future<void> updateProfilePhoto(String uid, String photoURL) async {

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({
      "photoURL": photoURL,
    });
  }

  Future<String> uploadImageToFirebase(File file, String uid) async {
    String fileUrl = '';
    String fileName = Path.basename(file.path);
    var reference =
    FirebaseStorage.instance.ref().child('userImages/$uid/$fileName');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref
        .getDownloadURL()
        .then((value) => {fileUrl = value});

    print('URL: $fileUrl');
    return fileUrl;
  }
}
