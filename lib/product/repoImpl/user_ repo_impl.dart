import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/customer.dart';
import '../repositories/user_repo.dart';

class UserRepositoryImpl extends UserRepo {
  CollectionReference customers =
  FirebaseFirestore.instance.collection("users");
  CollectionReference clinicEntities =
  FirebaseFirestore.instance.collection("clinics");


  @override
  Future<void> createCustomer(
      Customer customer) async {
    final data = await FirebaseFirestore.instance
        .collection("users")
        .doc("iniAcRHUF5HLDjk0IaFh")
        .get();

    if (!data.exists) {
      FirebaseFirestore.instance
          .collection("users")
          .doc("iniAcRHUF5HLDjk0IaFh")
          .set({
        "fullName": customer.fullName,
        "email": customer.email,
        "birthday": customer.age,
        "alcohol": customer.alcohol,
        "smoke": customer.smoke,
        "medications": customer.medications,
        "allergies": customer.allergies,
        "previousOperations": customer.previousOperations,
        "skinDiseases": customer.skinDiseases,
        "chronicConditions": customer.chronicConditions,
        "hairTransplantOperations": customer.hairTransplantOperations,
        "uid": customer.uid
      });
    }
  }

  @override
  Future<void> deleteCustomer(String uid) async {
    customers.doc(uid).delete();
  }

  @override
  Future<Customer> getCustomer() async {
    final data = await customers.doc("iniAcRHUF5HLDjk0IaFh").get();
    Map<dynamic, dynamic> map = data.data() as Map;

    return Customer.fromData(map);
  }

  @override
  Future<void> updateUserData(Customer customer) async {
    /// ve ya saved valueyu sadece değiştiricez. fazla yazım miktarı saymasın diye
    FirebaseFirestore.instance
        .collection("users")
        .doc("iniAcRHUF5HLDjk0IaFh")
        .set({
      "fullName": customer.fullName,
      "email": customer.email,
      "birthday": customer.age,
      "alcohol": customer.alcohol,
      "smoke": customer.smoke,
      "medications": customer.medications,
      "allergies": customer.allergies,
      "previousOperations": customer.previousOperations,
      "skinDiseases": customer.skinDiseases,
      "chronicConditions": customer.chronicConditions,
      "hairTransplantOperations": customer.hairTransplantOperations,
      "uid": customer.uid
    });
  }

}
