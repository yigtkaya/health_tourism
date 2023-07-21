import 'package:equatable/equatable.dart';

class Clinic extends Equatable {
  final String cid;
  final String operationPhotosPath;
  final String videoPath;
  final String titleTxt;
  final String subTxt;
  final String dateTxt;
  final String packages;
  final double rating;
  final double reviews;
  final double price;

  const Clinic({
    required this.cid,
    required this.operationPhotosPath,
    required this.videoPath,
    required this.titleTxt,
    required this.subTxt,
    required this.dateTxt,
    required this.packages,
    required this.reviews,
    required this.rating,
    required this.price,
  });

  List<Object> get props => [
    cid,
    operationPhotosPath,
    videoPath,
    titleTxt,
    subTxt,
    dateTxt,
    packages,
    reviews,
    rating,
    price,
  ];

  bool get stringify => true;

  Clinic.fromData(Map<dynamic, dynamic> data) :
        cid = data['cid'],
        operationPhotosPath = data['operationPhotosPath'],
        videoPath=data['videoPath'],
        titleTxt = data['titleTxt'],
        subTxt = data['subTxt'],
        dateTxt = data['dateTxt'],
        packages=data['packages'],
        reviews = data['reviews'],
        rating = data['rating'],
        price = data['price'] as double;


  Map<String, dynamic> toMap () {
    return {
      'cid' : cid,
      'operationPhotosPath': operationPhotosPath,
      'videoPath':videoPath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dateTxt': dateTxt,
      'packages':packages,
      'reviews': reviews,
      'rating': rating,
      'price': price,};
    }
  }







