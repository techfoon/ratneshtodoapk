import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ratneshtodoapk/Login.dart';
import 'package:ratneshtodoapk/dashbord.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistarPage extends StatefulWidget {
  @override
  State<RegistarPage> createState() => _RegistarPageState();
}

class _RegistarPageState extends State<RegistarPage> {
  String? username, userpass;
  bool? loginStatus;

  TextEditingController NameControler = TextEditingController();

  TextEditingController PassControler = TextEditingController();

  TextEditingController ConfirmPassControler = TextEditingController();

  setData() async {
    SharedPreferences mySharedInstace = await SharedPreferences.getInstance();
    mySharedInstace.setString('setusername', NameControler.text);
    mySharedInstace.setString('setuserpass', PassControler.text);

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
        title: Text("RegistarPage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Registar",
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
              height: 5,
            ),
            TextField(
              controller: ConfirmPassControler,
              decoration: InputDecoration(
                label: Text("ConfirmPassword"),
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
                        text: "Registar",
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
                    return LoginPage();
                  }));
                },
                child: Text("Login Here"))
          ],
        ),
      ),
    );
  }

  void passVerified({required topContext}) {
    //log("passVerified getting into");

    if (PassControler.text.isNotEmpty &&
        ConfirmPassControler.text.isNotEmpty &&
        NameControler.text.isNotEmpty) {
      if (PassControler.text.toString() !=
          ConfirmPassControler.text.toString()) {
        showDialog<String>(
          context: topContext,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Alert!',
              style: TextStyle(color: Colors.red),
            ),
            content: const Text('Please check the pass'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('back'),
              ),
            ],
          ),
        );
      } else {
        setData();
        showDialog<String>(
          context: topContext,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Success Registation ',
              style: TextStyle(color: Colors.green),
            ),
            content: const Text('user is successfully registered'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
                child: const Text('back'),
              ),
            ],
          ),
        );

        log("registration success");
      }
    } else {
      log("Please fill all the fields");
    }
  }
}
