class CatModel {
  final String ID;
  final String meid;
  final String selid;
  final String qty;
  final String price;
  final String com;
  final String pro;
  final String proid;
  final String wei;
  final String image;
  final String total;
  final String shop;

  CatModel(
      {required this.meid, required this.selid, required this.qty, required this.price, required this.com, required this.pro, required this.proid, required this.wei, required this.image, required this.total, required this.shop, required this.ID,});


  factory CatModel.fromJson(data) {
    return CatModel(
      ID: data['ID'],
      meid: data['me_id'],
      selid: data['user_id'],
      qty: data['qty'],
      price: data['price'],
      com: data['compared'],
      pro: data['product'],
      proid: data['pro_id'],
      wei: data['weight'],
      image: data['image'],
      total: data['total'],
      shop: data['shop'],
    );
  }

  Map toMap() {
    return {
      "ID": ID,
      "me_id": meid,
      "user_id": selid,
      "qty": qty,
      "price": price,
      "compared": com,
      "product": pro,
      "pro_id": proid,
      "weight": wei,
      "image": image,
      "total": total,
      "shop": shop,
    };
  }

}