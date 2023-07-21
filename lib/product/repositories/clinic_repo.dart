import 'package:health_tourism/product/models/clinic.dart';

import '../models/customer.dart';

abstract class ClinicRepo {

  Future<Clinic> getClinicEntity() async {
    throw UnimplementedError();
  }
  Future<void> updateClinicEntityData(Clinic clinic);
  Future<void> deleteClinicEntity(String cid);
  Future<void> createClinic(Clinic clinic);
}
