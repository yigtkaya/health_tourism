class Appointment {
  final String clinicName;
  final String clinicCity;
  final String package;
  final String operation;
  final String profilePhoto;
  final bool reviewed;
  final DateTime date;
  final DateTime bookedDate;
  final double price;

  Appointment({
    required this.clinicName,
    required this.clinicCity,
    required this.package,
    required this.operation,
    required this.reviewed,
    required this.bookedDate,
    required this.profilePhoto,
    required this.date,
    required this.price,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      clinicName: json['clinicName'],
      clinicCity: json['clinicCity'],
      package: json['package'],
      operation: json['operation'],
      reviewed: json['review'],
      profilePhoto: json['clinicProfilePhoto'],
      date: json['date'].toDate(),
      bookedDate: json['bookedDate'].toDate(),
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinicName': clinicName,
      'clinicCity': clinicCity,
      'package': package,
      'review': reviewed,
      'operation': operation,
      'bookedDate': bookedDate,
      'clinicProfilePhoto': profilePhoto,
      'date': date,
      'price': price,
    };
  }
}