import 'package:health_tourism/product/models/clinic.dart';

import '../models/user.dart';

abstract class UserRepo {
  Future<User> getUser(String uid) async {
    // TODO: implement getCustomer
    throw UnimplementedError();
  }
  Future<void> updateUser(User user);
  Future<void> deleteUser(String uid);
  Future<void> createUser(
      User customer) async {}
}