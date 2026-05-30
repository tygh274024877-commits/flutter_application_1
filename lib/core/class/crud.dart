import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/core/class/statusrequest.dart';
import 'package:flutter_application_1/core/functions/checkinternet.dart';

class Crud {
  // دالة GET لجلب البيانات
  Future<Either<StatusRequest, Map>> getdata(String linkurl) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(linkurl));
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      print("خطأ في دالة GET: $e");
      return const Left(StatusRequest.serverExpition);
    }
  }

  // دالة POST معدلة لدعم JSON (لحل مشكلة الاتصال مع النود)
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkurl),
          body: jsonEncode(data), // تحويل الـ Map إلى JSON
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          print("Server Error: ${response.statusCode} - ${response.body}");
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      print("Error in postData: $e");
      return const Left(StatusRequest.serverExpition);
    }
  }

  // دالة DELETE
  Future<Either<StatusRequest, Map>> deleteData(
    String linkurl,
    Map? data,
  ) async {
    try {
      if (await checkInternet()) {
        var response = await http.delete(
          Uri.parse(linkurl),
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"},
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverExpition);
    }
  }

  // دالة PUT
  Future<Either<StatusRequest, Map>> putData(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.put(
          Uri.parse(linkurl),
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"},
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverExpition);
    }
  }

  // دالة PATCH
  Future<Either<StatusRequest, Map>> patchData(String linkurl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.patch(
          Uri.parse(linkurl),
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"},
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverExpition);
    }
  }
}
