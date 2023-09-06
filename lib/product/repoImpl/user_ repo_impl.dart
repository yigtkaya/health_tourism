import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user.dart';
import '../repositories/customer_repo.dart';
import 'package:path/path.dart' as Path;


class UserRepositoryImpl extends UserRepo {
  CollectionReference users =
  FirebaseFirestore.instance.collection("users");
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> createUser(
      IUser user) async {
    final data = await users
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
  Future<void> deleteUser() async {
    users.doc(uid).delete();
  }

  Future<String> getUserName() async {
    final data = await users.doc(uid).get();
    Map<String, dynamic> user = data.data() as Map<String , dynamic>;
    return user["name"];
  }
  @override
  Stream<DocumentSnapshot> getUserSnapshot() {
    return users.doc(uid).snapshots();
  }

  @override
  Future<void> updateUser(Map changes) async {
    try {
      print(changes.keys);
      Map<String, dynamic> map = Map<String, dynamic>.from(changes);
      await users.doc(changes["uid"]).update(map);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Future<void> updateProfilePhoto(String photoURL) async {
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

  @override
  Future<void> createAppointment(Map appointment) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      'appointments' : FieldValue.arrayUnion([appointment])
    });
  }
}
