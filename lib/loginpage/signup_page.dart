import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tello/const/themeColor.dart';
import 'package:tello/services/usermanagement.dart';
import './sigin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth mAuth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(45),
              width: 330,
              decoration: new BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: new AssetImage(
                    'assets/foodtukk1.png',
                  ),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password more then 6",
                        hintStyle: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 18.0,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _toggleVisibility = !_toggleVisibility;
                            });
                          },
                          icon: _toggleVisibility
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      obscureText: _toggleVisibility,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
                child: Container(
                  height: 50.0,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Themes.color,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(blurRadius: 2, color: Themes.color)
                      ]),
                  child: const Center(
                    child: Text(
                      "Sign UPP",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                onTap: () async{
                  debugPrint("Ahoo");

                  await Firebase.initializeApp().then((value) async {


                    debugPrint("Firebase APp initialized");
                     FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                        .then((signedInUser) {
                      UserManagement().storeNewUser(signedInUser, context);
                    }).catchError((e) {
                       showDialog(context: context, builder: (BuildContext buildContext){
                         return AlertDialog(
                           title: Text(e!.toString()),
                         );
                       });
                    });
                  });

                }),
            const Divider(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account?",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
                ),
                SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SignInPage()));
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
