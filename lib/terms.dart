import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/config_data.dart';

class terms_ extends StatefulWidget {
  const terms_({super.key});

  @override
  State<terms_> createState() => _terms_State();
}

class _terms_State extends State<terms_> {
  
  Future<List<dynamic>> termsFn() async {
    final url = Uri.parse('${MyConfigs.hostIP}terms.php');
    final response = await http.post(url, body: {
      'id':'1',
    });
    final jsonData = json.decode(response.body);
    return jsonData as List<dynamic>;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms And Condition'),backgroundColor: Color(0x3ffEE4E34),),
      body: Container(
        //height: 650,
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
                                    Text('Terms And Condition',style: TextStyle(fontSize: 25),),
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
