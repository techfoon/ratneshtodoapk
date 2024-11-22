import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ratneshtodoapk/dashbord.dart';
import 'package:ratneshtodoapk/registar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username, userpass;
  bool? loginStatus;

  TextEditingController NameControler = TextEditingController();

  TextEditingController PassControler = TextEditingController();

  setData() async {
    SharedPreferences mySharedInstac = await SharedPreferences.getInstance();

    if (NameControler.text == username && PassControler.text == userpass) {
      mySharedInstac.setBool('status', true);
    } else {
      mySharedInstac.setBool('status', false);
    }

    getData();
  }

  getData() async {
    SharedPreferences mySharedInstac = await SharedPreferences.getInstance();

    setState(() {
      username = mySharedInstac.getString('setusername');
      userpass = mySharedInstac.getString('setuserpass');
      loginStatus = mySharedInstac.getBool('status');
    });

    if (loginStatus == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DashbordNotes();
      }));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginPage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: NameControler,
              decoration: InputDecoration(
                label: Text("Name"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: PassControler,
              decoration: InputDecoration(
                label: Text("Password"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.lightGreen),
                  fixedSize: MaterialStatePropertyAll(Size(100, 60)),
                ),
                onPressed: () {
                  passVerified(topContext: context);
                },
                child: RichText(
                    text: TextSpan(
                        text: "Login",
                        style: TextStyle(color: Colors.white),
                        children: [
                      TextSpan(
                        text: " ->",
                      )
                    ]))),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return RegistarPage();
                  }));
                },
                child: Text("Registar Here"))
          ],
        ),
      ),
    );
  }

  void passVerified({required topContext}) {
    //log("passVerified getting into");

    if (PassControler.text.isNotEmpty && NameControler.text.isNotEmpty) {
      if (NameControler.text == username && PassControler.text == userpass) {
        showDialog<String>(
          context: topContext,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'success',
              style: TextStyle(color: Colors.red),
            ),
            content: const Text('Please check the pass'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setData();
                },
                child: const Text('Goto Dashboard'),
              ),
            ],
          ),
        );
      } else {
        log("loginpass not correct");
      }
    } else {
      log("Please fill all the fields");
    }
  }
}
