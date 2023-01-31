import 'package:flutter/material.dart';
import 'package:my_musawo/categories/cart.dart';
import 'package:my_musawo/login/login.dart';

import 'package:http/http.dart' as http;
import 'package:my_musawo/product/product.dart';
import 'dart:convert';

import 'package:my_musawo/product/slider.dart';

import 'models/catmodel.dart';


class HomeScreen extends StatefulWidget {

  static const  String id='homenot';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<CategoryModel> listCategory = [];

  getCategory() async{
    listCategory.clear();
    var response = await http.get(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/user/medcat.php"),
        headers: {"Accept": "headers/json"});

    if (response.statusCode == 200) {

      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCategory.add(CategoryModel.fromJson(item));
        }
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.lightGreen
          ),
        ),
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/images/med.png',width: 120,height: 45,color: Colors.white,),
            ),
            


            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  children:  [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context,LoginForm.id);
                        },
                          child: const Icon(Icons.account_circle,color: Colors.white,)
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context,LoginForm.id);
                        },
                          child: const Icon(Icons.shopping_cart,color: Colors.white,)
                      ),
                    ),

                  ],
                ),
              ),

            ),
          ],
        ),
        bottom:  PreferredSize(
          preferredSize:const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Doctor,medicine,hospital,clinic,Drug shop',
                prefixIcon: const Icon(Icons.search,color: Colors.grey,),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide.none
                ),
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),

      ),
      body:ListView(

        padding:const EdgeInsets.only(left: 2,right: 2),
        children: [

          const ImageSlider(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius:BorderRadius.circular(4),
              child: Container(
                height: 120,
                color: Colors.red,
                child: Categories(),
              ),
            ),
          ),

          Product(),



        

        ],
      )    );
  }
}
