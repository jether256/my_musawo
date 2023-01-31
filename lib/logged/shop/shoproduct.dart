import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../Provider/productprovider.dart';
import '../bottomsheet.dart';


class ShopProduct extends StatefulWidget {

  final String ID;
  final String userID;
  final String Owner;
  final String Shop;
  final String Pro;
  final String Des;
  final String Price;
  final String Comp;
  final String Coll;
  final String Brand;
  final String Cat;
  final String Wei;
  final String Tax;
  final String Pub;
  final String carType;
  final String Service;
  final String Pack;
  final String Image;
  final String ProID;


  ShopProduct ({ required this.ID, required this.userID, required this.Owner, required this.Shop, required this.Pro, required this.Des, required this.Price, required this.Comp, required this.Coll, required this.Brand, required this.Cat, required this.Wei, required this.Tax, required this.Pub, required this.carType, required this.Service, required this.Pack, required this.Image, required this.ProID,});



  @override
  State<ShopProduct> createState() => _ShopProductState();
}

class _ShopProductState extends State<ShopProduct> {
  @override
  Widget build(BuildContext context) {
    final _productsProvider=Provider.of<ProductProvider>(context);

    var offer=(double.parse(_productsProvider.Comp) - double.parse(_productsProvider.Price)) /double.parse(_productsProvider.Comp) * 100;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.lightGreen
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title:Text( _productsProvider.Pro,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(color: Colors.white)),
      ),
      body:ListView(
        shrinkWrap: true,
        padding:const EdgeInsets.only(left: 2,right: 2),
        children: [

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    border: Border.all(
                      color: Colors.lightBlue,
                    )

                ),

                child:  Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8,bottom: 2, top:2),
                  child: Row(
                    children: [

                      Text(_productsProvider.Brand,style: const TextStyle(fontSize:22 ,color:Colors.white),),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10,),

          Text(_productsProvider.Pro,style: const TextStyle(fontSize:22 ),),

          const SizedBox(height: 10,),

          Text(_productsProvider.Wei,style: const TextStyle(fontSize: 22),),

          const SizedBox(height: 10,),

          Row(
            children: [
              Text('Shs ${_productsProvider.Price}',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              const SizedBox(width:6 ,),
              Text('Shs ${_productsProvider.Comp}',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough,color: Colors.grey,fontSize: 14),),
              const SizedBox(width: 10,),

              if(double.parse( _productsProvider.Comp) > double.parse(_productsProvider.Price))
                Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(4),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8,top: 3,bottom: 3),
                    child: Text('${offer.toStringAsFixed(0)}% OFF',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                  ),
                ),

            ],
          ),


          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: 'https://mymusawoee.000webhostapp.com/api/owner/whole/product/${_productsProvider.Image}',fit: BoxFit.cover,
              ),
            ),
          ),

          Divider(color: Colors.grey[300],thickness: 6,),

          Container(
            child: const Padding(
              padding: EdgeInsets.only(top: 8.0,bottom: 8),
              child: Text('About this Product'),
            ),
          ),

          Divider(color: Colors.grey[300]),

          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8),
            child:ExpandableText(
              _productsProvider.Des,
              expandText: 'View More',
              collapseText: 'View Less',
              maxLines: 2,
              style: const TextStyle(color:Colors.grey),
            ),
          ),

          Divider(color: Colors.grey[400]),

          Container(
            child: const Padding(
              padding: EdgeInsets.only(top: 8.0,bottom: 8),
              child: Text('Other Product Info',style: TextStyle(fontSize: 20),),
            ),
          ),

          Divider(color: Colors.grey[400]),


          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 8,top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PRODUCT ID: ${_productsProvider.ProID}',style: const TextStyle(color: Colors.grey),),
                Text('ShopName: ${_productsProvider.Shop}',style: const TextStyle(color: Colors.grey),),

              ],
            ),
          ),
          const SizedBox(height: 60,),




        ],
      ),
      bottomSheet: const BottomSheetContainer(),
    );
  }
}
