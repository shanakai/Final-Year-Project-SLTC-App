import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../add_vehicle_ui.dart';
import '../home_ui.dart';
import '../login_ui.dart';
import '../my_records.dart';
import '../profileScreen.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({super.key});

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  String name = '';
  String email = '';
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
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: const BoxDecoration(color: Color(0xff764abc)),
              accountName: Text(
                '$name',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                '$email',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // ignore: unnecessary_const
              currentAccountPicture: const CircleAvatar(
                radius: 50.0,
                backgroundColor: Color.fromARGB(255, 232, 235, 238),
                backgroundImage: NetworkImage(
                    "https://img.icons8.com/fluency/512/guest-male.png"),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.train,
              ),
              title: const Text('Add vehicle'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddVehicleScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.report,
              ),
              title: const Text('My Records'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const MyRecordsScreen()));
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 200),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                    });
                  },
                  child: const Text('Logout', style: TextStyle(fontSize: 24)),
                ),
              ),
            )
          ],
        ),
      );
  }
}
