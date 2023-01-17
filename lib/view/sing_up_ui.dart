import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vis_mobile/view/login_ui.dart';
import '../service/signup_service.dart';
import 'FadeAnimation.dart';

class SignupScreen extends StatefulWidget {
  @override
  SignupScreenState createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController nic = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    fname.dispose();
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
            height: 150,
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
                                    AssetImage('assets/images/light-1.png'))),
                      )),
                ),
                Positioned(
                  child: FadeAnimation(
                      1.6,
                      Container(
                        child: const Center(
                          child: Text(
                            "Sign Up",
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
                              controller: fname,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: _validate
                                      ? 'First Name Can\'t Be Empty'
                                      : null,
                                  hintText: "First Name",
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
                              controller: lname,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Last Name",
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
                              controller: nic,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText:
                                      _validate ? 'NIC  Can\'t Be Empty' : null,
                                  hintText: "NIC",
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
                              controller: address,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: _validate
                                      ? 'Address Can\'t Be Empty'
                                      : null,
                                  hintText: "Address",
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
                    onPressed: ()  async  {
                       if (fname.text.isNotEmpty &&
                            nic.text.isNotEmpty &&
                            address.text.isNotEmpty &&
                            email.text.isNotEmpty &&
                            pass.text.isNotEmpty) {
                               setState(() async {
                                 SignupController  sc = SignupController ();
                              if(await sc.createUser(fname.text, lname.text, nic.text, address.text, email.text, pass.text)){
                                    showAlertDialog(context);
                              }else{
                                 showWorningDialog(context);
                              }
                               }
                               );
                        } 
                      setState(() {
                     
                          fname.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          nic.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          address.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          email.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          pass.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                        
                      });
                    },
                    child: const Text('SIGN UP'),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Allready Have an Account ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
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
                                builder: (context) => LoginScreen()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Sign up Success"),
    content: const Text("Welcome to Vehicle Indentification System. Please login."),
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
    title: const Text("Sign up Faild"),
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


