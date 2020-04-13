import 'package:flutter/material.dart';
import 'package:tenjin/login.dart';

class TeacherHome extends StatelessWidget {

  final String userid, emailAddress, firstName, lastName;
  
  TeacherHome({this.userid, this.emailAddress,this.firstName, this.lastName});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.amber,
        elevation: 0.0,
      ),
      body: Center(
        child: Text('Welcome' + firstName + " " + lastName),
        ),
    );
  }
}