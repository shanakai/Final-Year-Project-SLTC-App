import 'dart:convert';
import 'package:http/http.dart' as http;

import 'config.dart';
class VehicleController {
  
  Future<bool> addVehicle(int oid, String oname, String nic,
  
      String cn, String vn, String vt) async {
     final response = await http.post(
      Uri.parse('${ConfigService.BASE_URL}/vehicle/add/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
    'ownerId' : oid.toString(),
      'ownerName' : oname,
      'ownerNic': nic,
      'chacyNumber': cn,
      'vehicleNumber': vn,
      'vehicleType': vt,
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