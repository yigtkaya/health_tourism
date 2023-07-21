import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String uid;
  final String email;
  final int age;
  final String fullName;
  final bool alcohol;
  final bool smoke;
  final String medications;
  final String allergies;
  final String previousOperations;
  final String skinDiseases;
  final String chronicConditions;
  final String hairTransplantOperations;

  const Customer(
      {required this.alcohol,
      required this.smoke,
      required this.medications,
      required this.allergies,
      required this.previousOperations,
      required this.skinDiseases,
      required this.chronicConditions,
      required this.hairTransplantOperations,
      required this.uid,
      required this.email,
      required this.fullName,
      required this.age});

  @override
  List<Object> get props => [
        uid,
        email,
        fullName,
        age,
        alcohol,
        smoke,
        medications,
        allergies,
        previousOperations,
        skinDiseases,
        chronicConditions,
        hairTransplantOperations
      ];

  @override
  bool get stringify => true;

  // create functions to read data from/to firestore document
  Customer.fromData(Map<dynamic, dynamic> data) :
        uid = data['uid'],
        email = data['email'],
        fullName = data['fullName'],
        age = data['birthday'],
        alcohol = data['alcohol'],
        smoke = data['smoke'],
        medications = data['medications'],
        allergies = data['allergies'],
        previousOperations = data['previousOperations'],
        skinDiseases = data['skinDiseases'],
        chronicConditions = data['chronicConditions'],
        hairTransplantOperations = data['hairTransplantOperations'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'birthday': age,
      'alcohol': alcohol,
      'smoke': smoke,
      'medications': medications,
      'allergies': allergies,
      'previousOperations': previousOperations,
      'skinDiseases': skinDiseases,
      'chronicConditions': chronicConditions,
      'hairTransplantOperations': hairTransplantOperations
    };
  }
}
