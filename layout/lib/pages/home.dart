import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_layout/pages/detail.dart';

import 'package:http/http.dart' as http; // กำหนดตัวแปร
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ความรู้เกี่ยวกับคอมพิวเตอร์"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          builder: (context, AsyncSnapshot snapshot) {
            //var data = json.decode(snapshot.data.toString()); //[{คอมพิวเตอร์คืออะไร...}.{},{},{}]
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return MyBox(
                    snapshot.data[index]['title'],
                    snapshot.data[index]['subtitle'],
                    snapshot.data[index]['image_url'],
                    snapshot.data[index]['detail']);
              },
              itemCount: snapshot.data.length,
            );
          },
          future: getData(),
        ),
      ),
    );
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      //color: Colors.blue[50],
      height: 175,
      decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black12.withOpacity(0.45), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25,
                color: Colors.yellowAccent[200],
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
          SizedBox(height: 10),
          TextButton(
              onPressed: () {
                print("Next Page >>>>");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(v1, v2, v3, v4))); //builder คือ function
              },
              child: Text("อ่านต่อ")) //ข้อความบนปุ่ม
        ],
      ),
    );
  }

  Future getData() async {
    //  https://raw.githubusercontent.com/noinoom/BasicAPI/main/data.json   การดึงข้อมูลจาก API
    var url = Uri.https('raw.githubusercontent.com',
        '/noinoom/BasicAPI/main/data.json'); // คำสั่งการใช้url
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
