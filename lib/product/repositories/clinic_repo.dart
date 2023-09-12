import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/clinic.dart';

abstract class ClinicRepo {

  Stream<QuerySnapshot> getAllClinics(bool isDescending, double min, double max, String city);
  Future<Clinic> getClinic(String cid) async {
    throw Exception();
  }
}
