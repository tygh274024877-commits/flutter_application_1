import 'package:flutter/material.dart';

class Tripservice {
  final String title;
  final String imagepath;
  final String routepage;
  Tripservice({
    required this.title,
    required this.imagepath,
    required this.routepage,
  });
}

final List<Tripservice> Services = [
  Tripservice(
    title: "book_full_trip", // يتم ربطه بمفتاح الترجمة داخل الـ View
    imagepath: "assets/images/BookaFullTrip.png",
    routepage: "/fullbooktrip",
  ),
  Tripservice(
    title: "travel_services", // يتم ربطه بمفتاح الترجمة داخل الـ View
    imagepath: "assets/images/TravelServices.png",
    routepage: "/servicesselect",
  ),
];

class ServiceModel {
  final int id;
  final String title;
  final IconData icon;
  final String routepath;

  ServiceModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.routepath,
  });

  static final List<ServiceModel> servicesList = [
    ServiceModel(
      id: 1,
      title: 'flights', // مفتاح ترجمة الطيران
      icon: Icons.airplanemode_active,
      routepath: '/flights',
    ),
    ServiceModel(
      id: 2,
      title: 'hotels', // مفتاح ترجمة الفنادق
      icon: Icons.hotel,
      routepath: '/hotels',
    ),
    ServiceModel(
      id: 3,
      title: 'cars', // مفتاح ترجمة السيارات
      icon: Icons.directions_car,
      routepath: '/cars',
    ),
    ServiceModel(
      id: 4,
      title: 'restaurants', // مفتاح ترجمة المطاعم
      icon: Icons.restaurant_rounded,
      routepath: '/resturants',
    ),
  ];
}
