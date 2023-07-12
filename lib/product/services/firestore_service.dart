import 'package:health_tourism/product/models/customer.dart';
import 'package:health_tourism/product/services/firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../product/services/firebase_auth_service.dart';

class FirestoreService extends FirestoreRepository {
  CollectionReference customers = FirebaseFirestore.instance.collection("users");
  final FirebaseAuthService _authRepository = FirebaseAuthService();

  @override
  Future<void> createCustomer(
      String uid,
      String email,
      int birthday,
      String fullName,
      bool alcohol,
      bool smoke,
      String medications,
      String allergies,
      String previousOperations,
      String skinDiseases,
      String chronicConditions,
      String hairTransplantOperations) async {
    final data = await FirebaseFirestore.instance
        .collection("users")
        .doc( "iniAcRHUF5HLDjk0IaFh")
        .get();

    if (!data.exists) {
      FirebaseFirestore.instance
          .collection("users")
          .doc( "iniAcRHUF5HLDjk0IaFh")
          .set({
        "fullName": fullName,
        "email": email,
        "birthday": birthday,
        "alcohol": alcohol,
        "smoke": smoke,
        "medications": medications,
        "allergies": allergies,
        "previousOperations": previousOperations,
        "skinDiseases": skinDiseases,
        "chronicConditions": chronicConditions,
        "hairTransplantOperations": hairTransplantOperations,
        "uid": uid
      });
    }
  }

  @override
  Future<void> deleteCustomer(String uid) async {
    customers.doc(uid).delete();
  }

  @override
  Future<Customer> getCustomer() async {
    final data = await customers.doc( "iniAcRHUF5HLDjk0IaFh").get();
    Map<dynamic, dynamic> map = data.data() as Map;

    return Customer.fromData(map);
  }

  @override
  Future<void> updateUserData(Customer customer) async {
    /// ve ya saved valueyu sadece değiştiricez. fazla yazım miktarı saymasın diye
    FirebaseFirestore.instance
        .collection("users")
        .doc( "iniAcRHUF5HLDjk0IaFh")
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
