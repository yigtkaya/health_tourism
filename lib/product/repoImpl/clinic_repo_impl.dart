import 'package:health_tourism/product/models/clinic.dart';
import 'package:health_tourism/product/repositories/clinic_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicRepositoryImpl extends ClinicRepo {

  CollectionReference clinicEntities =
      FirebaseFirestore.instance.collection("clinics");

  Future<List<Clinic>> getClinicData() async {
    QuerySnapshot querySnapshot =  await clinicEntities.get();
    final list = querySnapshot.docs.map((doc) => Clinic.fromData(doc.data() as Map<String, dynamic>)).toList();
    return list;
  }

  Clinic clinicFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Clinic.fromData(data);
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
  Future<void> updateClinicEntityData(Clinic clinicEntity) async {
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
