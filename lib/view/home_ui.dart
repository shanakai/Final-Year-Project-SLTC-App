import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vis_mobile/service/delete_vehicle.dart';

import '../service/config.dart';
import 'common/drawer.dart';
import 'my_records.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  String name = '';
  String email = '';
  late Future<List<Vehicle>> futurePost;
  var id;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? '');
      email = (prefs.getString('email') ?? '');
      id = (prefs.getInt('uid') ?? '');
    });
  }

  Future<List<Vehicle>> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('${ConfigService.BASE_URL}/vehicle/owners/?oid=$id'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Vehicle.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    DeleteController dv = DeleteController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Vehicles',
        ),
        backgroundColor: const Color.fromARGB(255, 29, 112, 238),
      ),
      drawer: const DrawerComponent(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(
                  /// Just an example, but this makes sure, that since you set a fixed width like 300.0, on small screens this won't get too big. For example by setting a maxWidth constraint like this, its width will be 300.0, but at max as big as 1 / 3 of the screen width so it gets smaller on small screen sizes
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Center(
                  child: FutureBuilder<List<Vehicle>>(
                    future: fetchAlbum(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.94,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  color: Colors.white70,
                                  elevation: 10,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.11,
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.11,
                                          ),
                                          child: Image.asset(
                                              'assets/images/car.png',
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                              child: RichText(
                                                  text: TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                style: const TextStyle(
                                                  fontSize: 13.8,
                                                ),
                                                children: <TextSpan>[
                                                  const TextSpan(
                                                      text: 'Vehicle Number: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              4,
                                                              27,
                                                              236))),
                                                  TextSpan(
                                                    text: snapshot.data![index]
                                                        .vehicleNumber,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 10, 0, 0),
                                              child: RichText(
                                                  text: TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 13.0,
                                                ),
                                                children: <TextSpan>[
                                                  const TextSpan(
                                                      text: 'Vehicle Type: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              4,
                                                              27,
                                                              236))),
                                                  TextSpan(
                                                    text: snapshot.data![index]
                                                        .vehicleType,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 10, 0, 0),
                                              child: RichText(
                                                  text: TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                style: const TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  const TextSpan(
                                                      text: 'Chacy Number:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              4,
                                                              27,
                                                              236))),
                                                  TextSpan(
                                                    text: snapshot.data![index]
                                                        .chacyNumber,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      13, 40, 0, 2),
                                              child: IconButton(
                                                onPressed: () {
                                                  true ==
                                                          dv.deleteVehicle(
                                                              snapshot
                                                                  .data![index]
                                                                  .id)
                                                      ? showAlertDialog(context)
                                                      : showAlertDialog(
                                                          context);
                                                },
                                                icon: const Icon(
                                                  Icons.delete_rounded,
                                                  color: Color.fromARGB(
                                                      255, 233, 4, 4),
                                                  size: 45,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

List<Vehicle> postFromJson(String str) =>
    List<Vehicle>.from(json.decode(str).map((x) => Vehicle.fromMap(x)));

class Vehicle {
  Vehicle({
    required this.chacyNumber,
    required this.vehicleNumber,
    required this.vehicleType,
    required this.id,
  });

  int id;
  String vehicleNumber;
  String chacyNumber;
  String vehicleType;

  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        chacyNumber: json["chacyNumber"],
        vehicleNumber: json["vehicleNumber"],
        vehicleType: json["vehicleType"],
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chacyNumber'] = chacyNumber;
    data['vehicleNumber'] = vehicleNumber;
    data['vehicleType'] = vehicleType;
    return data;
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(" Success"),
    content: const Text("Vehicle Deleted"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
