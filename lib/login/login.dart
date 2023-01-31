import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:my_musawo/logged/dashlogged.dart';
import 'package:my_musawo/login/reg.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../crypt/encrypt.dart';
import '../pref/pref.dart';


class LoginForm extends StatefulWidget {
  static const  String id='login';


  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey=GlobalKey<FormState>();
  final _businessName=TextEditingController();
  final _contNum=TextEditingController();
  final _ema=TextEditingController();
  final _pass=TextEditingController();





  //https://bodayo.000webhostapp.com/api/user/reg.php



  Widget _formField({TextEditingController? controller,String? label,TextInputType? type,
    String? Function(String?)? validator}){
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixText:controller ==_contNum ?'+256':null,

        contentPadding: const EdgeInsets.only(left: 10),
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4)
        ),
      ),
      validator: validator,



    );
  }



  login() async {

    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/user/login.php'),

        body:{"email":encryp(_ema.text),"password":encryp(_pass.text),});



    if(response.statusCode==200){
      var userData=json.decode(response.body);

      String ID=userData['id'];
      String name=userData['name'];
      String email=userData['email'];
      String num=userData['number'];
      String pass=userData['password'];
      String pic=userData['pic'];
      String lon=userData['lon'];
      String lat=userData['lat'];
      String ad=userData['address'];
      String city=userData['city'];
      String country=userData['country'];
      String status=userData['status'];
      String type=userData['type'];
      String log=userData['last_log'];
      String create=userData['create_date'];
      String cr=userData['create_t'];
      String up=userData['update_t'];
      String fcm=userData['fcmid'];


      if(userData=="ERROR"){


        showDialog(
          context: (context),
          builder:(context)=> AlertDialog(
            shape:Border.all(color: Colors.grey),
            backgroundColor: Colors.red,
            title:const Text('Message',style: TextStyle(color: Colors.white),),
            content:const Text('Logged In Failed',style: TextStyle(color: Colors.white),) ,
            actions:<Widget> [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
                ),
                onPressed:(){
                  Navigator.pop(context);
                },
                child: const Text('Cancel',style: TextStyle(color: Colors.white),),),

            ],
          ),
        );



      }else{




        if(userData['type']=='user'){
          savePref(ID, name, email, num, pass, pic, lon, lat, ad, city, country, status, type, log, create,cr,up,fcm);

          Navigator.pushReplacementNamed(context,DashboardLogged.id);
          //Navigator.pushReplacementNamed(context, Register.id);

          showDialog(
            context: (context),
            builder:(context)=> AlertDialog(
              shape:Border.all(color: Colors.grey),
              backgroundColor: Colors.purple,
              title:const Text('Message',style: TextStyle(color: Colors.white),),
              content:const Text('Logged In Successfully',style: TextStyle(color: Colors.white),) ,
              actions:<Widget> [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
                  ),
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',style: TextStyle(color: Colors.white),),),

              ],
            ),
          );

        }else{



          showDialog(
            context: (context),
            builder:(context)=> AlertDialog(
              shape:Border.all(color: Colors.grey),
              backgroundColor: Colors.purple,
              title:const Text('Message',style: TextStyle(color: Colors.white),),
              content:const Text('Please Login in The Doctor App',style: TextStyle(color: Colors.white),) ,
              actions:<Widget> [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
                  ),
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',style: TextStyle(color: Colors.white),),),

              ],
            ),
          );

        }

        print(userData);
      }

    }



  }



  String? userID,name,email,num, pass, pic,lon, lat,ad, city,country,status,type,log,create,cry,uup,fcmi;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefInfo.ID);
      name = sharedPreferences.getString(PrefInfo.name);
      email = sharedPreferences.getString(PrefInfo.email);
      num = sharedPreferences.getString(PrefInfo.num);
      pass = sharedPreferences.getString(PrefInfo.pass);
      pic = sharedPreferences.getString(PrefInfo.pic);
      lon = sharedPreferences.getString(PrefInfo.lon);
      lat = sharedPreferences.getString(PrefInfo.lat);
      ad = sharedPreferences.getString(PrefInfo.ad);
      city = sharedPreferences.getString(PrefInfo.city);
      country = sharedPreferences.getString(PrefInfo.country);
      status = sharedPreferences.getString(PrefInfo.status);
      type = sharedPreferences.getString(PrefInfo.type);
      log = sharedPreferences.getString(PrefInfo.log);
      create = sharedPreferences.getString(PrefInfo.create);
      cry = sharedPreferences.getString(PrefInfo.cry);
      uup = sharedPreferences.getString(PrefInfo.uup);
      fcmi = sharedPreferences.getString(PrefInfo.fcmi);
    });
  }

  savePref(
      String ID ,String name,String email, String num,String pass,String pic ,String lon,String lat,
      String ad,String city,String country,String status ,String type, String log,String create, String cr, String up,String fcm
      ) async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString(PrefInfo.ID, ID);
      sharedPreferences.setString(PrefInfo.name, name);
      sharedPreferences.setString(PrefInfo.email,email);
      sharedPreferences.setString(PrefInfo.num,num);
      sharedPreferences.setString(PrefInfo.pass, pass);
      sharedPreferences.setString(PrefInfo.pic, pic);
      sharedPreferences.setString(PrefInfo.lon, lon);
      sharedPreferences.setString(PrefInfo.lat, lat);
      sharedPreferences.setString(PrefInfo.ad,ad);
      sharedPreferences.setString(PrefInfo.city, city);
      sharedPreferences.setString(PrefInfo.country, country);
      sharedPreferences.setString(PrefInfo.status, status);
      sharedPreferences.setString(PrefInfo.type, type);
      sharedPreferences.setString(PrefInfo.log, log);
      sharedPreferences.setString(PrefInfo.create, create);
      sharedPreferences.setString(PrefInfo.cry, cr);
      sharedPreferences.setString(PrefInfo.uup, up);
      sharedPreferences.setString(PrefInfo.fcmi, fcm);
    });

  }



  @override
  Widget build(BuildContext context) {


    const colorizeColors=[
      Colors.white,
      Colors.grey,
    ];

    const colorizeTextStyle=TextStyle(
      fontSize: 20.0,
      fontFamily: 'Gothic',
    );


    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            elevation: 0,
            centerTitle: false,
            backgroundColor:Colors.lightGreen,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            title: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Login',
                  textStyle:colorizeTextStyle,
                  colors:colorizeColors,
                ),
              ],
            ),

          ),
        ),
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:   [
                const SizedBox(
                  height: 40,
                ),

                 CircleAvatar(
                  radius:30 ,
                  backgroundColor: Colors.blueGrey,
                  // child: Icon(
                  //   CupertinoIcons.person_alt_circle,
                  //   color: Colors.red,
                  //   size: 60,
                  // ),
                  child:Image.asset('assets/images/doc.png'),

                ),

                const SizedBox(
                  height: 12,
                ),

                const Text('Welcome ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.lightGreen),),

                const SizedBox(
                  height: 10,
                ),


                const Text('Enter Email and Password to Login',style: TextStyle(color:Colors.grey),),


                const SizedBox(
                  height: 10,
                ),

                _formField(
                    controller:_ema,
                    label:'Email',
                    type: TextInputType.emailAddress,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Email';

                      }
                      bool _isValid= (EmailValidator.validate(value));
                      if(_isValid==false){
                        return 'Enter Valid Email Address';

                      }




                    }
                ),

                const SizedBox(height: 10,),

                _formField(
                    controller:_pass,
                    label:'Password',
                    type: TextInputType.visiblePassword,

                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your Password';

                      }
                    }
                ),

                const SizedBox(height: 10,),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Forgot Password?',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightGreen),),

                ),

                Row(
                  children:[
                    const Text('New Account?'),
                    TextButton(
                      onPressed:(){
                        Navigator.pushReplacementNamed(context,Reg.id);
                      },
                      child:const Text('Register',style: TextStyle(color:Colors.lightGreen,fontWeight: FontWeight.bold),),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(

                child: ElevatedButton(
                  onPressed:()
                  {

                    if(_formKey.currentState!.validate()){

                      login();
                    }

                  },
                  child:const Text('Login',style: TextStyle(color: Colors.white),),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
