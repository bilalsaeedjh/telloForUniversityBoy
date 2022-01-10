import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tello/const/themeColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './profile.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  initializeFirebase() async{
    await Firebase.initializeApp().then((value) => debugPrint("Firebase APp initialized"));
  }
  initState(){
    super.initState();
    initializeFirebase();
  }
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
            Container(
              decoration: BoxDecoration(
                  color: Themes.color,
                  borderRadius: BorderRadius.circular(30.0)),
              width: 225.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.google,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Sign in With Google',
                          style: TextStyle(color: Colors.black, fontSize: 17.0),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                      final GoogleSignIn _googleSignIn = new GoogleSignIn();

                      _signIn(BuildContext context) async {
                        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                        final GoogleSignInAuthentication googleAuth =
                        await googleUser!.authentication;

                        final AuthCredential credential = GoogleAuthProvider.credential(
                            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

                        User userDetails =
                        (await _firebaseAuth.signInWithCredential(credential)).user!;

                        UserDetails details = UserDetails(
                            uid: userDetails.uid,
                            userName: userDetails.displayName??"Empty",
                            userEmail: userDetails.email!,
                            number: userDetails.phoneNumber??'Empty',
                            photoUrl: userDetails.photoURL??'assets/icons/logo.png'
                        );

                        Navigator.pushReplacement(
                            context, MaterialPageRoute(
                            builder: (context) => ProfilePage(detailsUser: details,)));
                      }
                      await Firebase.initializeApp();

                      _signIn(context);
                    }),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              elevation: 15.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Your Email ",
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
                        hintText: "Password",
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
                        BoxShadow(blurRadius: 3, color: Themes.color)
                      ]),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((user) {
                    Navigator.of(context).pushReplacementNamed('/homepage');
                  }).catchError((e) {
                    print(e);
                  });
                }),
            Divider(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
                ),
                SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    "Sign up",
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

class UserDetails {
  String? uid;
  String? userName;
  String? userEmail;
  String? photoUrl;
  String? number;

  UserDetails({this.uid, this.userName, this.userEmail, this.photoUrl,
    this.number});
}