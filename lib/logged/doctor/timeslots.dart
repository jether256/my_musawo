
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:my_musawo/crypt/encrypt.dart';
import 'package:my_musawo/logged/doctor/togglesitch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../Provider/order.dart';
import '../../Provider/paymentmethod.dart';
import '../../loading/loading.dart';
import '../../pref/pref.dart';

import 'DateAndTimeCalculation/timeCalculation.dart';
import 'docdetails.dart';

class TimeSlots extends StatefulWidget {
  final String ID;
  final String cli_id;
  final String doc_id;
  final String dep_id;
  final String name;
  final String email;
  final String image;
  final String Service;
  final String Price;
  final String Com;
  final String phone;
  final String Book;
  final String lon;
  final String lat;
  final String luncClose;
  final String luncOpen;
  final String stopBooking;
  final String Op;
  final String Close;
  final String dayCode;
  final String Servet;
  final String delete;
  final String fcmid;
  final String up;

  TimeSlots( {
    required this.dep_id,  required this.ID, required this.cli_id, required this.doc_id, required this.name, required this.email, required this.image, required this.Service, required this.Price, required this.Com, required this.phone, required this.Book, required this.lon, required this.lat, required this.luncClose, required this.luncOpen, required this.stopBooking, required this.Op, required this.Close, required this.dayCode, required this.Servet, required this.delete, required this.fcmid, required this.up,
  });


