import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //to attain the values 
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _usertype = TextEditingController();

  String regisUrl = Api.regis;

  
  String message = "";

  static const items = <String>["teacher", "student"];

  List<DropdownMenuItem<String>> _myItems = items
    .map((e) => DropdownMenuItem(
      value: e,
      child: Text(e)
      )
    ).toList();

  String valueItem = "teacher";

  registerUser() async {
    final response = await http.post(regisUrl, body:{

      //firstname
      'firstName': _firstName.text,
      //lastname
      'lastName': _lastName.text,
      //emailAddress
      'emailAddress': _emailAddress.text,
      //password
      'password': _password.text,
      //usertype
      'usertype': valueItem

    });
    final dataJson = jsonDecode(response.body);
    print(dataJson);

    _firstName.clear();
    _lastName.clear();
    _emailAddress.clear();
    _password.clear();
    _usertype.clear();

    if(dataJson['status'] == 1){
      print(dataJson['msg']);
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Notification'),
            content: Text(dataJson['msg']),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text('Close')
              ),
            ],
          );
        }// builder
      ); //showDialog
      setState(() {
        message = dataJson['msg'];
      });
    } else if(dataJson['status'] == 2){
      print(dataJson['msg']);
      Navigator.of(context).pop();
      setState(() {
        message = "";
      });
    } else {
      print(dataJson['msg']);
      setState(() {
        message = dataJson['msg'];
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal:40),
        children: <Widget>[
            TextField(
              controller: _firstName,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'First Name',
                hintText: 'First Name',
                errorText: _firstName.text.isEmpty ? 'Please enter your first name':null,
              ),
            ),
            TextField(
              controller: _lastName,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Last Name',
                hintText: 'Last Name',
                errorText: _lastName.text.isEmpty ? 'Please enter your last name':null,
              ),
            ),
            TextField(
              controller: _emailAddress,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Email Address',
                hintText: 'Email Address',
                errorText: _emailAddress.text.isEmpty ? 'Please enter your email address':null,
              ),
            ),
            TextField(
              obscureText: true,
              controller: _password,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Password',
                hintText: 'Password',
                errorText: _password.text.isEmpty ? 'Please enter a password':null,
              ),
            ),
            DropdownButton(
              items: _myItems, 
              value: valueItem,
              onChanged: (e){
                setState(() {
                  valueItem = e;
                });
              },
            ),
            SizedBox(height: 25.0),
            RaisedButton(
              onPressed: (){
                registerUser();
              },
              color: Colors.red,
              child: Text(
                'REGISTER',
                style: TextStyle(
                  color: Colors.amber,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
    );
  }
}