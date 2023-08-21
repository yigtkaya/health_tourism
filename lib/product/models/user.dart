import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final Timestamp birthday;
  final String profilePhoto;
  final String name;
  final String surname;
  final String alcoholOrSmoke;
  final String supplements;
  final String medications;
  final String allergies;
  final String surgeryHistory;
  final String skinDiseases;
  final String chronicConditions;
  final String hairTransplantOperations;

  const User(
      {required this.supplements,
      required this.alcoholOrSmoke,
      required this.surname,
      required this.profilePhoto,
      required this.medications,
      required this.allergies,
      required this.surgeryHistory,
      required this.skinDiseases,
      required this.chronicConditions,
      required this.hairTransplantOperations,
      required this.uid,
      required this.email,
      required this.name,
      required this.birthday});

  @override
  List<Object> get props => [
        uid,
        email,
        name,
        birthday,
        profilePhoto,
        surname,
        allergies,
        surgeryHistory,
        skinDiseases,
        chronicConditions,
        hairTransplantOperations,
        alcoholOrSmoke,
        supplements,
        medications,
      ];

  @override
  bool get stringify => true;

  // create functions to read data from/to firestore document
  User.fromData(Map<dynamic, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        name = data['name'],
        surname = data['surname'],
        birthday = data['birthday'],
        profilePhoto = data['photoURL'],
        supplements = data['supplements'],
        alcoholOrSmoke = data['alcoholOrSmoke'],
        medications = data['medications'],
        allergies = data['allergies'],
        surgeryHistory = data['surgeryHistory'],
        skinDiseases = data['skinDiseases'],
        chronicConditions = data['chronicConditions'],
        hairTransplantOperations = data['hairTransplantOperations'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'birthday': birthday,
      'photoURL': profilePhoto,
      'supplements': supplements,
      'alcoholOrSmoke': alcoholOrSmoke,
      'medications': medications,
      'allergies': allergies,
      'previousOperations': surgeryHistory,
      'skinDiseases': skinDiseases,
      'chronicConditions': chronicConditions,
      'hairTransplantOperations': hairTransplantOperations
    };
  }
}
