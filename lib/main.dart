import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Future<dynamic> getApiData() async{
     http.Response response= await http.get("https://reqres.in/api/users?page=2");

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WinHarry',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'WingHerry'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var userData;

  Future getApiData() async{
  var data=await  http.get("https://reqres.in/api/users?page=2");

  userData=await jsonDecode(data.body)['data'];
  print(userData);
  return userData;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),

      body: Container(
        child: FutureBuilder(
          future: getApiData(),
          builder: (BuildContext  context,AsyncSnapshot snapshot){
            if(snapshot.hasData){
              print("not null");
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext bc, int i){
                    return Card(
                      child: Row(
                        children: [
                          CircleAvatar(radius: 50,
                            backgroundImage: NetworkImage((userData[i]['avatar'])
                            ),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text("Name:", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 20,),

                              Text("Email:", style: TextStyle(fontWeight: FontWeight.bold)),

                            ],
                          ),
                          SizedBox(width: 20,),

                          Column(
                            children: [
                              Text(userData[i]['first_name'].toLowerCase()  +" "+userData[i]['last_name'].toLowerCase() ),
                              SizedBox(height: 20,),
                              Text(userData[i]['email']),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
            else{
              return Center(
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey,
                    child: Text(
                      'Loading...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }
          },


        ),
      ),
    );
  }
}
