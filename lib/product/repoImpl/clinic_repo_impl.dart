import 'package:health_tourism/product/repositories/clinic_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicRepositoryImpl extends ClinicRepo {

  CollectionReference clinicCollection =
  FirebaseFirestore.instance.collection("clinics");

  @override
  Stream<QuerySnapshot> getAllClinics(bool isDescending, double min, double max, String city) {
    if(city.isNotEmpty) {
      return clinicCollection
          .where("city", isEqualTo: city)
          .where("averageRating", isGreaterThanOrEqualTo: min, isLessThanOrEqualTo: max)
          .orderBy("averageRating", descending: isDescending)
          .snapshots();
    }
    return clinicCollection
    .where("averageRating", isGreaterThanOrEqualTo: min, isLessThanOrEqualTo: max)
        .orderBy("averageRating", descending: isDescending)
        .snapshots();
  }
}
