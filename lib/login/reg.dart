import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


import '../Provider/auth.dart';
import '../crypt/encrypt.dart';
import 'login.dart';

class Reg extends StatefulWidget {

  static const  String id='Reg';

  @override
  _RegState createState() => _RegState();
}

class _RegState extends State<Reg> {


  final _formKey=GlobalKey<FormState>();
  final _nName=TextEditingController();
  final _contNum=TextEditingController();
  final _ema=TextEditingController();
  final _pass=TextEditingController();
  final _addressController=TextEditingController();
  final _lonontroller=TextEditingController();
  final _LatController=TextEditingController();






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


  _scaffold(message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),
      action: SnackBarAction(label: 'Ok',onPressed: (){
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
  }





    register() async {

    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/user.php'),

        body:{"name":_nName.text,"number":_contNum.text,"email":_ema.text,"password":_pass.text, });



    if(response.statusCode==200){
      var userData=json.decode(response.body);

      if(userData=="ERROR"){


        showDialog(
          context: (context),
          builder:(context)=> AlertDialog(
            title:const Text('Message'),
            content:const Text('Email already exists') ,
            actions:<Widget> [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
                ),
                onPressed:(){
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),),

            ],
          ),
        );



      }else{


        Navigator.pushReplacementNamed(context,LoginForm.id);

        showDialog(
          context: (context),
          builder:(context)=> AlertDialog(
            title:const Text('Message'),
            content:const Text('Registration successful!!') ,
            actions:<Widget> [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Colors.lightGreen),
                ),
                onPressed:(){
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),),

            ],
          ),
        );
        print(userData);
      }

    }



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
    final _authData = Provider.of<AuthProvider>(context);

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
                  'Register',
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


                const Text('Enter Name,Email,Number ,Password and Location to Register',style: TextStyle(color:Colors.grey),),


                const SizedBox(
                  height: 10,
                ),



                _formField(
                    controller:_nName,
                    label:'Name',
                    type: TextInputType.text,

                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your Name';

                      }
                    }
                ),

                const SizedBox(
                  height: 10,
                ),


                _formField(
                    controller:_contNum,
                    label:'Phone Number',
                    type: TextInputType.text,

                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your Phone Number';

                      }
                    }
                ),

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


                InkWell(
                  onTap: () {
                    //lets show the list of cars instead of manually typing
                    _authData.getCurrentAddress().then((address) {
                      if (address != null) {
                        setState(() {
                          _addressController.text =
                          //'${_authData.placeName}\n${_authData.shopAdd}';
                          '${_authData.shopAdd}';
                        });
                      } else {
                        _scaffold('Could not find location try again');
                        return;
                      }
                    });
                  },
                  child: TextFormField(
                    controller: _addressController,
                    maxLines: 4,
                    minLines: 2,
                    enabled: false,
                    //enter manually now

                    decoration: const InputDecoration(
                      labelText: 'Address',
                      counterText: 'SellerAddress',
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please complete required field';
                      }
                      return null;
                    },

                  ),
                ),

                const SizedBox(height: 10,),


                Row(
                  children:[
                    const Text('New Account?'),
                    TextButton(
                      onPressed:(){
                        Navigator.pushReplacementNamed(context,LoginForm.id);
                      },
                      child:const Text('Login',style: TextStyle(color:Colors.lightGreen,fontWeight: FontWeight.bold),),
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
                  async {

                    if(_formKey.currentState!.validate()){

                    }

                    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/user/reg.php'),

                        body:{"name":encryp(_nName.text),
                          "number":encryp(_contNum.text),
                          "email":encryp(_ema.text),
                          "password":encryp(_pass.text),
                          "address":encryp(_addressController.text),
                         "lon":encryp('${_authData.shopLongitude}'),
                         "lat":encryp('${_authData.shopLatitude}'),
                        });



                    if(response.statusCode==200){
                      var userData=json.decode(response.body);

                      if(userData=="ERROR"){


                        showDialog(
                          context: (context),
                          builder:(context)=> AlertDialog(
                            title:const Text('Message'),
                            content:const Text('Email already exists') ,
                            actions:<Widget> [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
                                ),
                                onPressed:(){
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),),

                            ],
                          ),
                        );



                      }else{


                        Navigator.pushReplacementNamed(context,LoginForm.id);

                        showDialog(
                          context: (context),
                          builder:(context)=> AlertDialog(
                            title:const Text('Message'),
                            content:const Text('Registration successful!!') ,
                            actions:<Widget> [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:MaterialStateProperty.all(Colors.lightGreen),
                                ),
                                onPressed:(){
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),),

                            ],
                          ),
                        );
                        print(userData);
                      }

                    }



                  },
                  child:const Text('Register',style: TextStyle(color: Colors.white),),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


}
