import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  final String userid, emailAddress, firstName, lastName;

  StudentHome({this.userid, this.emailAddress, this.firstName, this.lastName});

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