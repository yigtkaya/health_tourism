import 'package:health_tourism/product/models/clinic.dart';

import '../models/customer.dart';

abstract class UserRepo {
  Future<User> getCustomer() async {
    // TODO: implement getCustomer
    throw UnimplementedError();
  }
  Future<void> updateCustomerData(User customer);
  Future<void> deleteCustomer(String uid);
  Future<void> createCustomer(
      User customer) async {}
}