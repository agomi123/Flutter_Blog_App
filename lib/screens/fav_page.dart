import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subspace/screens/SinglePage.dart';

import '../model/blogs.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
   Future<List<Blog>> postsFuture = getPosts();
   static late SharedPreferences sharedPreference;

  static Future<List<Blog>> getPosts() async {
      sharedPreference = await SharedPreferences
        .getInstance();
      List<Blog> userList = jsonDecode(sharedPreference.getString('list')!);
    return userList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        // FutureBuilder
        child: FutureBuilder<List<Blog>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildPosts())
              final posts = snapshot.data!;
              return buildPosts(posts);
            } else {
              // if no data, show simple Text
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }
Widget buildPosts(List<Blog> posts) {
    // ListView Builder to show data in a list
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return InkWell(
          onTap: (){
             Navigator.push( 
                        context, 
                        MaterialPageRoute( 
                            builder: (context) => 
                                SingleScreen(blog:posts[index])));
          },
          child: Container(
            color: Color.fromARGB(255, 245, 244, 244),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 250,
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                height: 200, // Set a fixed height of 200 pixels
                width: double.maxFinite, // Expand to full screen width
                child: Expanded(child: Image.network(post.image_url!, fit: BoxFit.cover)), // Use BoxFit.cover to maintain the image's aspect ratio
              ),
                // SizedBox(height: 10),
                Expanded(flex: 3, child: Text(post!.title!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
                 SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}