import 'package:intl/intl.dart';

class ClinicEntity {
  String imagePath;
  String titleTxt;
  String subTxt;
  String dateTxt;
  double dist;
  double rating;
  int reviews;
  int perSession;
  double price; // Added property
  bool isSelected;

  ClinicEntity({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dateTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perSession = 180,
    this.price = 0.0, // Added default value
    this.isSelected = false,
  });

  static List<ClinicEntity> clinicList = [
    ClinicEntity(
      imagePath: 'assets/images/clinic_1.jpg',
      titleTxt: 'Wellness Clinic',
      subTxt: 'New York',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perSession: 180,
      price: 150.0, // Added price
      isSelected: true,
      dateTxt:
      '${DateFormat("dd MMM").format(DateTime.now().add(Duration(days: 2)))} - ${DateFormat("dd MMM").format(DateTime.now().add(Duration(days: 8)))}',
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_2.png',
      titleTxt: 'Holistic Healing',
      subTxt: 'Los Angeles',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perSession: 200,
      price: 180.0, // Added price
      isSelected: false,
      dateTxt:
      '${DateFormat("dd MMM").format(DateTime.now().add(Duration(days: 1)))} - ${DateFormat("dd MMM").format(DateTime.now().add(Duration(days: 6)))}',
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_3.png',
      titleTxt: 'Mind and Body',
      subTxt: 'Chicago',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perSession: 60,
      price: 90.0, // Added price
      isSelected: false,
      dateTxt:
      '${DateFormat("dd MMM").format(DateTime.now().add(Duration(days: 3)))} - ${DateFormat("dd MMM").format(DateTime.now().add(Duration(days: 4)))}',
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_4.png',
      titleTxt: 'Wellness Clinic',
      subTxt: 'San Francisco',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perSession: 170,
      price: 200.0, // Added price
      isSelected: false,
      dateTxt:
      '${DateFormat("dd MMM").format(DateTime.now())} - ${DateFormat("dd MMM").format(DateTime.now().add(Duration(days: 2)))}',
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_5.png',
      titleTxt: 'Holistic Healing',
      subTxt: 'Miami',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      price: 120.0, // Added price
      isSelected: false,
      perSession: 200,
      dateTxt:
      '${DateFormat("dd MMM").format(DateTime.now().add(Duration(days: 3)))} - ${DateFormat("dd MMM").format(DateTime.now().add(Duration(days: 5)))}',
    ),
  ];

  static List<ClinicEntity> popularList = [
    ClinicEntity(
      imagePath: 'assets/images/popular_1.jpg',
      titleTxt: 'Wellness Clinic',
    ),
    ClinicEntity(
      imagePath: 'assets/images/popular_2.jpg',
      titleTxt: 'Holistic Healing',
    ),
    ClinicEntity(
      imagePath: 'assets/images/popular_3.jpg',
      titleTxt: 'Mind and Body',
    ),
    ClinicEntity(
      imagePath: 'assets/images/popular_4.jpg',
      titleTxt: 'Wellness Clinic',
    ),
    ClinicEntity(
      imagePath: 'assets/images/popular_5.jpg',
      titleTxt: 'Holistic Healing',
    ),
    ClinicEntity(
      imagePath: 'assets/images/popular_6.jpg',
      titleTxt: 'Mind and Body',
    ),
  ];

