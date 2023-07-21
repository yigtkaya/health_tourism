import 'package:health_tourism/product/models/clinic.dart';
import 'package:health_tourism/product/models/customer.dart';
import 'package:health_tourism/product/services/firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../product/services/firebase_auth_service.dart';

class FirestoreService extends FirestoreRepository {
  CollectionReference customers =
      FirebaseFirestore.instance.collection("users");
  CollectionReference clinicEntities =
      FirebaseFirestore.instance.collection("clinics");

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
        .doc("iniAcRHUF5HLDjk0IaFh")
        .get();

    if (!data.exists) {
      FirebaseFirestore.instance
          .collection("users")
          .doc("iniAcRHUF5HLDjk0IaFh")
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

  Future<List<ClinicEntity>> getClinicData() async {
    QuerySnapshot querySnapshot =  await clinicEntities.get();
    final list = querySnapshot.docs.map((doc) => ClinicEntity.fromData(doc.data() as Map<String, dynamic>)).toList();
    return list;
  }

  ClinicEntity clinicFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ClinicEntity.fromData(data);
  }

  @override
  Future<void> createClinic(
      String cid,
      String operationPhotosPath,
      String videoPath,
      String titleTxt,
      String subTxt,
      String dateTxt,
      String packages,
      double rating,
      int reviews,
      double price) async {
    await clinicEntities.doc(cid).set({
      "operationPhotosPath": operationPhotosPath,
      "videoPath": videoPath,
      "titleTxt": titleTxt,
      "subTxt": subTxt,
      "dateTxt": dateTxt,
      "packages": packages,
      "rating": rating,
      "reviews": reviews,
      "price": price,
    });
  }

  @override
  Future<void> deleteClinicEntity(String cid) async {
    // TODO: implement deleteClinicEntity
    clinicEntities.doc(cid).delete();
  }

  @override
  Future<void> updateClinicEntityData(ClinicEntity clinicEntity) async {
    await clinicEntities.doc(clinicEntity.cid).update({
      "operationPhotosPath": clinicEntity.operationPhotosPath,
      "videoPath": clinicEntity.videoPath,
      "titleTxt": clinicEntity.titleTxt,
      "subTxt": clinicEntity.subTxt,
      "dateTxt": clinicEntity.dateTxt,
      "packages": clinicEntity.packages,
      "rating": clinicEntity.rating,
      "reviews": clinicEntity.reviews,
      "price": clinicEntity.price,
    });
  }
}
