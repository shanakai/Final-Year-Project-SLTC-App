import 'dart:convert';
import 'package:http/http.dart' as http;

import 'config.dart';
class DeleteController {
  
  Future<bool> deleteVehicle(int vid) async {
    print( " Vehicle -----------------------ftbhthfrthr");
     print(vid  );
     final response = await http.delete(
      Uri.parse('${ConfigService.BASE_URL}/vehicle/delete/?vid=$vid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      
    );
 
      if (response.statusCode == 200) {
  return true; 
  } else {
 return false;
  }

}
}