// create user model class

import 'package:equatable/equatable.dart';

class IUser extends Equatable {
  final String uid;
  final String email;
  String? fullName;
  String? birthday;

  IUser({required this.uid, required this.email, this.fullName, this.birthday});

  @override
  List<Object> get props => [uid, email, fullName!, birthday!];

  @override
  bool get stringify => true;

}