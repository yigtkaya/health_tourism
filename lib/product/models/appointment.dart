class Appointment {
  final String cid;
  final String clinicName;
  final String clinicCity;
  final String packageName;
  final String operation;
  final String profilePhoto;
  final bool reviewed;
  final DateTime date;
  final DateTime bookedDate;
  final double price;

  Appointment({
    required this.cid,
    required this.clinicName,
    required this.clinicCity,
    required this.packageName,
    required this.operation,
    required this.reviewed,
    required this.bookedDate,
    required this.profilePhoto,
    required this.date,
    required this.price,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      cid: json["cid"],
      clinicName: json['clinicName'],
      clinicCity: json['clinicCity'],
      packageName: json['packageName'],
      operation: json['operation'],
      reviewed: json['reviewed'],
      profilePhoto: json['profilePhoto'],
      date: json['date'].toDate(),
      bookedDate: json['bookedDate'].toDate(),
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cid': cid,
      'clinicName': clinicName,
      'clinicCity': clinicCity,
      'package': packageName,
      'reviewed': reviewed,
      'operation': operation,
      'bookedDate': bookedDate,
      'profilePhoto': profilePhoto,
      'date': date,
      'price': price,
    };
  }
}