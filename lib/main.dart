import 'package:flutter/material.dart';
import 'package:ratneshtodoapk/Login.dart';
import 'package:ratneshtodoapk/registar.dart';

void main() {
  runApp(Main());
}



class Main extends StatelessWidget {
const Main({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
  debugShowCheckedModeBanner: false,

      home: RegistarPage()
    );
  }
}