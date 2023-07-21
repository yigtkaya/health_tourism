import 'package:health_tourism/product/models/clinic.dart';

import '../models/customer.dart';

abstract class ClinicRepo {

  Future<Clinic> getClinicEntity() async {
    throw UnimplementedError();
  }
  Future<void> updateClinicEntityData(Clinic clinicEntity);
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
