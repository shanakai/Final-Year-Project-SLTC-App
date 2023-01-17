import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class LoginController {
  
  Future<bool> login( String email, String pass) async {
     final response = await http.post(
      Uri.parse('${ConfigService.BASE_URL}/auth/user/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': pass,
      }),
    );
    print(response.statusCode );
      if (response.statusCode == 200) {
var responseData = json.decode(response.body);
// Obtain shared preferences.
final prefs = await SharedPreferences.getInstance();

await prefs.setInt('uid', responseData['id']);
await prefs.setString('name', responseData['firstName']).toString();
await prefs.setString('email', responseData['email']).toString();
await prefs.setString('nic', responseData['nic']).toString();
  return true; 
  } else {
 return false;
  }

}
}

