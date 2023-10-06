import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_list/config_data.dart';
import 'package:todo_list/privacy.dart';
import 'package:todo_list/terms.dart';
import 'package:http/http.dart' as http;

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController _userName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _age = new TextEditingController();

  bool _eyeclick = true;

  Future<void> signFn() async {
    final url = Uri.parse('${MyConfigs.hostIP}todo_signup.php');
    final response = await http.post(url, body: {
      'User_Name': _userName.text,
      'Email': _email.text,
      'Name': _name.text,
      'Password': _password.text,
      'Age': _age.text,
    });
    if(response.statusCode == 200){
      //print('SignIn Successfull');
      Fluttertoast.showToast(
          msg: "Signed in success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }else{
      //print('Inavlid Login');
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
  }

  IconData ic = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'),backgroundColor: Color(0x3bf00008B),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 90,),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Color(0x3af00008B)),borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  //height: 503,
                  width: 500,
                  padding: EdgeInsets.all(15),
                  color: Color(0x3ffADD8E6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Sign Up',style: TextStyle(fontSize: 30),),
                      TextField(
                        controller: _userName,
                        decoration: InputDecoration(
                          hintText: 'User Name',
                          icon: Icon(Icons.drive_file_rename_outline),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          hintText: 'Enter your Email',
                          icon: Icon(Icons.mail_outline),
                        ),
                      ),
                      SizedBox(height: 15),
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
                                ic = Icons.visibility_off_rounded;
                              }else{
                                _eyeclick = true;
                                ic = Icons.visibility;
                              }

                            });
                          },),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          hintText: 'Full name',
                          icon: Icon(Icons.perm_identity_rounded),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _age,
                        decoration: InputDecoration(
                          hintText: 'Age',
                          icon: Icon(Icons.cake_outlined),
                        ),
                      ),
                      SizedBox(height: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(onPressed: (){

                          if(_userName.text.isEmpty){
                            //print('User name required');
                            Fluttertoast.showToast(
                                msg: "Please enter your username",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade300,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }else if(_password.text.isEmpty){
                            //print('Password required');
                            Fluttertoast.showToast(
                                msg: "Please enter your password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade300,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }else if (_name.text.isEmpty){
                            //print('Name required');
                            Fluttertoast.showToast(
                                msg: "Please enter your name",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade300,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }else if(_email.text.isEmpty){
                            //print('Email required');
                            Fluttertoast.showToast(
                                msg: "Please enter your Email",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade300,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }else if(_age.text.isEmpty){
                            //print('Age is Empty');
                            Fluttertoast.showToast(
                                msg: "Please enter your age",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade300,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }
                          else{
                            signFn();
                          }



                        },style: ElevatedButton.styleFrom(backgroundColor: Color(0x3bf00008B)),child:
                        Container(width: 100,height: 30,child: Center(child: Text('Sign Up')))),
                      ),
                      SizedBox(height: 10),
                      Text('By clicking Sign Up, You agree to our'),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(child: Column(
                            children: [
                              Text('Terms and conditons ',style: TextStyle(color:  Color(0x3ffEE4E34)),),
                              Container(height: 1,width: 150,color: Color(0x3ffEE4E34))
                            ],
                          ),onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => terms_()));
                          },),
                          Text('  and  '),

                        ],
                      ),
                      SizedBox(height: 5),
                      InkWell(child: Column(
                        children: [
                          Text('Privacy Statement',style: TextStyle(color:  Color(0x3ffEE4E34)),),
                          Container(height: 1,width: 130,color: Color(0x3ffEE4E34))
                        ],
                      ),onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => privacy_()));
                      },),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
