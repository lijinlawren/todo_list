import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/config_data.dart';
import 'package:todo_list/home.dart';

class list_data extends StatefulWidget {
  final user_ID,username,userpassword,fullname,userage;
  const list_data({super.key, required this.user_ID, required this.username, required this.userpassword,required this.fullname,required this.userage});

  @override
  State<list_data> createState() => _list_dataState();
}

class _list_dataState extends State<list_data> {
  TextEditingController _tasktitle = new TextEditingController();
  TextEditingController _description = new TextEditingController();

  Future<void> saveoff()async {
    final url = Uri.parse('${MyConfigs.hostIP}todo_wish_data.php');
    final response = await http.post(url, body: {
      'title': _tasktitle.text,
      'description': _description.text,
      'userID':widget.user_ID
    });
    if(response.statusCode == 200){
      //print('');
      Fluttertoast.showToast(
          msg: "Task added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => home1(user_ID: widget.user_ID,username: widget.username, useremail: '', userpassword: widget.userpassword,fullname: widget.fullname,userage: widget.userage,)));
    }else{
      //print('Some Error occurred');
      Fluttertoast.showToast(
          msg: "Error! Try Again",
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
      appBar: AppBar(title: Text('Your List'),backgroundColor: Color(0x3ffADD8E6),elevation: 0,),
      body: Stack(
        children: [
          Container(width: 600,height: 155,color: Color(0x3ffADD8E6),),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  Center(
                    child: Material(
                      elevation: 10,
                      color: Color(0x3ffADD8E6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 110,
                          width: 400,
                          color:Color(0x3ffADD8E6),
                          padding: EdgeInsets.all(20),
                          child: Column(
                              children: [
                                Text('To-Do list',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                TextField(
                                  controller: _tasktitle,
                                  decoration: InputDecoration(
                                  hintText: 'Task Tittle',
                                ),),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ),
                  //SizedBox(height: 5),
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      child: Container(
                        height: 300,
                        width: 400,
                        color: Color(0x3ffE7E8D1),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              controller: _description,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Description',
                              ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),),height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: ElevatedButton(onPressed: (){
                        if(_tasktitle.text.isEmpty){
                          //print('Add the task title');
                          Fluttertoast.showToast(
                              msg: "Please fill the title",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade300,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }else if(_description.text.isEmpty){
                          //print('Add description');
                          Fluttertoast.showToast(
                              msg: "Please add description",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade300,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }else{
                          saveoff();
                        }

                      },style: ElevatedButton.styleFrom(backgroundColor: Color(0x3ff86d1ea)) ,child:
                      Text('Add Task',style: TextStyle(fontSize: 10,color: Colors.black),)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
