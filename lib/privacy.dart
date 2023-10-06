import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config_data.dart';
import 'package:http/http.dart' as http;

class privacy_ extends StatefulWidget {
  const privacy_({super.key});

  @override
  State<privacy_> createState() => _privacy_State();
}

class _privacy_State extends State<privacy_> {
  Future<List<dynamic>> termsFn() async {
    final url = Uri.parse('${MyConfigs.hostIP}terms.php');
    final response = await http.post(url, body: {
      'id':'2',
    });
    final jsonData = json.decode(response.body);
    return jsonData as List<dynamic>;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Statement'),backgroundColor: Color(0x3ffEE4E34),),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<dynamic>>(
              future: termsFn(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Container(
                    height: 680,
                    child: ListView.builder(itemCount: snapshot.data!.length,itemBuilder: (BuildContext context, index){
                      final items = snapshot.data![index];
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: Color(0x3bfEE4E34)),borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Color(0x3ffFCEDDA),
                              height: 670,
                              width: 400,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 1),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Privacy Statement',style: TextStyle(fontSize: 25),),
                                    SizedBox(height: 15),
                                    Text(items['content']),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }else{
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
