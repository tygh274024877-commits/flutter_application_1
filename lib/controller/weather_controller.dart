import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherController extends GetxController {
  // --- النصوص المترجمة ---
  var cityName = "loading_location".tr.obs;
  var temperature = "--".obs;
  var weatherCondition = "loading".tr.obs;
  var iconUrl = "".obs;
  var humidity = "--".obs;
  var windSpeed = "--".obs;
  var feelsLike = "--".obs;
  var isLoading = true.obs;

  // --- البيانات والتحكم ---
  final TextEditingController searchController = TextEditingController();
  var suggestions = <String>[].obs;
  var forecastList = <dynamic>[].obs;
  var hourlyList = <dynamic>[].obs;

  var isNight = false.obs;
  var isRaining = false.obs;
  var isManualSearch = false.obs;

  final String _apiKey = dotenv.env['WEATHER_API_KEY'] ?? "";

  // --- إدارة المحافظات (بيانات برمجية) ---
  final List<String> _arGovernorates = [
    "دمشق",
    "حلب",
    "حمص",
    "اللاذقية",
    "طرطوس",
    "حماة",
    "السويداء",
    "درعا",
    "القنيطرة",
    "دير الزور",
    "الحسكة",
    "الرقة",
    "الغاب",
    "ريف دمشق",
  ];

  final List<String> _enGovernorates = [
    "Damascus",
    "Aleppo",
    "Homs",
    "Latakia",
    "Tartus",
    "Hama",
    "As-Suwayda",
    "Daraa",
    "Quneitra",
    "Deir ez-Zor",
    "Al-Hasakah",
    "Ar-Raqqah",
    "Al-Ghab",
    "Rural Damascus",
  ];

  List<String> get translatedGovernorates =>
      _currentLang == 'ar' ? _arGovernorates : _enGovernorates;

  // --- دالة مساعدة للغة ---
  String get _currentLang => Get.locale?.languageCode ?? 'ar';

  @override
  void onInit() {
    super.onInit();
    determinePositionAndFetchWeather();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // --- العمليات ---
  Future<void> fetchWeatherByCityAndArea(
    String governorate,
    String area,
  ) async {
    if (_apiKey.isEmpty) return;
    try {
      isLoading(true);
      String country = _currentLang == 'ar' ? 'سوريا' : 'Syria';
      String query = "$area, $governorate, $country";

      final String url =
          "https://api.weatherapi.com/v1/forecast.json?key=$_apiKey&q=$query&days=7&lang=$_currentLang";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _parseWeatherData(data);
        cityName.value = "$governorate، $area";
        isManualSearch(true);
      } else {
        Get.snackbar("warning".tr, "error_finding_area".tr);
      }
    } catch (e) {
      print("Search Error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchWeatherByCityName(String city) async {
    if (_apiKey.isEmpty) return;
    try {
      isLoading(true);
      String country = _currentLang == 'ar' ? 'سوريا' : 'Syria';
      final String url =
          "https://api.weatherapi.com/v1/forecast.json?key=$_apiKey&q=$city, $country&days=7&lang=$_currentLang";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _parseWeatherData(data);
        cityName.value = city;
        isManualSearch(true);
      }
    } catch (e) {
      print("City Search Error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> determinePositionAndFetchWeather() async {
    try {
      isLoading(true);
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await fetchWeatherByCoordinates(position.latitude, position.longitude);
      await _getExactAddress(position.latitude, position.longitude);
    } catch (e) {
      await fetchWeatherByCityName("Damascus".tr);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchWeatherByCoordinates(double lat, double lon) async {
    final String url =
        "https://api.weatherapi.com/v1/forecast.json?key=$_apiKey&q=$lat,$lon&days=7&lang=$_currentLang";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _parseWeatherData(jsonDecode(response.body));
    }
  }

  void _parseWeatherData(dynamic data) {
    temperature.value = (data['current']?['temp_c'] ?? 0).round().toString();
    weatherCondition.value =
        data['current']?['condition']?['text'] ?? "unknown".tr;
    iconUrl.value = "https:${data['current']?['condition']?['icon'] ?? ""}";
    humidity.value = (data['current']?['humidity'] ?? "--").toString();
    windSpeed.value = (data['current']?['wind_kph'] ?? "--").toString();
    feelsLike.value = (data['current']?['feelslike_c'] ?? 0).round().toString();
    forecastList.value = data['forecast']?['forecastday'] ?? [];
    hourlyList.value = data['forecast']?['forecastday']?[0]?['hour'] ?? [];
  }

  Future<void> _getExactAddress(double lat, double lon) async {
    try {
      await setLocaleIdentifier(_currentLang);
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String governorate = (place.administrativeArea ?? "")
            .replaceAll(RegExp(r'محافظة|مدينة|Governorate|City'), '')
            .trim();
        String locality = (place.subLocality ?? place.locality ?? "")
            .replaceAll(RegExp(r'محافظة|مدينة|منطقة|City|District'), '')
            .trim();
        cityName.value = locality.isNotEmpty
            ? "$governorate، $locality"
            : governorate;
      }
    } catch (e) {
      cityName.value = "Damascus".tr;
    }
  }
}
