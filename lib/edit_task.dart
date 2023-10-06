import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/config_data.dart';
import 'package:todo_list/home.dart';

class edit_task extends StatefulWidget {
  final sno, title, decription,user_ID,username,userpassword,userage,fullname;

  const edit_task({super.key, required this.sno, required this.title, required this.decription, required this.user_ID, required this.username, required this.userpassword, required this.userage,required this.fullname});

  @override
  State<edit_task> createState() => _edit_taskState();
}

class _edit_taskState extends State<edit_task> {
  TextEditingController _tasktitle = new TextEditingController();
  TextEditingController _description = new TextEditingController();


  Future<void> editFn(String taskedit)async {
    final url = Uri.parse('${MyConfigs.hostIP}update_edit_list.php');
    final response = await http.post(url, body: {
      'title':_tasktitle.text,
      'description':_description.text,
      's_no':taskedit,
    });
    if(response.statusCode == 200){
      //print('Save Changed');
      Fluttertoast.showToast(
          msg: "Task changed successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );
     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => home1(user_ID: widget.user_ID, username: widget.username, useremail: '',userpassword: widget.userpassword,fullname: widget.fullname,userage: widget.userage,)));
    }else{
      //print('error');
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
      appBar: AppBar(title: Text('Edit list'),backgroundColor: Color(0x3ff6e5dd4),elevation: 0,),
      body: Stack(
        children: [
          Container(width: 600,height: 155,color: Color(0x3ff6e5dd4),),
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
                      color: Color(0x3ff6e5dd4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 110,
                          width: 400,
                          color:Color(0x3ff6e5dd4),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text('To-Do list',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                              TextField(
                                controller: _tasktitle,
                                decoration: InputDecoration(
                                  hintText: 'Task Tittle',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                    child: Container(
                      height: 300,
                      width: 400,
                      color: Color(0x3ffc0bfee),
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
                  SizedBox(height: 20),
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),),height: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: ElevatedButton(onPressed: (){
                        editFn(widget.sno);

                      },style: ElevatedButton.styleFrom(backgroundColor: Color(0x3ff6e5dd4)) ,child:
                      Text('Save Change',style: TextStyle(fontSize: 10),)),
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

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _tasktitle.text = widget.title;
      _description.text = widget.decription;
    });
    super.initState();
  }

}
