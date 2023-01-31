import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier{

  late String ID;
  late String Cat;
  late String Image;
  late String Ono;

  getselectedCategory(id,cat,mage,on){
    ID=id;
    Cat=cat;
    Image=mage;
    Ono=on;
    notifyListeners();
  }

}