import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/blogs.dart';

class SingleScreen extends StatefulWidget {
  final Blog? blog;

  SingleScreen({required this.blog});

  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  late SharedPreferences sharedPreference;

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    //Instantiating the object of SharedPreferences class.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detailed View')),
      body: Container(
        color: Color.fromARGB(255, 245, 244, 244),
        margin: EdgeInsets.symmetric(vertical: 105, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 1050,
        width: double.maxFinite,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async{
                   sharedPreference = await SharedPreferences
        .getInstance();
                  List<Blog> userList =
                      jsonDecode(sharedPreference.getString('list')!);
                  userList.add(widget.blog!);
                  sharedPreference.setString("list", jsonEncode(userList));
                  Fluttertoast.showToast(
                    msg: 'Blog Added to Favourite',
                    backgroundColor: Colors.grey,
                  );
                  print(userList.length);
                  print('hello');
                },
                child: Text('Add to Favourite')),
            Expanded(
                flex: 3,
                child: Text(
                  widget.blog!.title!,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
            SizedBox(width: 10),
            Container(
              height: 200, // Set a fixed height of 200 pixels
              width: double.maxFinite, // Expand to full screen width
              child: Expanded(
                  child: Image.network(widget.blog!.image_url!,
                      fit: BoxFit
                          .cover)), // Use BoxFit.cover to maintain the image's aspect ratio
            ),
          ],
        ),
      ),
    );
  }
}
