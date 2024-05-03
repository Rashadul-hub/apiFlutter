import 'package:apiflutter/home_screen.dart';
import 'package:apiflutter/signup.dart';
import 'package:apiflutter/user_screen.dart';
import 'package:flutter/material.dart';

import 'complex_api_screen.dart';
import 'complex_object_api_screen.dart';
class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.onlyShowSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
         labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'null safety api',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'user detail api',
          ),
          NavigationDestination(
            icon: Icon(Icons.warning),
            label: 'Complex Array API',
          ),
          NavigationDestination(
            icon: Icon(Icons.api),
            label: 'Complex Object API',
          ),
          NavigationDestination(
            icon: Icon(Icons.login),
            label: 'Sign up',
          ),
        ],
      ),

      body: IndexedStack(
        index: currentPageIndex,
        children: const <Widget>[
          HomeScreen(),
          UserDetailScreen(),

          ComplexApiScreen(),
          ComplexObjectApiScreen(),
          SignUpScreen(),

        ],
      ),

    );
  }
}

