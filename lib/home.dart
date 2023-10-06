import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/all_task.dart';
import 'package:todo_list/completed_task.dart';
import 'package:todo_list/config_data.dart';
import 'package:todo_list/edit_task.dart';
import 'package:todo_list/list_data.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/login.dart';
import 'package:todo_list/todo_account.dart';
import 'package:fluttertoast/fluttertoast.dart';

class home1 extends StatefulWidget {
  final user_ID,username,useremail,userpassword,fullname,userage;
  const home1({super.key, required this.user_ID, required this.username, required this.useremail, required this.userpassword,required this.fullname,required this.userage});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {

  List<dynamic> mData = [];

  bool isLoading = true;

  Future<List<dynamic>> listFn() async {
    final url = Uri.parse('${MyConfigs.hostIP}todo_list.php');
    final response = await http.post(url,body: {
      'userID': widget.user_ID,
    });

    final jsonData = json.decode(response.body);

    setState(() {
      mData = jsonData as List<dynamic>;
      isLoading = false;
    });


    return jsonData as List<dynamic>;
  }
  
  Future<void> completeFn(String sno)async {
    final url = Uri.parse('${MyConfigs.hostIP}update_list.php');
    final response = await http.post(url, body: {
      's_no': sno,
      'completed':'1',
    });
    if(response.statusCode == 200){
      //print('done the task');
      Fluttertoast.showToast(
          msg: "Task Completed!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );
      listFn();
    }else{
      //print('error');
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

  Future<void> _refresh() async {
    return Future.delayed(Duration(seconds: 1));
  }

  ///0 - incomplete
  ///1 - completed
  ///2 - delete
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.username,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Color(0x3ff2C5F2D),),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [

                  Container(
                    child: RefreshIndicator(
                    color: Color(0x3ff3A6B35),
                    backgroundColor: Color(0x3ffffffff),
                    displacement: 50,
                    edgeOffset: 0,
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    onRefresh: listFn,

            child: ListView.builder(itemCount: mData!.length,itemBuilder: (BuildContext context,index){
              final items = mData![index];
              return Container(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      width: 402,
                      color: Color(0x3ff3A6B35),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(items['title'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                              SizedBox(width: 20),
                              InkWell(child: Icon(Icons.edit_note_sharp,
                                color: Colors.white,), onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                    edit_task(title: items['title'], decription: items['description'], sno:items['s_no'],user_ID:items['user_id'],username: widget.username,userpassword: items['Password'],userage: items['Age'],fullname: items['Name'],)));
                              },),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: Color(0x3aa3A6B35)),borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                        child: Container(
                          height: 135,
                          width: 420,
                          color: Color(0x3ffCBD18F),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(items['description'], softWrap: true,),
                              SizedBox(height: 10),
                              Container(decoration: BoxDecoration(border: Border.all(color: Color(0x3bf3A6B35)),borderRadius: BorderRadius.circular(6),),height: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: ElevatedButton(onPressed: (){

                                    completeFn(items['s_no']);


                                  },style: ElevatedButton.styleFrom(backgroundColor: Color(0x3503A6B35)) ,child:
                                  Text('Completed',style: TextStyle(fontSize: 10),)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),

                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Material(
                        child: InkWell(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Color(0x3ff97BC62)),
                            child: Icon(Icons.add_rounded,),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => list_data(user_ID: widget.user_ID,username: widget.username,userpassword: widget.userpassword,fullname: widget.fullname,userage: widget.userage,)));},
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                      visible: isLoading,
                      child: Center(child: CircularProgressIndicator(color: Color((0x3ff2C5F2D)),))),

                ],
              ),
            ),

          ],
        ),
      ),
      drawer: Drawer(child: Column(children: [
        Container(
          height: 120,
          width: 310,
          padding: EdgeInsets.all(17),
          color: Color(0x3ff2C5F2D),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(widget.username,style: TextStyle(color: Colors.white)),
              SizedBox(height: 7,),
              Text(widget.useremail,style: TextStyle(color: Colors.white))
            ],
          ),
        ),
        ListTile(title: Text('Account'), leading: Icon(Icons.account_circle_outlined,color: Color(0x3ff2C5F2D),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Todo_account(user_ID: widget.user_ID, username: widget.username.toString(), userpassword: widget.userpassword.toString(),fullname: widget.fullname.toString(),userage: widget.userage.toString(),)));
        },),
        ListTile(title: Text('Completed Task'), leading: Icon(Icons.history,color: Color(0x3ff2C5F2D),),onTap: (){

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => completed_task(userID: widget.user_ID, username: widget.username,)));

        },),
        ListTile(title: Text('All Task'), leading: Icon(Icons.list_alt,color: Color(0x3ff2C5F2D),),onTap: (){

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext  context) => all_task(userID: widget.user_ID,)));

        },),
        ExpansionTile(title: Text('About'), leading: Icon(Icons.info_outline_rounded,color: Color(0x3ff2C5F2D)),children: [
          Container(
            padding: EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Version: 1.0.0'),
                SizedBox(height: 7),

                Text('© 2023 BrainWave Technologies'),
                SizedBox(height: 7,),
                Text('Thank you for choosing our ToDo-Wishlist app! We hope it helps you stay organized and productive. If you have any feedback or suggestions, please don\'t hesitate to reach out to us. We\'re committed to improving your experience with every update.'
                  'If you enjoy using our app, please consider leaving a review on the app store. Your feedback is valuable to us.'),
                SizedBox(height: 7,),
                Text('Developer: LIJIN',style: TextStyle(fontSize: 10,color: Colors.black54),)
              ],
            ),
          )
        ],),
        ListTile(title: Text('Logout'), leading: Icon(Icons.login_outlined,color: Color(0x3ff2C5F2D),),onTap: (){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext  context) => login()));

        },),
      ],),),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    listFn();
    super.initState();
  }
}
