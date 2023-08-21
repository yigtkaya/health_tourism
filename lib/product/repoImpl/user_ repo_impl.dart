import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../repositories/customer_repo.dart';

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
  Future<User> getUser(String uid) async {
    final data = await users.doc(uid).get();
    Map<dynamic, dynamic> map = data.data() as Map;

    return User.fromData(map);
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
}
