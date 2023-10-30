import 'package:flutter/material.dart';
import 'package:subspace/screens/ListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subspace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const ViewListScreen(),
      
    );
  }
}
