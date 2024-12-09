import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/config_data.dart';
import 'package:todo_list/home.dart';
import 'package:todo_list/signup.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {


  TextEditingController _userName = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  bool isLoading = false;

  IconData ic = Icons.visibility_off_rounded;


  Future<void> loginFn() async {
    final url = Uri.parse('${MyConfigs.hostIP}todo_login.php');
    final response = await http.post(url, body: {
      'User_Name': _userName.text,
      'Password': _password.text,
    });

    print('response.statusCode : ${response.statusCode}');

    if(response.statusCode == 200){
      if(response.body.toString() == '[]'){
        //print('Please enter valid Username or Password');
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Login failed! please check your username and password",);
      }
      else{
        var jsonData = json.decode(response.body);
        var jsonObt = jsonData[0];
        if(jsonObt['User_Name'] != ''){
          print(jsonObt['User_ID']);

          setState(() {
            _userName.text = '';
            _password.text = '';
            isLoading = false;
          });

          saveusernamepass(_userName.text, _password.text);

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
              home1(user_ID: jsonObt['User_ID'], username: jsonObt['User_Name'], useremail: jsonObt['Email'],userpassword: jsonObt['Password'],userage: jsonObt['Age'],fullname: jsonObt['Name'],)));

          //Navigator.pop(context);
        }
      }
    }else{
      Fluttertoast.showToast(
          msg: "Welcome Back",
          backgroundColor: Colors.grey.shade300,
      );
    }
  }
  
  bool _eyeclick = true;


  Future<void> saveusernamepass(String uname, upass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('User_Name', uname);
    await prefs.setString('Password', upass);
  }

  Future<void> emailID(String uname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('User_Name', uname);
  }

  Future<void> uPassword(String upassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Password', upassword);
  }

  Future<void> getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uname = await prefs.getString('User_Name');
    final String? upassword = await prefs.getString('Password');

    setState(() {
      _userName.text = uname!;
      _password.text = upassword!;

      loginFn();
    });
  }


  Future<void> guestFn() async {
    final url = Uri.parse('${MyConfigs.hostIP}guest.php');
    final response = await http.post(url, body: {
      'userID': '0'
    });

    if(response.statusCode == 200){
      if(response.body.toString() == '[]'){
        //print('Please enter valid Username or Password');
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Login failed! please check your username and password",
        );
      }
      else{
        var jsonData = json.decode(response.body);
        var jsonObt = jsonData[0];
        if(jsonObt['userID'] != ''){
          print(jsonObt['User_ID']);

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
              home1(user_ID: jsonObt['User_ID'], username: jsonObt['User_Name'], useremail: jsonObt['Email'],userpassword: jsonObt['Password'],userage: jsonObt['Age'],fullname: jsonObt['Name'],)));

          //Navigator.pop(context);
        }
      }
    }else{
      //print('Sign In Success');
      Fluttertoast.showToast(
          msg: "Welcome Back",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Color(0x3afEE4E34)),borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 400,
                width: 500,
                padding: EdgeInsets.all(30),
                color: Color(0x3ffFCEDDA),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login',style: TextStyle(fontSize: 30),),
                    TextField(
                      controller: _userName,
                      decoration: InputDecoration(
                        hintText: 'User Name',
                        icon: Icon(Icons.drive_file_rename_outline_sharp),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _password,
                      obscureText: _eyeclick,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        icon: Icon(Icons.password_sharp),
                        suffixIcon: IconButton(icon: Icon(ic),onPressed: (){
                          setState(() {

                            if(_eyeclick == true){
                              _eyeclick = false;
                              ic = Icons.visibility_rounded;
                            }else{
                              _eyeclick = true;
                              ic = Icons.visibility_off_rounded;
                            }

                          });
                        },),
                      ),
                    ),
                    SizedBox(height: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ElevatedButton(onPressed: (){
                            if(_userName.text.isEmpty){
                              //print('enter your username');
                              Fluttertoast.showToast(
                                  msg: "Please enter valid username",
                                  backgroundColor: Colors.grey.shade300,
                                  textColor: Colors.black,

                              );
                            }else if(_password.text.isEmpty){
                              //print('enter your Password');
                              Fluttertoast.showToast(
                                  msg: "Please enter valid password",
                                  backgroundColor: Colors.grey.shade300,
                                  textColor: Colors.black,
                              );
                            }else{
                              setState(() {
                                isLoading = true;
                              });
                              loginFn();
                              Fluttertoast.showToast(
                                  msg: "Loading! Please wait",
                                  backgroundColor: Colors.grey.shade300,
                                  textColor: Colors.black,
                              );
                            }

                          },style: ElevatedButton.styleFrom(backgroundColor: Color(0x3ffEE4E34)),child:
                          Container(width: 100,height: 30,child: Center(child: Text('Get Started')))),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have account?'),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(child: Text(' Sign Up',style: TextStyle(color: Color(0x3ffEE4E34)),),onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => signup()));
                                },),
                                Container(height: 1,width: 57,color: Color(0x3ffEE4E34),),
                              ],
                            ),
                          ],
                        ),
                    SizedBox(height: 20,),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Material(
                        child: InkWell(
                          child: Container(
                              height: 35,
                              width: 400,
                              decoration: BoxDecoration(border: Border.all(color: Color(0x3ffEE4E34)),borderRadius: BorderRadius.circular(5),),
                              child: Center(child: Text('Continue as guest',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0x3ffEE4E34)),))
                          ),
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                home1(user_ID: '0', username: 'Guest', useremail:'',userpassword: '',userage: '',fullname: '',)));

                          },
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Visibility(
              visible: isLoading,
              child: CircularProgressIndicator( color: Color(0x3ffEE4E34),))
        ],
      ),
    );
  }
  @override
  void initState() {
    getPref();
    super.initState();
  }
}
