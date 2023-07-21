import 'package:health_tourism/product/models/clinic.dart';

import '../models/customer.dart';

abstract class UserRepo {
  Future<Customer> getCustomer() async {
    // TODO: implement getCustomer
    throw UnimplementedError();
  }
  Future<void> updateUserData(Customer customer);
  Future<void> deleteCustomer(String uid);
  Future<void> createCustomer(
      Customer customer) async {}
}