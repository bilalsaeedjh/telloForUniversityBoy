import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tello/const/themeColor.dart';
import '../services/crud.dart';

class RestaurantHome extends StatefulWidget {
  const RestaurantHome({Key? key}) : super(key: key);

  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  late String restaurantName;
  late String foodName;
  late String amount;
  late String restaurantEmail;
  late String imageUrl;

  @override
  Widget build(BuildContext context) {
    crudMethods crudObj =  crudMethods();

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 70.0),
              Container(
                color: Colors.white10,
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'AddDetails',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 45),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.url,
                  style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Image Url",
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    imageUrl = value;
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 25,
                  style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Restaurant Name",
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    restaurantName = value;
                  },
                ),
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 15,
                  style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Food Name",
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    foodName = value;
                  },
                ),
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    amount = value;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Themes.color,
                    onPressed: () {
                      Map<String, dynamic> restaurantData = {
                        'restaurantName': restaurantName,
                        'foodName': foodName,
                        'amount': amount,
                        'imageUrl': imageUrl,
                      };
                      crudObj.addData(restaurantData).then((result) {
                        dialogTrigger(context);
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    elevation: 4.0,
                    splashColor: Colors.yellow,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.red.shade400,
                    onPressed: () {
                      Navigator.of(context).pop();
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.of(context)
                            .pushReplacementNamed('\firstpage');
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    elevation: 4.0,
                    splashColor: Colors.yellow,
                    child: const Text(
                      'LogOut',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future dialogTrigger(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Job done', style: TextStyle(fontSize: 22.0)),
          content: const Text(
            'Added Successfully',
            style: TextStyle(fontSize: 20.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text(
                'Alright',
                style: TextStyle(fontSize: 18),
              ),
              textColor: Themes.color,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      });
}
