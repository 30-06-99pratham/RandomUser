import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class my_home_page extends StatefulWidget {
  @override
  _my_home_pageState createState() => _my_home_pageState();
}

class _my_home_pageState extends State<my_home_page> {
  List userData = [];
  bool isloading = true;
  final String url = "https://randomuser.me/api/?results=50";
  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future getData() async {
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    List data = jsonDecode(response.body)['results'];
    setState(() {
      userData = data;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random users"),
      ),
      body: Container(
        child: Center(
          child: isloading
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: userData == null ? 0 : userData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(20.0),
                            child: Image(
                              width: 70.0,
                              height: 70.0,
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                userData[index]['picture']['thumbnail'],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  userData[index]['name']['first'] +
                                      " " +
                                      userData[index]['name']['first'],
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Icon(Icons.phone),
                                Text("Phone: ${userData[index]['phone']}"),
                                Text("gender: ${userData[index]['gender']}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
