import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/change_password.dart';
import 'package:todo_list/change_username.dart';
import 'package:todo_list/config_data.dart';

class Todo_account extends StatefulWidget {
  final user_ID,username,userpassword,fullname,userage;
  const Todo_account({super.key, required this.user_ID, required this.username, required this.userpassword, required this.fullname, required this.userage});

  @override
  State<Todo_account> createState() => _Todo_accountState();
}

class _Todo_accountState extends State<Todo_account> {

  bool accc_visible = true;

  Future<void> accountFn()async {
    final url = Uri.parse('${MyConfigs.hostIP}todo_account.php');
    final response = await http.post(url, body: {
      'userID':widget.user_ID,
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account'),backgroundColor: Color(0x3ff2C5F2D)),
      body: Container(
        width: 500,
        margin: EdgeInsets.fromLTRB(14, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              width: 350,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0x3af2c5f2d)),
                color: Color(0x3ffFCF6F5),
              ),
              child: Row(
                children: [
                  Icon(Icons.perm_identity_rounded),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full name'),
                      SizedBox(height: 5,),
                      Text(widget.fullname, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 350,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0x3af2c5f2d)),
                color: Color(0x3ffFCF6F5),
              ),
              child: Row(
                children: [
                  Icon(Icons.drive_file_rename_outline),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User name'),
                      SizedBox(height: 5,),
                      Text(widget.username, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 350,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0x3af2c5f2d)),
                color: Color(0x3ffFCF6F5),
              ),
              child: Row(
                children: [
                  Icon(Icons.cake_outlined),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age'),
                      SizedBox(height: 5,),
                      Text(widget.userage, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: accc_visible ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => change_password(userpassword: widget.userpassword,userID: widget.user_ID,)));

                    },style: ElevatedButton.styleFrom(backgroundColor: Color(0x3ff3A6B35)) ,child:
                    Text('Change Password',style: TextStyle(fontSize: 10),)),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Change_username(username: widget.username,userID: widget.user_ID,)));

                    },style: ElevatedButton.styleFrom(backgroundColor: Color(0x3ff3A6B35)) ,child:
                    Text('Change Username',style: TextStyle(fontSize: 10),)),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    print(widget.user_ID);
    if(int.parse(widget.user_ID) == 0){
      setState(() {
        accc_visible = false;
      });
    }else{
      setState(() {
        accc_visible = true;
      });
    }
    super.initState();
  }
}
