import 'package:flutter/cupertino.dart';

class ShopProvider with ChangeNotifier{

  late String ID;
  late String userID;
  late String Logo;
  late String ShopIm;
  late String ShopNem;
  late String Phone;
  late String Mail;
  late String Tax;
  late String Tin;
  late String Ad;
  late String Lon;
  late String Lat;
  late String Time1;
  late String State1;
  late String Serve;
  late String open1;
  late String Rating;
  late String totalRating1;
  late String isTopPicked;
  late String creat_T;


  getselectedShop(id,uid,logo,shopim,shopnem,phon,mail,tax,tin,ad,lon,lat,time,state,service,open,rating,toto,picked,cret){
    ID=id;
    userID=uid;
    Logo=logo;
    ShopIm=shopim;
    ShopNem=shopnem;
    Phone =phon;
    Mail = mail;
    Tax   = tax;
    Tin   =tin;
    Ad  = ad;
    Lon  =lon ;
    Lat  = lat;
    Time1  = time;
    State1  = state;
    Serve  = service;
    open1  = open;
    Rating  = rating;
    totalRating1  = toto;
    isTopPicked = picked;
    creat_T  =cret ;
    notifyListeners();
  }

}