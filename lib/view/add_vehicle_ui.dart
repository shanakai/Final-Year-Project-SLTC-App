import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vis_mobile/view/FadeAnimation.dart';
import 'package:vis_mobile/view/home_ui.dart';
import 'package:vis_mobile/view/profileScreen.dart';
import 'package:vis_mobile/view/sing_up_ui.dart';

import '../service/add_vehicle.dart';
import '../service/delete_vehicle.dart';
import 'common/drawer.dart';
import 'login_ui.dart';
import 'my_records.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  AddVehicleScreenState createState() {
    return AddVehicleScreenState();
  }
}

class AddVehicleScreenState extends State<AddVehicleScreen> {
  String name = '';
  String email = '';
  String nic= '';
   TextEditingController cn = TextEditingController();
  TextEditingController vn = TextEditingController();
  TextEditingController vp = TextEditingController();
  bool _validate = false;
  var id;
  @override
  void initState() {
    super.initState();
    _loadUser();
    super.initState();
  }

  void _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? '');
      email = (prefs.getString('email') ?? '');
      id = (prefs.getInt('uid') ?? '');
      nic = (prefs.getString('nic') ?? '');
    });
  }

  var vtype;

  @override
  Widget build(BuildContext context) {
     final ButtonStyle style = ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        textStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
    DeleteController dv = DeleteController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add New Vehicle',
        ),
        backgroundColor: Color.fromARGB(255, 29, 112, 238),
      ),
     drawer: const DrawerComponent(),
       body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
          Container(
            height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill)),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 30,
                  width: 80,
                  height: 60,
                  child: FadeAnimation(
                      1,
                      Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/car.png'))),
                      )),
                ),
                Positioned(
                  child: FadeAnimation(
                      1.6,
                      Container(
                        child: const Center(
                          child: Text(
                            "Add Vehicle",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                FadeAnimation(
                    1.8,
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            const BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: TextField(
                              controller: cn,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: _validate
                                      ? 'Chacy Number Can\'t Be Empty'
                                      : null,
                                  hintText: "Chacy Number",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: TextField(
                              controller: vn,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: _validate
                                      ? 'Vehicle Number Can\'t Be Empty'
                                      : null,
                                  hintText: "Vehicle Number",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                 isExpanded: true,
                hint: Text("Select Vehile Type"),
                value: vtype,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    vtype = newValue;
                  });
                },
                 items: <String>['Car', 'Bus', 'Van', 'Lorry'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
                            ),
                          ),
                          
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    style: style,
                    onPressed: ()  async  {
                       if (vn.text.isNotEmpty &&
                            vtype.toString().isNotEmpty &&
                            cn.text.isNotEmpty 
                           ) {
                               setState(() async {
                                 VehicleController   vc = VehicleController  ();
                              if(await vc.addVehicle(id, name, nic, cn.text, vn.text, vtype)){
                                    showAlertDialog(context);
                              }else{
                                 showWorningDialog(context);
                              }
                               }
                               );
                        } 
                      setState(() {
                     
                          vn.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          vp.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          cn.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                         
                        
                      });
                    },
                    child: const Text('Add Vehicle'),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
               
              ],
            ),
          )
        ]))));
  }
  
showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () { 
       Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreen()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Success"),
    content: const Text("Vehicle Added"),
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

 
showWorningDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () { 
       Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignupScreen()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Faild"),
    content: const Text("Something goes wrong"),
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
  }


