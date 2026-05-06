// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:ghina/core/class/statusrequest.dart';
// import 'package:ghina/core/constant/applink.dart';
// import 'package:ghina/core/functions/checkinternet.dart';
// import 'package:http/http.dart' as http;

// class Crud {
//   Future<Either<StatusRequest, String>> getdata(String linkurl) async {
//     try {
//       if (await checkInternet()) {
//         var response = await http.get(Uri.parse(linkurl));
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           var responsebody = jsonEncode(response);
//           return Right(responsebody);
//         } else {
//           return const Left(StatusRequest.serverfailure);
//         }
//       } else {
//         return const Left(StatusRequest.offlinefailure);
//       }
//     } catch (_) {
//       return const Left(StatusRequest.serverExpition);
//     }
//   }

//   Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
//     try {
//       if (await checkInternet()) {
//         var response = await http.post(Uri.parse(linkurl), body: data);
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Map responsebody = jsonDecode(response.body);
//           print(responsebody);
//           return Right(responsebody);
//         } else {
//           return const Left(StatusRequest.serverfailure);
//         }
//       } else {
//         return const Left(StatusRequest.offlinefailure);
//       }
//     } catch (_) {
//       return const Left(StatusRequest.serverExpition);
//     }
//   }

//   Future<Either<StatusRequest, Map>> deleteData(
//     String linkurl,
//     Map? data,
//   ) async {
//     try {
//       if (await checkInternet()) {
//         var response = await http.delete(Uri.parse(linkurl), body: data);
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Map responsebody = jsonDecode(response.body);
//           print(responsebody);
//           return Right(responsebody);
//         } else {
//           return const Left(StatusRequest.serverfailure);
//         }
//       } else {
//         return const Left(StatusRequest.offlinefailure);
//       }
//     } catch (_) {
//       return const Left(StatusRequest.serverExpition);
//     }
//   }

//   Future<Either<StatusRequest, Map>> putData(String linkurl, Map data) async {
//     try {
//       if (await checkInternet()) {
//         var response = await http.put(Uri.parse(linkurl), body: data);
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Map responsebody = jsonDecode(response.body);
//           print(responsebody);
//           return Right(responsebody);
//         } else {
//           return const Left(StatusRequest.serverfailure);
//         }
//       } else {
//         return const Left(StatusRequest.offlinefailure);
//       }
//     } catch (_) {
//       return const Left(StatusRequest.serverExpition);
//     }
//   }

//   //////////////////////////// PATCH API /////////////////////////////////////
//   Future<Either<StatusRequest, Map>> patchData(String linkurl, Map data) async {
//     try {
//       if (await checkInternet()) {
//         var response = await http.patch(Uri.parse(linkurl), body: data);
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Map responsebody = jsonDecode(response.body);
//           print(responsebody);
//           return Right(responsebody);
//         } else {
//           return const Left(StatusRequest.serverfailure);
//         }
//       } else {
//         return const Left(StatusRequest.offlinefailure);
//       }
//     } catch (_) {
//       return const Left(StatusRequest.serverExpition);
//     }
//   }
// }
