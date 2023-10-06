import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/config_data.dart';
import 'package:todo_list/login.dart';

class Change_username extends StatefulWidget {
  final userID,username;
  const Change_username({super.key, required this.userID, required this.username});

  @override
  State<Change_username> createState() => _Change_usernameState();
}

class _Change_usernameState extends State<Change_username> {
  TextEditingController _usersname = new TextEditingController();

  Future<void> chguname()async {
    final url = Uri.parse('${MyConfigs.hostIP}todo_chgusername.php');
    final response = await http.post(url, body: {
      'User_ID':widget.userID,
      'User_Name':_usersname.text
    });
    print(response.statusCode);
    if(response.statusCode == 200){
      //print('Username Changed Successfully');
      Fluttertoast.showToast(
          msg: "Username changed successfully. Login again",
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
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Username'),backgroundColor: Color(0x3ff2C5F2D),),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Color(0x3af2c5f2d)),color: Color(0x3ffFCF6F5)),

              child: Row(
                children: [
                  Icon(Icons.drive_file_rename_outline),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enter new username',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                      SizedBox(height: 5,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-111,
                        child: TextField(
                          controller: _usersname,
                          decoration: InputDecoration(
                            hintText: widget.username,
                          )
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

                if(_usersname.text.isEmpty){
                  Fluttertoast.showToast(
                      msg: "Please enter the username",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade300,
                      textColor: Colors.black,
                      fontSize: 16.0
                  );
                }else{
                  chguname();
                }



              },style: ElevatedButton.styleFrom(backgroundColor: Color(0x3ff3A6B35)) ,child:
              Text('Change username',style: TextStyle(fontSize: 10),)),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _usersname.text = widget.username;
    });
    super.initState();
  }
}

