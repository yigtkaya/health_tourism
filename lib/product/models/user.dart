// create user model class

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String birthday;

  User({required this.uid, required this.email, required this.firstName, required this.lastName, required this.birthday});

  @override
  List<Object> get props => [uid, email, firstName, lastName, birthday];

  @override
  bool get stringify => true;

}