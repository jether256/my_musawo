
import 'package:flutter/cupertino.dart';

class GlobalColors{
 static const Color bottomAppBarColor=Color.fromARGB(255,49,52,63);
 static const Color IconTemeBlue=Color.fromARGB(255,100,100,100);
 static const Color kBack=Color(0xFFDAEFE8);
 static const Color kPrimaryLight=Color(0xFFEDF6F3);
 static const Color kPrimary=Color(0xFFEDF6F3);


static  const  AppGradient=LinearGradient(
    colors:[
      Color.fromARGB(255,80,201,192),
      Color.fromARGB(255,25,221,21),
    ],
    stops: [0.5,1.0],
  );

 static const LinearGradient buttonGradient=LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      colors: []
  );
}