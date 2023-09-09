import 'package:health_tourism/product/repositories/clinic_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/clinic.dart';

class ClinicRepositoryImpl extends ClinicRepo {

  CollectionReference clinics =
  FirebaseFirestore.instance.collection("clinics");

  @override
  Stream<QuerySnapshot> getAllClinics(bool isDescending, double min, double max, String city) {
    if(city.isNotEmpty) {
      return clinics
          .where("city", isEqualTo: city)
          .where("averageRating", isGreaterThanOrEqualTo: min, isLessThanOrEqualTo: max)
          .orderBy("averageRating", descending: isDescending)
          .snapshots();
    }
    return clinics
    .where("averageRating", isGreaterThanOrEqualTo: min, isLessThanOrEqualTo: max)
        .orderBy("averageRating", descending: isDescending)
        .snapshots();
  }

  @override
  Future<Clinic> getClinic(String cid) async {
    final data = await clinics.doc(cid).get();
    Map<dynamic, dynamic> map = data.data() as Map<dynamic, dynamic>;

    return Clinic.fromData(map);
  }
}
