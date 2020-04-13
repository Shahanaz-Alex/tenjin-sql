import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tenjin/home/studentHome.dart';
import 'package:tenjin/home/teacherHome.dart';
import 'api.dart';
import 'register.dart';
import 'dart:convert';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String checkUrl = Api.url;

  String error = "";

  getApi(String emailAddress, String password) async{
    final response = await http.post(checkUrl, body:{"emailAddress": emailAddress, "password": password});
    print(response);
    final data = jsonDecode(response.body);
    print(data);


    if(data['usertype'] == "teacher"){
      print(data['msg'] + " user type: " + data['usertype']);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => TeacherHome(userid: data['userid'], emailAddress: data['emailAddress'], firstName: data['firstName'], lastName: data['lastName'])));
   
      _emailAddress.dispose();
      _password.dispose();
      setState(() {
        error = "";
      });
    }else if (data['usertype'] == "student"){
      print(data['msg'] + " user type: "+ data['usertype']);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => StudentHome(userid: data['userid'], emailAddress: data['emailAddress'], firstName: data['firstName'], lastName: data['lastName'])));
  
      _emailAddress.dispose();
      _password.dispose();
      setState(() {
        error = "";
      });
    } else {
      setState(() {
        error = "Incorrect Username or password";
      });
    }
  }

  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.amber,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegisterPage()));
            },
            child: Text('Register'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                controller: _emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Email Address',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 15.0),
              RaisedButton(
                onPressed: (){
                  getApi(_emailAddress.text, _password.text);
                },
                color: Colors.red,
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
              ),
              SizedBox(height:15.0),
              Center(
                child: Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    ),
                ),)
            ],
          ),
          ),
      ),
    );
  }
}