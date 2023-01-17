import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../view/home_ui.dart';
import 'config.dart';
class PaymentUpdate {
String rid='';
  void updatePayment() async {
    final prefs = await SharedPreferences.getInstance();
    rid = (prefs.getString('recordId') ?? '');
 
    final response = await http.post(
      Uri.parse('${ConfigService.BASE_URL}/records/payment?id=$rid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );
    Get.to(() => HomeScreen());

  }
}