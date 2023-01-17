import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vis_mobile/service/RecordsModes.dart';

import 'config.dart';


class FetchOwnRecords {
  var data = [];
  String id='';
  List<Record> results = [];

  Future<List<Record>> getRecordList() async {
    final prefs = await SharedPreferences.getInstance();
     id = (prefs.getInt('uid') ?? '').toString();
    String fetchUrl =
        "${ConfigService.BASE_URL}/records/userRecords/?oid=$id";
    var url = Uri.parse(fetchUrl);
    var response = await http.get(url);
print(response.statusCode );
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print(data );
        results = data.map((e) => Record.fromJson(e)).toList();
      } else {
        print("Error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
