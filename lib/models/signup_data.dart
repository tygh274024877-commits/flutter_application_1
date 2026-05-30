// lib/models/signup_data.dart
import 'package:flutter_application_1/core/class/crud.dart';
import 'package:flutter_application_1/core/constant/applink.dart';

class SignupData {
  Crud crud;
  SignupData({required this.crud});

  // تأكدي أن الدالة تستقبل 5 متغيرات هنا
  postdata(name, email, password, confirm, phone) async {
    var response = await crud.postData(Applink().signup, {
      "fullName": name, // يجب أن يكون fullName
      "email": email, // يجب أن يكون email
      "password": password, // يجب أن يكون password
      "confirmPassword": confirm, // يجب أن يكون confirmPassword
      "phoneNumber": phone, // يجب أن يكون phoneNumber
    });
    return response.fold((l) => l, (r) => r);
  }
}
