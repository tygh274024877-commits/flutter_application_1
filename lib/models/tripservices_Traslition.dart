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
    title: "book_full_trip",
    imagepath: "assets/images/BookaFullTrip.png",
    routepage: "/fullbooktrip",
  ),
  Tripservice(
    title: "travel_services",
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
      title: 'flights',
      icon: Icons.airplanemode_active,
      routepath: '/flights',
    ),
    ServiceModel(
      id: 2,
      title: 'hotels',
      icon: Icons.hotel,
      routepath: '/hotels',
    ),
    ServiceModel(
      id: 3,
      title: 'cars',
      icon: Icons.directions_car,
      routepath: '/cars',
    ),
    ServiceModel(
      id: 4,
      title: 'restaurants',
      icon: Icons.restaurant_rounded,
      routepath: '/resturants',
    ),
  ];
}
