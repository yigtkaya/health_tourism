import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ClinicRepo {

  Stream<QuerySnapshot> getAllClinics(bool isDescending, double min, double max, String city);
}
