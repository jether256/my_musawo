import 'package:flutter/material.dart';
import 'package:my_musawo/appnot.dart';
import 'package:my_musawo/hist.dart';
import 'package:my_musawo/home.dart';
import 'package:my_musawo/profilenot.dart';
import 'home.dart';

class DashBoard extends StatefulWidget {
  static const  String id='dash';

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  int _selectedIndex=0;
  static const TextStyle optionStyle=TextStyle(fontSize: 30,fontWeight: FontWeight.bold);

   final List<Widget> _widgetOptions=<Widget>[
    
     HomeScreen(),
    AppointmentNot(),
    HistoryNot(),
    ProfileNot(),
  ];

  void _onItemTapped(int index){
    setState((){

      _selectedIndex=index;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:_widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Colors.lightGreen,
        items:const <BottomNavigationBarItem> [
          
          BottomNavigationBarItem(
            label: 'Home',
              //backgroundColor:Colors.,
              icon:Icon(Icons.home)
          ),


          BottomNavigationBarItem(
              label: 'Appointments',
             // backgroundColor:Colors.lightGreen,
              icon:Icon(Icons.calendar_month)
          ),


          BottomNavigationBarItem(
              label: 'History',
             // backgroundColor:Colors.lightGreen,
              icon:Icon(Icons.assessment)
          ),


          BottomNavigationBarItem(
              label: 'Profile',
             // backgroundColor:Colors.lightGreen,
              icon:Icon(Icons.account_circle)
          ),

        ],

        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,

      ),
    );
  }
}
