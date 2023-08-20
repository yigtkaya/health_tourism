import 'package:equatable/equatable.dart';

class Clinic extends Equatable {
  final String cid;
  final String name;
  final String about;
  final String city;
  final String country;
  final String address;
  final String email;
  final String profilePicture;
  final List<String> imageUrls;
  final List<String> operationImageUrls;
  final List<Map> packages;
  final List<Map> reviews;
  final int reviewCount;
  final int averageRating;
  final String role;

  const Clinic({
    required this.cid,
    required this.name,
    required this.about,
    required this.city,
    required this.country,
    required this.address,
    required this.email,
    required this.profilePicture,
    required this.imageUrls,
    required this.operationImageUrls,
    required this.packages,
    required this.reviews,
    required this.reviewCount,
    required this.averageRating,
    required this.role,
  });

  List<Object> get props => [
        cid,
        name,
        about,
        city,
        country,
        address,
        email,
        profilePicture,
        imageUrls,
        operationImageUrls,
        packages,
        reviews,
        reviewCount,
        role,
      ];

  bool get stringify => true;

  Clinic.fromData(Map<dynamic, dynamic> data)
      : cid = data['cid'],
        name = data['name'],
        about = data['about'],
        city = data['city'],
        country = data['country'],
        address = data['clinicAddress'],
        email = data['email'],
        profilePicture = data['profilePicture'],
        imageUrls = data['imageUrls'],
        operationImageUrls = data['operationImageUrls'],
        packages = data['packages'],
        reviews = data['reviews'],
        reviewCount = data['reviewCount'],
        averageRating = data['averageRating'],
        role = data['role'];

  Map<String, dynamic> toMap() {
    return {
      'cid': cid,
      'name': name,
      'about': about,
      'city': city,
      'country': country,
      'clinicAddress': address,
      'email': email,
      'profilePicture': profilePicture,
      'imageUrls': imageUrls,
      'operationImageUrls': operationImageUrls,
      'packages': packages,
      'reviews': reviews,
      'reviewCount': reviewCount,
      'averageRating': averageRating,
      'role': role,
    };
  }
}