  @override
  State<TimeSlots> createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {



  String? _adminFCMid;
   String? doctorFcm;

  int paymentValue=1;
  double _amount=0;
  bool isOnline=false;

  final _formated= NumberFormat();
  final _fomkey=GlobalKey<FormState>();

  final _age=TextEditingController();
  final _desc=TextEditingController();

  bool _Online = false;

  bool _checkingUser=false;
  bool _loading=false;


  String? uAge;
  String? uDEsc;


  final _date=TextEditingController();
  final _start=TextEditingController();
  final _end=TextEditingController();
  late TimeOfDay _selectedTime;

  String _selectedGender = 'Gender';


  @override
  void initState() {
    _date.text = "";
    _start.text = "";
    _end.text="";
    getPref();
    super.initState();

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



  _scaffold(message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),
      action: SnackBarAction(label: 'Ok',onPressed: (){
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
  }

  Future Book() async {

    EasyLoading.show(status: 'Booking...');

    var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/user/addApp.php'),
        body:{
          "doc_id":encryp(widget.doc_id),
          "docnem":encryp(widget.name),
          "service":encryp(widget.Service),
          "puid":encryp('$userID'),
          "pname":encryp('$name'),
          "age":encryp(_age.text),
          "pmail":encryp('$email'),
          "gender":encryp(_selectedGender),
          "pPhone":encryp('$num'),
          "lat":encryp('$lat'),
          "lon":encryp('$lon'),
          "desc":encryp(_desc.text),
          "amount":encryp(widget.Price),
          "appstatus":encryp('Pending'),
          "paymentStatus":encryp('Pay Later'),
          "paymentDate":encryp(_date.text),
          "paymentMode":encryp('cod'),
          "startTime":encryp(_start.text),
          "endTime":encryp(_end.text),
          "online": _Online ? encryp("true" ): encryp("false"),
        }
        );

    if(response.statusCode==200){

      var userData=json.decode(response.body);

      if(userData=="ERROR"){

        EasyLoading.showError('Doctor ${widget.name} Already booked at this time!......');


      }else{

        EasyLoading.showSuccess('Booked Succesfully.....');

        print(userData);
      }


      // EasyLoading.showSuccess('Service  Saved...');

    }else{

      EasyLoading.showError('Failed to save..');
    }


  }


  @override
    Widget build(BuildContext context) {
      var _price = int.parse(widget.Price);
      String price = _formated.format(_price);

      var _payProvider=Provider.of< PaymentProvider>(context);
      //var _orderProvider=Provider.of<OrderProvider>(context);

      // if(_patientDetailsArgs.serviceName=="Online") {
      //   setState(() {
      //   isOnline=true;
      // });
      // } else {
      //   isOnline=false;
      // }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const Text('Booking Information', style: TextStyle(
              color: Colors.white,),),
        ),
          bottomSheet:BottomAppBar(
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: NeumorphicButton(
                      onPressed: (){


                        if(_selectedGender == "Gender"){

                          _scaffold('Please select gender');

                          return;

                        }
                       // Navigator.pushReplacementNamed(context, StripeHome.id);

                        if(_fomkey.currentState!.validate()){


                          if(_Online==false){

                            Book();

                          }else{

                            EasyLoading.showSuccess("We shall show work on online payment later Thank you for using My Musawo");
                          }


                                                    //_orderProvider.totalAmount(widget.Price);
                          // Navigator.pushReplacementNamed(context, StripeHome.id).whenComplete((){
                          //
                          //   if(_orderProvider.success== true){
                          //     // _payProvider(_cartprovider,_payable,_coupon);
                          //   }
                          //
                          // });

                    // id      if(_payProvider.cod== false){
                    //         //pay online
                    //         Navigator.pushReplacementNamed(context, StripeHome.id);
                    //
                    //     }else{
                    //         //cash on delivery
                    //
                    //        // _payProvider(_cartprovider,_payable,_coupon);
                    //
                    //
                    //
                    //     }



                        }


                      },
                      style: const NeumorphicStyle(color:Colors.lightGreen),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.edit,size: 16,color: Colors.white,),
                            Text('Book',style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        body:ListView(
          padding: const EdgeInsets.only(left: 8, right: 8,bottom:85),
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.green))
                ),
                height: 81,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 78,
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                imageUrl: 'https://mymusawoee.000webhostapp.com/api/owner/logo/${widget.image}',
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    GFShimmer(
                                      child: Container(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.name,maxLines: 1,overflow:TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 20),),
                              Text(widget.Service,
                                style: const TextStyle(fontSize: 14),),
                              Text('Booking:Shs ${price}',maxLines: 1,overflow:TextOverflow.ellipsis ,style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),),

                            ],
                          ),
                        ),

                        InkWell(
                          onTap: (){

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  DoctriInfo()
                                )
                            );

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.lightGreen)
                            ),
                            child:Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children:  [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text('View Profile',maxLines: 1,overflow:TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 10,color: Colors.white),),
                                      Icon(Icons.person,color: Colors.white,),
                                    ],
                                  )
                                ],
                              ),
                            ) ,
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 10,),
              //const CodToggleSwitch(),
              Divider(color: Colors.grey[300],),
              Form(
                key: _fomkey,
                child:Card(
                  color: Colors.grey.shade100,
                  child: Column(
                    children: [

                      _stopBookingWidget(),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Flexible(child: Text('Patient Information:',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

                          ],
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          children: [
                            const Flexible(child: Text('Name*:',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen),)),
                            const SizedBox(width: 10,),
                            Flexible(child: Text('$name',maxLines: 1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:Colors.grey),)),

                          ],
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          children: [
                            const Flexible(child: Text('Email*:',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen),)),
                            const SizedBox(width: 10,),
                            Flexible(child: Text('$email',maxLines: 1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:Colors.grey),)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          children: [
                            const Flexible(child: Text('Contact*:',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen),)),
                            const SizedBox(width: 10,),
                            Flexible(child: Text('$num',maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.grey),)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          children: [
                            const Flexible(child: Text('Location*:',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen),)),
                            const SizedBox(width: 10,),
                            Flexible(child: Text('$ad',maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.grey),)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Container(
                          width:MediaQuery.of(context).size.width,
                          child: _genderDropDown(),
                        ),
                      ),

                      //age
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: TextFormField(
                          controller:_age,
                          validator: (value){
                            if(value!.isEmpty){

                              return 'Enter Age';
                            }

                            setState(() {
                              uAge=value;
                            });
                            return null;
                          },
                          decoration: InputDecoration(


                              labelText: 'Age*',
                              labelStyle: const TextStyle(color: Colors.lightGreen),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  )
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),

                      //descr
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: TextFormField(
                          controller:_desc,
                          keyboardType:TextInputType.multiline,
                          maxLines: 5,
                          maxLength: 500,
                          validator: (value){
                            if(value!.isEmpty){

                              return 'Enter Description';
                            }

                            setState(() {
                              uDEsc=value;
                            });
                            return null;
                          },
                          decoration: InputDecoration(


                              labelText: 'Description*',
                              labelStyle: const TextStyle(color: Colors.lightGreen),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  )
                              )
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Flexible(child: Text('Book',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

                          ],
                        ),
                      ),

                      const SizedBox(height: 10,),

                      //opening time
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          children: [
                            const Flexible(child: Text('Opening Time*:',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen),)),
                            const SizedBox(width: 10,),
                            Flexible(child: Text(widget.Op,maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.grey),)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),

                      //closing time
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          children: [
                            const Flexible(child: Text('Closing Time*:',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen),)),
                            const SizedBox(width: 10,),
                            Flexible(child: Text(widget.Close,maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.grey),)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),

                      //lunch opening
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          children: [
                            const Flexible(child: Text('Lunch Opening Time:',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen),)),
                            const SizedBox(width: 10,),
                            Flexible(child: Text(widget.luncOpen,maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.grey),)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),

                      //lunch closing
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right:8.0,top: 8.0),
                        child: Row(
                          children: [
                            const Flexible(child: Text('Lunch Closing Time*:',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.lightGreen),)),
                            const SizedBox(width: 10,),
                            Flexible(child: Text(widget.luncClose,maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.grey),)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),


                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                        child: InkWell(
                          onTap:()
                          async{

                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if(pickedDate != null ){
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                _date.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }

                          },
                          child: TextFormField(
                            enabled: false,
                            controller: _date,
                            keyboardType:TextInputType.number,

                            validator: (value){
                              if(value!.isEmpty){

                                return 'Enter Date';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                icon: const Icon(CupertinoIcons.calendar_badge_minus),
                                labelText: 'Date*',
                                labelStyle: const TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    )
                                )
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                        child: InkWell(


                          onTap:()
                          async {
                            showTimePicker(
                                context: context, initialTime: TimeOfDay
                                .now())
                                .then((dynamic value) {
                              setState(() {
                                _start.text = value.format(context);
                              });

                              print(value.format(context).toString());
                            });
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: _start,
                            validator: (value){
                              if(value!.isEmpty){

                                return 'Enter Start Time';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                                icon: Icon(CupertinoIcons.timer),
                                labelText: 'Start Time*',
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.lightGreen,
                                    )
                                )
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                        child: InkWell(


                          onTap:()
                          async {
                            showTimePicker(
                                context: context, initialTime: TimeOfDay
                                .now())
                                .then((dynamic value) {
                              setState(() {
                                _end.text = value.format(context);
                              });

                              print(value.format(context).toString());
                            });
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: _end,
                            validator: (value){
                              if(value!.isEmpty){

                                return 'Enter End Time';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                                icon: Icon(CupertinoIcons.timer),
                                labelText: 'End Time*',
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.lightGreen,
                                    )
                                )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
        ),
      );
    }
  _genderDropDown() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 0, right: 15),
      child: DropdownButton<String>(
        focusColor: Colors.white,
        value: _selectedGender,
        //elevation: 5,
        style: const TextStyle(color: Colors.white),
        iconEnabledColor:Colors.lightGreen,
        items: <String>[
          'Gender',
          'Male',
          'Female',
          'Other',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        hint: const Text(
          "Select Gender",style: TextStyle(color: Colors.lightGreen),
        ),
        onChanged: (String? value) {
          setState(() {
            print(value);
            _selectedGender = value!;
          });
        },
      ),
    );
  }

  Widget _stopBookingWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: ListTile(
        title: const Text("Online or C.O.D payment",style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: _Online
            ? const Text("Turn off to use C.O.D")
            : const Text("Turn on to use online payment"),
        trailing: IconButton(
          icon:  _Online
              ? const Icon(
            Icons.toggle_on_outlined,
            color: Colors.green,
            size: 50,
          )
              : const Icon(
            Icons.toggle_off_outlined,
            color: Colors.red,
            size: 50,
          ),
          onPressed: () {
            setState(() {
              _Online= ! _Online;
            });
          },
        ),
      ),
    );
  }

  }
