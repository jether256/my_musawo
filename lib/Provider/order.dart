

import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier{

  late String status;
  late String amount;
   bool success=false;


  filterOrder(sta){
    this.status=sta;
    notifyListeners();
  }



  totalAmount(String price){

    this.amount=price.toString as String;
    notifyListeners();
  }


  paymentStatus(succe){

    this.success=succe;
    notifyListeners();
  }


}