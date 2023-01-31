import 'dart:convert';

List<ProductModel> welcomeFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

// String welcomeToJson(List<ProductModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); // to list

class ProductModel {
  final String id;
  final String user_id;
  final String ownerName;
  final String shopName;
  final String productName;
  final String descc;
  final String price;
  final String comp;
  final String coll;
  final String brand;
  final String category;
  final String weight;
  final String tax;
  final String published;
  final String carType;
  final String service;
  final String pack;
  final String image;
  final String pro_id;

  ProductModel( {
    required this.id,
    required this.user_id,
    required this.ownerName,
    required this.shopName,
    required this.productName,
    required this.descc,
    required this.price,
    required this.comp,
    required this.coll,
    required this.brand,
    required this.category,
    required this.weight,
    required this.tax,
    required this.published,
    required this.carType,
    required this.service,
    required this.pack,
    required this.image,
    required this.pro_id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {

    return ProductModel(
      id: data['id'] ?? data['id'],
      user_id: data['user_id'] ?? data['user_id'],
      ownerName: data['ownerName'] ?? data['ownerName'],
      shopName: data['shopName'] ?? data['shopName'],
      productName: data['productName'] ?? data['productName'],
      descc: data['descc'] ?? data['descc'],
      price: data['price'] ?? data['price'],
      comp: data['compared'] ?? data['compared'],
      coll: data['collection'] ?? data['collection'],
      brand: data['brand'] ?? data['brand'],
      category: data['category'] ?? data['category'],
      weight: data['weight'] ?? data['weight'],
      tax: data['tax'] ?? data['tax'],
      published: data['published'] ?? data['published'],
      carType:data['carType'] ?? data['carType'],
      service:data['service'] ?? data['service'],
      pack:data['pack'] ?? data['pack'],
      image: data['image'] ?? data['image'],
      pro_id: data['pro_id'] ?? data['pro_id'],
    );
  }




}
