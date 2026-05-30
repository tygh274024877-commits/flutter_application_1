import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/models/place_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GlobalSearchController extends GetxController {
  final String baseUrl = "http://YOUR_API_URL/api";

  var hotels = <Place>[].obs;
  var restaurants = <Place>[].obs;
  var landmarks = <Place>[].obs;
  var isLoading = false.obs;

  Timer? _debounce;

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      hotels.clear();
      restaurants.clear();
      landmarks.clear();
      return;
    }

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) async {
    isLoading.value = true;
    try {
      final results = await Future.wait([
        http.get(Uri.parse("$baseUrl/hotels?search=$query")),
        http.get(Uri.parse("$baseUrl/restaurants?search=$query")),
        http.get(Uri.parse("$baseUrl/landmarks?search=$query")),
      ]);

      if (results[0].statusCode == 200) {
        List<dynamic> hotelData = json.decode(results[0].body);
        hotels.assignAll(hotelData.map((e) => Place.fromJson(e)).toList());
      }
      if (results[1].statusCode == 200) {
        List<dynamic> restData = json.decode(results[1].body);
        restaurants.assignAll(restData.map((e) => Place.fromJson(e)).toList());
      }
      if (results[2].statusCode == 200) {
        List<dynamic> landData = json.decode(results[2].body);
        landmarks.assignAll(landData.map((e) => Place.fromJson(e)).toList());
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
