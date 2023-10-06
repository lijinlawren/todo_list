import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/config_data.dart';
import 'package:todo_list/login.dart';

class change_password extends StatefulWidget {
  final userID,userpassword;
  const change_password({super.key, required this.userID, required this.userpassword});

  @override
  State<change_password> createState() => _change_passwordState();
}

class _change_passwordState extends State<change_password> {
  TextEditingController _userpassword = new TextEditingController();
  
  Future<void> chgpassword()async {
    final url = Uri.parse('${MyConfigs.hostIP}todo_chgpassword.php');
    final response = await http.post(url, body: {
      'User_ID':widget.userID,
      'Password':_userpassword.text
    });
    if(response.statusCode == 200){
      //print('Password Changed Successfully');
      Fluttertoast.showToast(
          msg: "Password changed successfully. Login again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => login()));

    }else{
      //print('Error');
      Fluttertoast.showToast(
          msg: "Error while changing your password",
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

  bool _clickeye = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change password'),backgroundColor: Color(0x3ff2C5F2D),),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Color(0x3af2c5f2d)),color: Color(0x3ffFCF6F5)),

              child: Row(
                children: [
                  Icon(Icons.lock_outline),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enter new password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                      SizedBox(height: 5,),

                      Container(
                        width: MediaQuery.of(context).size.width - 111,
                        child: TextField(
                          obscureText: _clickeye,
                          controller: _userpassword,
                          decoration: InputDecoration(
                            hintText: 'Enter new Password',
                            suffixIcon: IconButton(icon: Icon(ic),onPressed: (){

                              setState(() {
                                if(_clickeye == true){
                                  _clickeye = false;
                                  ic = Icons.visibility_off_rounded;
                                }else{
                                  _clickeye = true;
                                  ic = Icons.visibility;
                                }
                              });


                            },)
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(onPressed: (){

                if(_userpassword.text.isEmpty){
                  //print('Please enter valid Password');
                  Fluttertoast.showToast(
                      msg: "Please enter the password",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade300,
                      textColor: Colors.black,
                      fontSize: 16.0
                  );
                }else{
                  chgpassword();
                }

              },style: ElevatedButton.styleFrom(backgroundColor: Color(0x3ff3A6B35)) ,child:
              Text('Change Password',style: TextStyle(fontSize: 10),)),
            ),
          ],
        ),
      ),
    );
  }
}
