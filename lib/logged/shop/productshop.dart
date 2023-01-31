import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_musawo/logged/shop/shoproduct.dart';
import 'package:provider/provider.dart';

import '../../Provider/productprovider.dart';
import '../../Provider/shopprov.dart';
import '../../models/productMo.dart';
import '../prologged/productdeatils.dart';


class Productgrid extends StatefulWidget {

  final String Cat;
  final String USERID;

  const Productgrid({required this.Cat,required this.USERID});


  @override
  State<Productgrid> createState() => _ProductgridState();
}

class _ProductgridState extends State<Productgrid> {

int? index;
bool filter=false;




@override
void didChangeDependencies() {


  final _shopProvider=Provider.of<ShopProvider>(context);


  getProduct(_shopProvider);

  super.didChangeDependencies();
}


  //
  // @override
  // void initState(){
  //   super.initState();
  //   getProduct();
  // }


  List< ProductModel> listProduct = [];

  //late  List listProduct=[];

  getProduct(ShopProvider shopProvider) async{

    var isCacheExist = await APICacheManager().isAPICacheKeyExist("MyProductPro");

    if(!isCacheExist) {


      var response = await http.post(Uri.parse(
          "https://mymusawoee.000webhostapp.com/api/user/medproone.php"),
          headers: {"Accept": "headers/json"}, body: {'category': widget.Cat,'user_id':widget.USERID,});

      print("URL:hit");

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        APICacheDBModel cacheDBModel= APICacheDBModel(key:"MyProductPro", syncData:response.body);
        await APICacheManager().addCacheData(cacheDBModel);

        List<dynamic> values = [];
        values = json.decode(response.body);
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              listProduct.add(ProductModel.fromJson(map));
            }
          }
        }
        return listProduct;
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load products');
      }


    }else{

      var cachedData= await APICacheManager().getCacheData("MyProductPro");
      print("Cache:hit");

      List<dynamic> values = [];
      values = json.decode(cachedData.syncData);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            listProduct.add(ProductModel.fromJson(map));
          }
        }
      }
      return listProduct;


    }





  }

  //listCategory.add(CategoryWithProduct.fromJson(item));


  @override
  Widget build(BuildContext context) {

    final _productsProvider=Provider.of<ProductProvider>(context);
    final _shopProvider=Provider.of<ShopProvider>(context);


    return Scaffold(
     appBar: AppBar(
        elevation: 0,
       iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.lightGreen
          ),
        ),
        title: const Text('Products',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Container(
          child:FutureBuilder<dynamic>(
              future:getProduct(_shopProvider),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

                if (snapshot.hasData) {


                  if(snapshot.data.length == 0) {

                    return Column(
                      children:  [
                        Container(
                          alignment: Alignment.center,
                            child: const Center(child: Text('No Products in this category',))
                        ),
                      ],
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Padding(
                          padding: EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Text('Medical Products ',style: TextStyle(color: Colors.lightGreen,fontSize: 18,fontWeight: FontWeight.bold),),
                        ),



                        GridView.builder(
                            shrinkWrap: true,
                            physics:const ScrollPhysics(),
                            gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2/3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 10,
                            ),
                            itemCount:listProduct.length,
                            itemBuilder: (BuildContext context, int index) {

                              return InkWell(
                                onTap: ()
                                {
                                  _productsProvider.getselectedProduct(listProduct[index].id,listProduct[index].user_id,listProduct[index].ownerName,listProduct[index].shopName,listProduct[index].productName,listProduct[index].descc,
                                      listProduct[index].price,listProduct[index].comp,listProduct[index].coll,listProduct[index].brand,listProduct[index].category,listProduct[index].weight,
                                      listProduct[index].tax,listProduct[index].published,listProduct[index].carType,listProduct[index].service,listProduct[index].pack,listProduct[index].image,listProduct[index].pro_id
                                  );


                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  ShopProduct(ID:listProduct[index].id,userID:listProduct[index].user_id,Owner:listProduct[index].ownerName,Shop:listProduct[index].shopName,Pro:listProduct[index].productName,Des:listProduct[index].descc,
                                          Price:listProduct[index].price,Comp:listProduct[index].comp,Coll:listProduct[index].coll,Brand:listProduct[index].brand,Cat:listProduct[index].category,Wei:listProduct[index].weight,Tax:listProduct[index].tax,
                                          Pub:listProduct[index].published,carType:listProduct[index].carType,Service:listProduct[index].service,Pack:listProduct[index].pack,Image:listProduct[index].image,ProID:listProduct[index].pro_id),
                                    ));



                                }
                                ,
                                child:Container(
                                  alignment: Alignment.bottomLeft,
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                                    image: DecorationImage(
                                      image:NetworkImage('https://mymusawoee.000webhostapp.com/api/owner/whole/product/${listProduct[index].image}'),
                                      fit: BoxFit.cover,

                                    ),
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,

                                      children: [

                                        Container(

                                          width:MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color:Colors.lightGreen,
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color:Theme.of(context).primaryColor.withOpacity(.8),),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(listProduct[index].productName,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                              Text('Shs${listProduct[index].price}',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.grey),),
                                              //Text(forma,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.grey),),

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ) ,
                                ),
                              );




                            }),
                      ],
                    ),
                  );

                }else{
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius:BorderRadius.circular(4),
                      child: Container(
                        color: Colors.lightGreen,
                        child: Image.asset(
                          'assets/images/loading.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }

              }),
        ),
      ),
    );
  }
}
