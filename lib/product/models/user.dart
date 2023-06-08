// create user model class

import 'package:equatable/equatable.dart';

class IUser extends Equatable {
  final String uid;
  final String email;
  String? firstName;
  String? lastName;
  String? birthday;

  IUser({required this.uid, required this.email, this.firstName, this.lastName, this.birthday});

  @override
  List<Object> get props => [uid, email, firstName!, lastName!, birthday!];

  @override
  bool get stringify => true;

}