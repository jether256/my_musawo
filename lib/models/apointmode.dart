class AppointmentModel {
  final String ID;
  final String order_id;
  final String cli_id;
  final String doc_id;
  final String host_id;
  final String dep_id;
  final String docname;
  final String dept;
  final String puid;
  final String pname;
  final String age;
  final String servNem;
  final String peEmail;
  final String gmeetLink;
  final String createdTimeStamp;
  final String updatedTimeStamp;
  final String serviceTimeMin;
  final String pPhone;
  final String lon;
  final String lat;
  final String desc;
  final String search;
  final String amt;
  final String paySta;
  final String payDAy;
  final String payMode;
  final String stat;
  final String end;
  final String onli;



  AppointmentModel ( {
    required this.ID, required this.order_id, required this.cli_id, required this.doc_id, required this.host_id, required this.dep_id, required this.docname, required this.dept, required this.puid, required this.pname, required this.age, required this.servNem, required this.peEmail, required this.gmeetLink, required this.createdTimeStamp, required this.updatedTimeStamp, required this.serviceTimeMin, required this.pPhone, required this.lon, required this.lat, required this.desc, required this.search, required this.amt, required this.paySta, required this.payDAy, required this.payMode, required this.stat, required this.end, required this.onli,
  });


  factory AppointmentModel .fromJson(data){
    return   AppointmentModel (
      ID:data['id'],
      order_id:data['order_id'],
      doc_id:data['doc_id'],
      cli_id:data['cli_id'],
      host_id:data['host_id'],
      dep_id:data['dept_id'],
      docname:data['docnem'],
      dept:data['dept'],
      puid:data['puid'],
      pname:data['pname'],
      age:data['age'],
      servNem:data['servicenem'],
      peEmail:data['pEmail'],
      gmeetLink:data['gmeetLink'],
      createdTimeStamp:data['createdTimeStamp'],
     updatedTimeStamp:data['updatedTimeStamp'],
      serviceTimeMin:data['serviceTimeMin'],
      pPhone:data['pPhone'],
      lat:data['lat'],
      lon:data['lon'],
     desc:data['description'],
      search:data['searchByName'],
      amt:data['amount'],
      paySta:data['paymentStatus'],
      payDAy:data['paymentDate'],
      payMode:data['paymentMode'],
      stat:data['start_time'],
      end:data['end_time'],
      onli:data['isOnline'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id":ID ,
      "order_id":order_id ,
      "doc_id": doc_id,
      "cli_id":cli_id ,
      "host_id": host_id,
      "dept_id":dep_id ,
      "docnem":docname ,
      "dept": dept,
      "puid": puid,
      "pname": pname,
      "age":age ,
      "servicenem":serviceTimeMin ,
      "pEmail":peEmail ,
      "gmeetLink":gmeetLink ,
      "createdTimeStamp": createdTimeStamp,
      "updatedTimeStamp":updatedTimeStamp ,
      "serviceTimeMin": serviceTimeMin,
      "pPhone": pPhone,
      "lat": lat,
      "lon": lon,
      "description":desc ,
      "searchByName":search ,
      "amount":amt ,
      "paymentStatus":paySta ,
      "paymentDate":payMode ,
      "paymentMode":payDAy ,
      "start_time":stat ,
      "end_time":end ,
      "isOnline":onli ,
    };
  }



  factory AppointmentModel.fromMap(Map<String, dynamic> data) {
    return   AppointmentModel (
      ID:data['id'],
      order_id:data['order_id'],
      doc_id:data['doc_id'],
      cli_id:data['cli_id'],
      host_id:data['host_id'],
      dep_id:data['dept_id'],
      docname:data['docnem'],
      dept:data['dept'],
      puid:data['puid'],
      pname:data['pname'],
      age:data['age'],
      servNem:data['servicenem'],
      peEmail:data['pEmail'],
      gmeetLink:data['gmeetLink'],
      createdTimeStamp:data['createdTimeStamp'],
      updatedTimeStamp:data['updatedTimeStamp'],
      serviceTimeMin:data['serviceTimeMin'],
      pPhone:data['pPhone'],
      lat:data['lat'],
      lon:data['lon'],
      desc:data['description'],
      search:data['searchByName'],
      amt:data['amount'],
      paySta:data['paymentStatus'],
      payDAy:data['paymentDate'],
      payMode:data['paymentMode'],
      stat:data['start_time'],
      end:data['end_time'],
      onli:data['isOnline'],
    );
  }

}
