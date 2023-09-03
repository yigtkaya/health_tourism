import 'package:health_tourism/product/models/clinic.dart';
import 'package:health_tourism/product/repositories/clinic_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicRepositoryImpl extends ClinicRepo {

  CollectionReference clinicCollection =
  FirebaseFirestore.instance.collection("clinics");

  @override
  Stream<QuerySnapshot> getAllClinics() {
    return clinicCollection.snapshots();
  }

}
