import 'package:flutter/cupertino.dart';

class DoctorDetailProvider with ChangeNotifier{

  late String ID;
  late String cli_id;
  late String doc_id;
  late String dep_id;
  late String name;
  late String email;
  late String image;
  late String Service;
  late String Price;
  late String Com;
  late String phone;
  late String Book;
  late String lon;
  late String lat;
  late String luncClose;
  late String luncOpen;
  late String stopBooking;
  late String Op;
  late String Close;
  late String dayCode;
  late String Servet;
  late String delete;
  late String fcmid;
  late String up;


  getselectedDocDetail(id,cid,docid,depid,nem,mail,meg,serv,pr,com,ph,bok,lo,la,lunC,lunO,stp,op,cl,day,sert,del,fc,uu){
    ID=id;
    cli_id=cid;
    doc_id=docid;
    dep_id=depid;
    name=nem;
    email=mail;
    image=meg;
    Service=serv;
    Price=pr;
    Com=com;
    phone=ph;
    Book=bok;
    lon=lo;
    lat=la;
    luncClose=lunC;
    luncOpen=lunO;
    stopBooking=stp;
    Op=op;
    Close=cl;
    dayCode=day;
    Servet=sert;
    delete=del;
    fcmid=fc;
    up=uu;

    notifyListeners();
  }

}