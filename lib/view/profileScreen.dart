
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vis_mobile/view/add_vehicle_ui.dart';
import 'package:vis_mobile/view/home_ui.dart';
import 'package:vis_mobile/view/profile.dart';

import '../service/delete_vehicle.dart';
import 'common/drawer.dart';
import 'login_ui.dart';
import 'my_records.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
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
          'My Profile',
        ),
        backgroundColor: Color.fromARGB(255, 29, 112, 238),
      ),
     drawer: const DrawerComponent(),
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          const Expanded(
            flex: 2,
            child: CircleAvatar(
              radius: 105,
              backgroundImage: AssetImage("assets/images/us.jpg"),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      
                    },
                    child: ProfileItem(
                      title: name,
                      icon: Icons.person,
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                      
                      },
                      child:  ProfileItem(
                          title: email, icon: Icons.mail)),
                  GestureDetector(
                    onTap: () async {
                     
                    },
                    child:  ProfileItem(
                      title: nic,
                      icon: Icons.card_membership,
                    ),
                  ),
            
                    
                ],
              ))
        ],
      ),
    );
  }
}