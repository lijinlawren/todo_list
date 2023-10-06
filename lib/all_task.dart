import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config_data.dart';
import 'package:todo_list/list_data.dart';
import 'package:http/http.dart' as http;

class all_task extends StatefulWidget {
  final userID;
  const all_task({super.key, required this.userID});

  @override
  State<all_task> createState() => _all_taskState();
}

class _all_taskState extends State<all_task> {

  Future<List<dynamic>> listFn() async {
    final url = Uri.parse('${MyConfigs.hostIP}todo_list_allTask.php');
    final response = await http.post(url, body: {
      'userID':widget.userID
    });

    final jsonData = json.decode(response.body);
    return jsonData as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Tasks'),backgroundColor: Color(0x3ff317773),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
                future: listFn(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ListView.builder(itemCount: snapshot.data!.length,itemBuilder: (BuildContext context,index) {
                          final items = snapshot.data![index];
                          return Container(
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  height: 60,
                                  width: 402,
                                  color: Color(0x3ff317773),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text(items['title'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(border: Border.all(color: Color(0x3af317773)),borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                    child: Container(
                                      height: 100,
                                      width: 420,
                                      color: Color(0x3ffE2D1F9),
                                      padding: EdgeInsets.all(20),
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
                          );
                        }),
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator(color: Color(0x3ff317773),));
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
