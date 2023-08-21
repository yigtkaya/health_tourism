import 'package:health_tourism/product/models/clinic.dart';

import '../models/user.dart';

abstract class UserRepo {
  Future<User> getCustomer() async {
    // TODO: implement getCustomer
    throw UnimplementedError();
  }
  Future<void> updateCustomerData(User customer);
  Future<void> deleteCustomer(String uid);
  Future<void> createUser(
      User customer) async {}
}