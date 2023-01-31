import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier{

  late String ID;
  late String userID;
  late String Owner;
  late String Shop;
  late String Pro;
  late String Des;
  late String Price;
  late String Comp;
  late String Coll;
  late String Brand;
  late String Cat;
  late String Wei;
  late String Tax;
  late String Pub;
  late String carType;
  late String Service;
  late String Pack;
  late String Image;
  late String ProID;


  getselectedProduct(id,uid,own,shop,pro,des,price,comp,col,brand,cat,wei,tax,pub,car,service,pack,mage,proid){
    ID=id;
    userID=uid;
    Owner=own;
    Shop=shop;
    Pro =pro ;
    Des = des;
    Price   = price;
    Comp   =comp ;
    Coll  = col;
    Brand  =brand ;
    Cat  = cat;
    Wei  = wei;
    Tax  = tax;
    Pub  = pub;
    carType  = car;
    Service  = service;
    Pack  = pack;
    Image  = mage;
    ProID  =proid ;
    notifyListeners();
  }

}