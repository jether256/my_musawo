import 'dart:convert';

List<PersonalServiceModel> welcomeFromJson(String str) => List<PersonalServiceModel>.from(
    json.decode(str).map((x) => PersonalServiceModel.fromJson(x)));


class PersonalServiceModel {
  final String ID;
  final String cli_id;
  final String doc_id;
  final String dep_id;
  final String name;
  final String email;
  final String image;
  final String Service;
  final String Price;
  final String Com;
  final String phone;
  final String Book;
  final String lon;
  final String lat;
  final String luncClose;
  final String luncOpen;
  final String stopBooking;
  final String Op;
  final String Close;
  final String dayCode;
  final String Servet;
  final String delete;
  final String fcmid;
  final String up;



  PersonalServiceModel ( {
    required this.dep_id,  required this.ID, required this.cli_id, required this.doc_id, required this.name, required this.email, required this.image, required this.Service, required this.Price, required this.Com, required this.phone, required this.Book, required this.lon, required this.lat, required this.luncClose, required this.luncOpen, required this.stopBooking, required this.Op, required this.Close, required this.dayCode, required this.Servet, required this.delete, required this.fcmid, required this.up,
  });


  factory PersonalServiceModel .fromJson(Map<String, dynamic> data){
    return   PersonalServiceModel (
      ID:data['ID'],
      cli_id:data['cli_id'],
      doc_id:data['doc_id'],
      dep_id:data['dept_id'] ,
      name:data['shopName'],
      email:data['email'],
      image:data['image'],
      Service:data['serve'],
      Price:data['price'],
      Com:data['compared'],
      phone:data['phone'],
      Book:data['booking'],
      lon:data['lon'],
      lat:data['lat'],
      luncClose:data['lunchClosingTime'],
      luncOpen:data['lunchOpeningTime'],
      stopBooking:data['stopBooking'],
      Op:data['open'],
      Close:data['close'],
      dayCode:data['dayCode'],
      Servet:data['serviceTime'],
      delete:data['isDeleted'],
      fcmid:data['fcmId'],
      up:data['updatedTimeStamp'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "cli_id":cli_id,
      "doc_id": doc_id,
      "dept_id":dep_id,
      "shopName":name,
      "email":email,
      "image":image,
      "serve":Service,
      "price":Price ,
      "compared":Com,
      "phone":phone,
      "booking":Book ,
      "lon":lon ,
      "lat":lat ,
      "lunchClosingTime":luncClose ,
      "lunchOpeningTime":luncOpen ,
      "stopBooking":stopBooking,
      "open":Op ,
      "close": Close,
      "dayCode":dayCode,
      "serviceTime":up ,
      "isDeleted":Servet,
      "fcmId":fcmid,
      "updatedTimeStamp":up,
    };
  }



  factory PersonalServiceModel .fromMap(Map<String, dynamic> data) {
    return   PersonalServiceModel (
      ID:data['ID'],
      cli_id:data['cli_id'],
      doc_id:data['doc_id'],
      dep_id:data['dept_id'] ,
      name:data['shopName'],
      email:data['email'],
      image:data['image'],
      Service:data['serve'],
      Price:data['price'],
      Com:data['compared'],
      phone:data['phone'],
      Book:data['booking'],
      lon:data['lon'],
      lat:data['lat'],
      luncClose:data['lunchClosingTime'],
      luncOpen:data['lunchOpeningTime'],
      stopBooking:data['stopBooking'],
      Op:data['open'],
      Close:data['close'],
      dayCode:data['dayCode'],
      Servet:data['serviceTime'],
      delete:data['isDeleted'],
      fcmid:data['fcmId'],
      up:data['updatedTimeStamp'],
    );
  }

}
