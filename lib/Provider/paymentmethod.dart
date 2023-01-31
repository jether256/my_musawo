
import 'package:flutter/cupertino.dart';

class PaymentProvider with ChangeNotifier{

  bool cod=false;

  getPymentmtd(index){

    if(index==0){
      this.cod=false;

      notifyListeners();
    }else{

      this.cod=true;

      notifyListeners();
    }

  }

}