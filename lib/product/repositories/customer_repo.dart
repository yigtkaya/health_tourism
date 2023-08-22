import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

abstract class UserRepo {
  Stream<DocumentSnapshot> getUserSnapshot(String uid);
  Future<void> updateUser(Map changes);
  Future<void> deleteUser(String uid);
  Future<void> createUser(
      User customer) async {}
  Future<void> updateProfilePhoto(
      String uid, String imageUrl) async {}
}