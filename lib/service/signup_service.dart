import 'dart:convert';
import 'package:http/http.dart' as http;

import 'config.dart';
class SignupController {
  
  Future<bool> createUser(String fname, String lname, String nic,
      String address, String email, String pass) async {
     final response = await http.post(
      Uri.parse('${ConfigService.BASE_URL}/auth/user/signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstName': fname,
        'lastName': lname,
        'nic': nic,
        'address': address,
        'email': email,
        'password': pass,
      }),
    );
    print(response.statusCode );
      if (response.statusCode == 201) {
  return true; 
  } else {
 return false;
  }

}
}