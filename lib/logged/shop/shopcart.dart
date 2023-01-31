import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_musawo/logged/shop/productshop.dart';
import 'package:provider/provider.dart';

import '../../Provider/cartprovider.dart';
import '../../Provider/shopprov.dart';
import '../../models/catmodel.dart';



class ShopCategory extends StatefulWidget {

  final String USERID;

  const ShopCategory({required this.USERID});

  @override
  State<ShopCategory> createState() => _ShopCategoryState();
}

class _ShopCategoryState extends State<ShopCategory> {

  int? indexx;
  bool filter=false;

  @override
  void initState(){
    super.initState();
    getCategory();
  }


  List<CategoryModel> listCategory = [];


  getCategory() async{


    var isCacheExist = await APICacheManager().isAPICacheKeyExist("MyCartegory");

    if(!isCacheExist) {

      var response = await http.get(
          Uri.parse("https://mymusawoee.000webhostapp.com/api/user/medcat.php"),
          headers: {"Accept": "headers/json"});

      print("URL:hit");

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON

        APICacheDBModel cacheDBModel= APICacheDBModel(key:"MyCartegory", syncData:response.body);
         await APICacheManager().addCacheData(cacheDBModel);

        List<dynamic> values = [];
        values = json.decode(response.body);
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              listCategory.add(CategoryModel.fromJson(map));
            }
          }
        }
        return listCategory;
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load categories');
      }


    }else{

      var cachedData= await APICacheManager().getCacheData("MyCartegory");
      print("Cache:hit");

      List<dynamic> values = [];
      values = json.decode(cachedData.syncData);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            listCategory.add(CategoryModel.fromJson(map));
          }
        }
      }
      return listCategory;


    }



  }



  @override
  Widget build(BuildContext context) {

    final _categoryProvider=Provider.of<CategoryProvider>(context);

    final _shopProvider=Provider.of<ShopProvider>(context);

    return Container(
      color: Colors.lightGreen,
      width: MediaQuery.of(context).size.width,
      child:SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              // const Center(
              //     child: Text('Shop by Category',style: TextStyle(
              //         shadows: <Shadow>[
              //           Shadow(
              //             offset: Offset(2.0, 5.0),
              //             blurRadius: 3.0,
              //             color: Colors.black,
              //
              //           ),
              //
              //
              //         ],
              //         color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
              FutureBuilder<dynamic>(
                  future:getCategory(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

                    if (snapshot.hasData) {


                      return GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: listCategory.length,
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5, mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                           // final x = listCategory[i];
                            return InkWell(
                              onTap: () {
                                //_categoryProvider.getselectedCategory(listCategory[index]['ID'],listCategory[index]['category'],listCategory[index]['image'],listCategory[index]['ono']
                                _categoryProvider.getselectedCategory(listCategory[index].ID,listCategory[index].category,listCategory[index].image,listCategory[index].status
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  Productgrid(
                                        Cat:listCategory[index].category,USERID:widget.USERID,
                                    ),
                                  ),
                                );
                                //
                                // setState(() {
                                //   indexx = index;
                                //   filter = true;
                                //   print("$index, $filter");
                                // });

                              },
                              child:SizedBox(
                                width: 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 55,
                                      height: 55,
                                      child: Card(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: CachedNetworkImage(imageUrl:'https://mymusawoee.000webhostapp.com/api/owner/drug/${listCategory[index].image}',fit: BoxFit.cover,),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Container(

                                        child:Text(listCategory[index].category,style: const TextStyle(fontSize: 12,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                      ),
                                    ),

                                    // Text('$shopDistance',style: const TextStyle(color: Colors.grey,fontSize: 10),)
                                  ],

                                ),
                              ),
                            );
                          });

                    }else{
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          'assets/images/loading.png',
                          color: Colors.white,
                        ),
                      );
                    }

                  }),
            ],
          ),
        ),
      ),
    );
  }
}
