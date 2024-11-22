import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ratneshtodoapk/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashbordNotes extends StatefulWidget {
  @override
  State<DashbordNotes> createState() => _DashbordNotesState();
}

class _DashbordNotesState extends State<DashbordNotes> {
  String? username, userpass;
  bool? loginStatus;

  getData() async {
    SharedPreferences mySharedInstac = await SharedPreferences.getInstance();

    setState(() {
      username = mySharedInstac.getString('setusername');
      userpass = mySharedInstac.getString('setuserpass');
      loginStatus = mySharedInstac.getBool('status');
    });

    if (loginStatus == false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    }
  }

  List<Map<String, dynamic>> mData = [
    {"title": "Abcd", "decription": "This description is one"},
    {"title": "Abcd", "decription": "This description is one"},
    {"title": "Abcd", "decription": "This description is one"},
    {"title": "Abcd", "decription": "This description is one"},
    {"title": "Abcd", "decription": "This description is one"},
  ];

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
        title: Text("Hi, ${username}"),
        actions: [
          if (loginStatus == true)
            IconButton(
                onPressed: () {
                  logout(topcontext: context);
                },
                icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
          itemBuilder: (_, index) {
            return ListTile(
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              title: Text("${mData[index]['title']}"),
              subtitle: Text("${mData[index]['decription']}"),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            );
          },
          itemCount: mData.length),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  void logout({required topcontext}) {
    showDialog<String>(
      context: topcontext,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Alert!',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text('Do you want to Log out'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              SharedPreferences mySharedInstac =
                  await SharedPreferences.getInstance();
              await mySharedInstac.setBool('status', false);

              getData();
            },
            child: const Text('back'),
          ),
        ],
      ),
    );
  }
}
