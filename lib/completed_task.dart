import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/config_data.dart';

class completed_task extends StatefulWidget {
  final userID,username;
  const completed_task({super.key, required this.userID, required this.username});

  @override
  State<completed_task> createState() => _completed_taskState();
}

class _completed_taskState extends State<completed_task> {

  List<dynamic> mData = [];

  bool isLoading = true;

  Future<List<dynamic>> complete() async {
    final url = Uri.parse('${MyConfigs.hostIP}todo_comp.php');
    final response = await http.post(url, body: {
      'userID':widget.userID
    });


    final jsonData = json.decode(response.body);

    setState(() {
      mData = jsonData as List<dynamic>;
      isLoading = false;
    });

    return jsonData as List<dynamic>;
  }

  Future<void> removeFn(String remove)async {
    final url = Uri.parse('${MyConfigs.hostIP}update_remove_list.php');
    final response = await http.post(url,body: {
      's_no': remove,
      'completed': '0'
    });
    if(response.statusCode == 200){
      //print('Removed');

      Fluttertoast.showToast(
          msg: "Task moved to home page",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );

      complete();
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
  
  Future<void> deleteFn(String delete) async{
    final url = Uri.parse('${MyConfigs.hostIP}todo_delete_list.php');
    final response = await http.post(url,body: {
      's_no':delete,
      'delete':'2'
    });
    if(response.statusCode == 200){
      //print('Deleted Successfully');
      Fluttertoast.showToast(
          msg: "Task Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          fontSize: 16.0
      );
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

  Future<void> _refresh() async {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Task'),backgroundColor: Color(0x3ff990011),),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),

        child: Stack(
          children: [
            RefreshIndicator(
              color: Color(0x3df990011),
              backgroundColor: Color(0x3ffffffff),
              displacement: 50,
              edgeOffset: 0,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: complete,

              child: ListView.builder(itemCount: mData!.length,itemBuilder: (BuildContext context,index) {
                final items = mData![index];
                return Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [

                      Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: 60,
                            width: 402,
                            color: Color(0x3df990011),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(items['title'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all(color: Color(0x399990011)),borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                              child: Container(
                                height: 135,
                                width: 420,
                                color: Color(0x3fff7e6e4),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Text(items['description']),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),color: Color(0x3ffCC313D)),
                            width: 36,
                            height: 36,
                            child: Icon(Icons.delete_outline_rounded,color: Colors.white,),
                          ),
                          onTap: (){
                            deleteFn(items['s_no']);
                          },
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        right: 50,
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),color:Color(0x3ffCC313D)),
                            width: 36,
                            height: 36,
                            child: Icon(Icons.refresh_rounded,color: Colors.white,),
                          ),
                          onTap: (){
                            removeFn(items['s_no']);
                          },
                        ),
                      ),

                   

                     /* Visibility(
                          visible: isLoading,
                          child: CircularProgressIndicator())*/
                    ],
                  ),
                );
              }),
            ),

            Visibility(
                visible: isLoading,
                child: Center(child: CircularProgressIndicator(color: Color(0x3ff990011),)))
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    complete();
    super.initState();
  }
}
