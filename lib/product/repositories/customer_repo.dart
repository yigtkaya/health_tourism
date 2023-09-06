import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

abstract class UserRepo {
  Stream<DocumentSnapshot> getUserSnapshot();
  Future<void> updateUser(Map changes);
  Future<void> deleteUser();
  Future<void> createUser(
      IUser customer) async {}
  Future<void> updateProfilePhoto(String imageUrl) async {}
  Future<void> createAppointment(Map appointment) async {}
}