import 'package:apiflutter/home_screen.dart';
import 'package:apiflutter/user_screen.dart';
import 'package:flutter/material.dart';

import 'bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavigationExample(),
      // home: const UserDetailScreen(),
      // home: const HomeScreen(),
    );
  }
}

