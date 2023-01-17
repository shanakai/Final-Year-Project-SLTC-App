import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vis_mobile/service/login_service.dart';
import 'package:vis_mobile/view/home_ui.dart';
import 'package:vis_mobile/view/sing_up_ui.dart';
import 'FadeAnimation.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
    super.initState();
  }

  void _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
 
     if(prefs.getString('name') != null && prefs.getString('email') != null && prefs.getInt('uid') != null){
 Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
     }
    });
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
        textStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
          Container(
            height: 330,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill)),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 30,
                  width: 80,
                  height: 160,
                  child: FadeAnimation(
                      1,
                      Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-1.png'))),
                      )),
                ),
                Positioned(
                  left: 140,
                  width: 80,
                  height: 150,
                  child: FadeAnimation(
                      1.3,
                      Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-2.png'))),
                      )),
                ),
                Positioned(
                  right: 40,
                  top: 40,
                  width: 80,
                  height: 150,
                  child: FadeAnimation(
                      1.5,
                      Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png'))),
                      )),
                ),
                Positioned(
                  child: FadeAnimation(
                      1.6,
                      Container(
                        child: const Center(
                          child: Text(
                            "Login",
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
                          boxShadow: const [
                            BoxShadow(
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
                                    bottom: BorderSide(color: Color.fromARGB(255, 194, 214, 190)))),
                            child: TextField(
                              controller: email,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                   errorText: _validate
                                      ? 'Email Can\'t Be Empty'
                                      : null,
                                  hintText: "Email Address",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                               controller: pass,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                   errorText: _validate
                                      ? 'Password Can\'t Be Empty'
                                      : null,
                                  hintText: "Password",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                            ),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    style: style,
                    onPressed: () async  {
                       if (
                            email.text.isNotEmpty &&
                            pass.text.isNotEmpty) {
                               setState(() async {
                                 LoginController  lc = LoginController ();
                              if(await lc.login( email.text, pass.text)){
                                    showAlertDialog(context);
                              }else{
                                 showWorningDialog(context);
                              }
                               }
                               );
                        } 
                      setState(() {
                    
                          email.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          pass.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                        
                      });
                    },
                    child: const Text('LOGIN'),
                  ),
                ),
                 const SizedBox(height: 70,),
                 RichText(
            text: TextSpan(children: [
              const TextSpan(
                text: 'Need to create a new account ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                  text: 'Sign Up',
                  style: const TextStyle(
                    color: Color.fromRGBO(143, 148, 251, 1)
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
                    }),
            ]),
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
    title: const Text("Login Success"),
    content: const Text("Welcome to Vehicle Indentification System."),
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
                                builder: (context) => LoginScreen()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Login Faild"),
    content: const Text("Something going wrong. Please try again later"),
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


