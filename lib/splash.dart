import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:my_musawo/pref/pref.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';
import 'logged/dashlogged.dart';
import 'login/login.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

class Splash extends StatefulWidget {
  static const  String id='splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? userID,name,email,num, pass, pic,lon, lat,ad, city,country,status,type,log,create;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefInfo.ID);
      name = sharedPreferences.getString(PrefInfo.name);
      email = sharedPreferences.getString(PrefInfo.email);
      num = sharedPreferences.getString(PrefInfo.num);
      pass = sharedPreferences.getString(PrefInfo.pass);
      pic = sharedPreferences.getString(PrefInfo.pic);
      lon = sharedPreferences.getString(PrefInfo.lon);
      lat = sharedPreferences.getString(PrefInfo.lat);
      ad = sharedPreferences.getString(PrefInfo.ad);
      city = sharedPreferences.getString(PrefInfo.city);
      country = sharedPreferences.getString(PrefInfo.country);
      status = sharedPreferences.getString(PrefInfo.status);
      type = sharedPreferences.getString(PrefInfo.type);
      log = sharedPreferences.getString(PrefInfo.log);
      create = sharedPreferences.getString(PrefInfo.create);
    });
  }


//https://mymusawoe.000webhostapp.com/api/user/topdoctors.php

  //https://mymusawoe.000webhostapp.com/api/user/toppha.php



  //https://mymusawoe.000webhostapp.com/api/user/docserve.php



  //https://mymusawoe.000webhostapp.com/api/user/docspe.php

  @override
  void initState() {
    getPref();


    Timer( const Duration(seconds: 5,),(){


      getPref1();


    });

    super.initState();
  }






  String? ID1;

  getPref1() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      ID1=sharedPreferences.getString(PrefInfo.ID);

      //ID== null ? sessionLogout():sessionLogin();

      if(ID1==null){

        sessionLogout();

      }else{

          //logged in and not verified
          sessionLogin();


      }


    });
  }


  sessionLogout() {
    Navigator.pushReplacementNamed(context,DashBoard.id);
  }

  sessionLogin() {
    Navigator.pushReplacementNamed(context,DashboardLogged.id);
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors=[
      Colors.white,
      Colors.grey,
    ];

    const colorizeTextStyle=TextStyle(
      fontSize: 40.0,
      fontFamily: 'Gothic',
    );


    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie.asset(
            //   'assets/lot/jam.json',
            //   // color: Colors.white,
            //   height: 200,
            // ),
            Image.asset('assets/images/doc.png',height: 200,),

            const SizedBox(height: 10,),

            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Musawo Wange',
                  textStyle:colorizeTextStyle,
                  colors:colorizeColors,
                ),
              ],

            ),
          ],
        ),
      ),
    );
  }


}

