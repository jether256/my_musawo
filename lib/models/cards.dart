class CardsModel {

  final String ID;
  final String name;
  final String cno;
  final String cvcode;
  final String expiry;
  final String back;
  final String uid;




  CardsModel ({
    required this.ID, required this.name, required this.cno, required this.cvcode, required this.expiry, required this.back, required this.uid,
  });


  factory CardsModel .fromJson(data){
    return   CardsModel (
      ID:data['ID'],
      name:data['name'],
      cno:data['cno'],
      cvcode:data['cvvcode'] ,
      expiry:data['expiry'],
      back:data['showback'],
      uid:data['uid'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "ID": ID,
      "name":name,
      "cno": cno,
      "cvvcode":cvcode,
      "expiry":expiry,
      "showback":back,
      "uid":uid,
    };
  }



  factory CardsModel.fromMap(Map<String, dynamic> data) {
    return   CardsModel(
      ID:data['ID'],
      name:data['name'],
      cno:data['cno'],
      cvcode:data['cvvcode'] ,
      expiry:data['expiry'],
      back:data['showback'],
      uid:data['uid'],
    );
  }

}
