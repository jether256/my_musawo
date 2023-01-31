import 'package:flutter/cupertino.dart';

class SliderProvider with ChangeNotifier{

   late String ID;
   late String Title;
   late String userID;
   late String Owner;
   late String Shop;
   late String Image;
   late String Lat;
   late String Lon;
   late String Ad;
   late String Paid;
   late String Mount;
   late String Duration;
   late String Date;

  getselectedSlider(id,tit,uid,own,shop,mage,lat,lon,ad,paid,mount,dura,date){
    ID=id;
    Title=tit;
    userID=uid;
    Owner=own;
    Shop=shop;
    Image=mage;
    Lat=lat;
    Lon=lon;
    Ad=ad;
    Paid=paid;
    Mount=mount;
    Duration=dura;
    Date=date;
    notifyListeners();
  }

}