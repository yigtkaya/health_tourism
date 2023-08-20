import 'package:health_tourism/product/models/clinic.dart';
import 'package:health_tourism/product/repositories/clinic_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicRepositoryImpl extends ClinicRepo {

  CollectionReference clinicCollection =
      FirebaseFirestore.instance.collection("clinics");

  Future<List<Clinic>> getClinicData() async {
    QuerySnapshot querySnapshot =  await clinicCollection.get();
    final list = querySnapshot.docs.map((doc) => Clinic.fromData(doc.data() as Map<String, dynamic>)).toList();
    return list;
  }

  Stream<QuerySnapshot> getAllClinics() {
    return clinicCollection.snapshots();
  }

  Clinic clinicFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Clinic.fromData(data);
  }

  @override
  Future<void> createClinic(
      Clinic clinic) async {
    await clinicCollection.doc(clinic.cid).set({
      "operationPhotosPath": clinic.operationPhotosPath,
      "videoPath": clinic.videoPath,
      "titleTxt": clinic.titleTxt,
      "subTxt": clinic.subTxt,
      "dateTxt": clinic.dateTxt,
      "packages": clinic.packages,
      "rating": clinic.rating,
      "reviews": clinic.reviews,
      "price": clinic.price,
    });
  }

  @override
  Future<void> deleteClinicEntity(String cid) async {
    // TODO: implement deleteClinicEntity
    clinicCollection.doc(cid).delete();
  }

  @override
  Future<void> updateClinicEntityData(Clinic clinicEntity) async {
    await clinicCollection.doc(clinicEntity.cid).update({
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