  static List<ClinicEntity> reviewsList = [
    ClinicEntity(
      imagePath: 'assets/images/avatar1.jpg',
      titleTxt: 'Alexia Jane',
      subTxt:
      'This clinic is located in a great spot close to shops and bars, very quiet location',
      rating: 8.0,
      dateTxt: 'Last update 21 May, 2019',
    ),
    ClinicEntity(
      imagePath: 'assets/images/avatar3.jpg',
      titleTxt: 'Jacky Depp',
      subTxt:
      'Good staff, very comfortable environment, very quiet location, clinic could do with an update',
      rating: 8.0,
      dateTxt: 'Last update 21 May, 2019',
    ),
    ClinicEntity(
      imagePath: 'assets/images/avatar5.jpg',
      titleTxt: 'Alex Carl',
      subTxt:
      'This clinic is located in a great spot close to shops and bars, very quiet location',
      rating: 6.0,
      dateTxt: 'Last update 21 May, 2019',
    ),
    ClinicEntity(
      imagePath: 'assets/images/avatar2.jpg',
      titleTxt: 'May June',
      subTxt:
      'Good staff, very comfortable environment, very quiet location, clinic could do with an update',
      rating: 9.0,
      dateTxt: 'Last update 21 May, 2019',
    ),
    ClinicEntity(
      imagePath: 'assets/images/avatar4.jpg',
      titleTxt: 'Lesley Rivas',
      subTxt:
      'This clinic is located in a great spot close to shops and bars, very quiet location',
      rating: 8.0,
      dateTxt: 'Last update 21 May, 2019',
    ),
    ClinicEntity(
      imagePath: 'assets/images/avatar6.jpg',
      titleTxt: 'Carlos Lasmar',
      subTxt:
      'Good staff, very comfortable environment, very quiet location, clinic could do with an update',
      rating: 7.0,
      dateTxt: 'Last update 21 May, 2019',
    ),
    ClinicEntity(
      imagePath: 'assets/images/avatar7.jpg',
      titleTxt: 'Oliver Smith',
      subTxt:
      'This clinic is located in a great spot close to shops and bars, very quiet location',
      rating: 9.0,
      dateTxt: 'Last update 21 May, 2019',
    ),
  ];

  static List<ClinicEntity> serviceList = [
    ClinicEntity(
      imagePath: 'assets/images/clinic_service_1.jpg',
      titleTxt: 'General Checkup',
      isSelected: false,
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_service_2.jpg',
      titleTxt: 'Dental Care',
      isSelected: false,
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_service_3.jpg',
      titleTxt: 'Physiotherapy',
      isSelected: false,
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_service_4.jpg',
      titleTxt: 'Mental Health',
      isSelected: false,
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_service_5.jpg',
      titleTxt: 'Alternative Medicine',
      isSelected: false,
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_service_6.jpg',
      titleTxt: 'Specialized Surgery',
      isSelected: false,
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_service_7.jpg',
      titleTxt: 'Rehabilitation',
      isSelected: false,
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_service_8.jpg',
      titleTxt: 'Womens Health',
      isSelected: false,
    ),
    ClinicEntity(
      imagePath: 'assets/images/clinic_service_9.jpg',
      titleTxt: 'Pediatric Care',
      isSelected: false,
    ),
  ];

  static List<ClinicEntity> lastSearchesList = [
    ClinicEntity(
      imagePath: 'assets/images/popular_4.jpg',
      titleTxt: 'Wellness Clinic',
      subTxt: 'New York',
      dateTxt: '12 - 22 Dec',
    ),
    ClinicEntity(
      imagePath: 'assets/images/popular_1.jpg',
      titleTxt: 'Holistic Healing',
      subTxt: 'Los Angeles',
      dateTxt: '12 - 24 Sep',
    ),
    ClinicEntity(
      imagePath: 'assets/images/city_3.jpg',
      titleTxt: 'Mind and Body',
      subTxt: 'Chicago',
      dateTxt: '20 - 22 Sep',
    ),
    ClinicEntity(
      imagePath: 'assets/images/city_4.jpg',
      titleTxt: 'Wellness Clinic',
      subTxt: 'San Francisco',
      dateTxt: '12 - 22 Nov',
    ),
    ClinicEntity(
      imagePath: 'assets/images/city_5.jpg',
      titleTxt: 'Holistic Healing',
      subTxt: 'Miami',
      dateTxt: '10 - 15 Dec',
    ),
    ClinicEntity(
      imagePath: 'assets/images/city_6.jpg',
      titleTxt: 'Mind and Body',
      subTxt: 'Moscow',
      dateTxt: '12 - 14 Dec',
    ),
  ];
}
