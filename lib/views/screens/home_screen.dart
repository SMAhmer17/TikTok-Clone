
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tiktok_clone/constants/constant.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Center(child: pages[pageIndex]) ,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
            setState(() {
              pageIndex = index;
            });
        } ,
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.red.shade700,
        unselectedItemColor: Colors.white,

        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label: 'Search'),
        BottomNavigationBarItem(icon: CustomIcon(), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.message, size: 30), label: 'Message'),
        BottomNavigationBarItem(icon: Icon(Icons.person, size: 30), label: 'Profile'),
      ]),
    );
  }
}
