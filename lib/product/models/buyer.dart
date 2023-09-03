
class Buyer {
  final String id;
  final String name;
  final String sirName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String? ip;
  String? postalCode;
  final String country;

  Buyer({
    required this.id,
    required this.name,
    required this.sirName,
    required this.email,
    this.ip,
    required this.phone,
    required this.address,
    required this.city,
    this.postalCode,
    required this.country,
  });
}