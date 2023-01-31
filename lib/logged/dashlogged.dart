
import 'package:flutter/material.dart';
import 'package:my_musawo/logged/account/applo.dart';
import 'package:my_musawo/logged/account/histolo.dart';
import 'package:my_musawo/logged/homescreenlo.dart';
import 'package:my_musawo/logged/prolo.dart';

class DashboardLogged extends StatefulWidget {

  static const  String id='dash logged';

  @override
  State<DashboardLogged> createState() => _DashboardLoggedState();
}

class _DashboardLoggedState extends State<DashboardLogged> {

  int _selectedIndex=0;
  static const TextStyle optionStyle=TextStyle(fontSize: 30,fontWeight: FontWeight.bold);

  static  final List<Widget> _widgetOptions=<Widget>[

    HomeScreenLogged(),
    AppointmentLogged(),
    HistoryLogged(),
    ProfileLogged(),
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
        backgroundColor: Colors.lightGreen,
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
