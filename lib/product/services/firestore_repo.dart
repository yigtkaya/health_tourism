import 'package:health_tourism/product/models/clinics-entity.dart';

import '../models/customer.dart';

abstract class FirestoreRepository {
  Future<Customer> getCustomer() async {
    // TODO: implement getCustomer
    throw UnimplementedError();
  }
  Future<void> updateUserData(Customer customer);
  Future<void> deleteCustomer(String uid);
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
      String hairTransplantOperations);

  Future<ClinicEntity> getClinicEntity() async {
    throw UnimplementedError();
  }

  Future<void> updateClinicEntityData(ClinicEntity clinicEntity);
  Future<void> deleteClinicEntity(String cid);
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
    double price,
  );
}
