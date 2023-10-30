import 'package:flutter/material.dart';
import 'package:subspace/model/blogs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:subspace/screens/SinglePage.dart';
import 'package:subspace/screens/fav_page.dart';

class ViewListScreen extends StatefulWidget {
  const ViewListScreen({super.key});

  @override
  State<ViewListScreen> createState() => _ViewListScreenState();
}

class _ViewListScreenState extends State<ViewListScreen> {
  Future<List<Blog>> postsFuture = getPosts();
  static Future<List<Blog>> getPosts() async {
    // print("dddd");
    var url = Uri.parse("https://intent-kit-16.hasura.app/api/rest/blogs");
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "x-hasura-admin-secret":
          "32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6"
    });
    // print("Ram");
    // print(response);
    final List body = json.decode(response.body)['blogs'];
    // print(body);
    return body.map((e) => Blog.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SubSpace',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: <Widget>[
        IconButton(onPressed: () {
            Navigator.push( 
                        context, 
                        MaterialPageRoute( 
                            builder: (context) => 
                                FavPage()));
        }, icon: Icon(Icons.favorite,color: Colors.red,))
      ],
        ),
      
      body: Center(
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
