import 'package:health_tourism/product/repositories/clinic_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicRepositoryImpl extends ClinicRepo {

  CollectionReference clinics =
  FirebaseFirestore.instance.collection("clinics");

  @override
  Stream<QuerySnapshot> getAllClinics(bool isDescending, double min, double max,
      String city, String searchKey) {
    if (searchKey.isEmpty) {
      if (city.isEmpty) {
        return clinics
            .where("averageRating", isGreaterThanOrEqualTo: min,
            isLessThanOrEqualTo: max)
            .orderBy("averageRating", descending: isDescending)
            .snapshots();
      } else {
        return clinics
            .where("city", isEqualTo: city)
            .where("averageRating", isGreaterThanOrEqualTo: min,
            isLessThanOrEqualTo: max)
            .orderBy("averageRating", descending: isDescending)
            .snapshots();
      }
    } else {
      searchKey = capitalize(searchKey);
      return clinics
            .orderBy("name", descending: isDescending)
            .startAt([searchKey])
            .endAt(['$searchKey\uf8ff'])
            .snapshots();
    }
  }

  String capitalize(String text) {
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }
}
