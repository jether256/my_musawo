class ClosingDateModel {
  final String ID;
  final String Docid;
  final String date;
  final  String isDel;

  ClosingDateModel({
    required this.ID, required this.Docid, required this.date, required this.isDel,
  });


  factory ClosingDateModel.fromJson(data){
    return   ClosingDateModel(
      ID:data['id'],
      Docid:data['doctId'],
      date:data['date'],
      isDel:data['isDeleted'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id": ID,
      "doctId":Docid,
      "date":date,
      "isDeleted":isDel,
    };
  }



  factory ClosingDateModel.fromMap(Map<String, dynamic> data) {
    return ClosingDateModel(
      ID:data['id'],
      Docid:data['doctId'],
      date:data['date'],
      isDel:data['isDeleted'],
    );
  }

}
