
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import '../../Provider/order.dart';
import '../../models/cards.dart';
import '../../pref/pref.dart';

import 'cards.dart';

class ManageCArds extends StatefulWidget {
  const ManageCArds({Key? key}) : super(key: key);

  @override
  State<ManageCArds> createState() => _ManageCArdsState();
}

class _ManageCArdsState extends State<ManageCArds> {


  @override
  void initState(){
    super.initState();
    getCards();
    getPref();
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

  List<CardsModel> listCards = [];


  getCards() async{

    var response = await http.post(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/user/getCard.php"),
        body:{"uid":'$userID'},
        headers: {"Accept": "headers/json"});

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            listCards.add(CardsModel.fromJson(map));
          }
        }
      }
      return listCards;

    }

  }


  deleteCard(data) async {

    EasyLoading.show(status: 'Please wait.......');

    var response = await http.post(
        Uri.parse("https://mymusawoee.000webhostapp.com/api/user/deleteCard.php"),
        body:{"con":data},
        headers: {"Accept": "headers/json"});

    if (response.statusCode == 200) {

      EasyLoading.showSuccess('Card deleted....');

    }else{

      EasyLoading.showError('Card failed to delete....');

    }


  }

  // Future<StripeTransactionResponse>  payViaExistingCard(BuildContext context, card,amount) async {
  //
  //   await EasyLoading.show(status: 'Please wait.....');
  //
  //   var expiryArr = card['expiryDate'].split('/');
  //   CreditCard stripeCard = CreditCard(
  //     number: card['cardNumber'],
  //     expMonth: int.parse(expiryArr[0]),
  //     expYear: int.parse(expiryArr[1]),
  //   );
  //   var response = await StripeService.payViaExistingCard(
  //       amount: '${amount}00',
  //       currency: 'SHS',
  //       card: stripeCard
  //   );
  //   await EasyLoading.dismiss();
  //   Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(response.message),
  //         duration: const Duration(milliseconds: 1200),
  //       )
  //   ).closed.then((_) {
  //     Navigator.pop(context);
  //   });
  //
  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
    var _orderProvider=Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Add Credit Card', style: TextStyle(
          color: Colors.white,),),
        actions:  [

          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  Cards()
                  )
              );
            },
            child: const Icon(Icons.add_circle, color:Colors.white),
          ),
        ],
      ),
      body:FutureBuilder<dynamic>(
          future:getCards(),
          //initialData: [],
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

            if (snapshot.hasData) {

              if(snapshot.data!.length == 0){


                return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('No Credit Cards Added to your Account',style: TextStyle(color: Colors.grey,fontSize: 14),),

                        const Divider(height: 10,),

                        NeumorphicButton(
                          onPressed: (){


                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>   Cards() ,
                                )
                            );


                          },
                          style: const NeumorphicStyle(color:Colors.lightGreen),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add_circle,size: 16,color: Colors.white,),
                                Text('Add Card',style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                );

              }else {


                return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: const ValueKey(0),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {}),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete', onPressed: (BuildContext context) {
                          deleteCard(snapshot.data['ID']);
                      },
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  // endActionPane: const ActionPane(
                  //   motion: ScrollMotion(),
                  //   children: [
                  //
                  //   ],
                  // ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.
                  child: Container(
                      padding: const EdgeInsets.only(left: 8,right:8 ,top: 10,bottom: 10),
                      child: ListView.builder(
                        itemCount: listCards.length,
                        itemBuilder: (BuildContext context, int index) {
                          var card = listCards[index];
                          return InkWell(
                            onTap: () {
                              // payViaExistingCard(context, card,_orderProvider.amount).then((value){
                              //
                              //   _orderProvider.paymentStatus(value.success);
                              //
                              // });
                            },
                            child: CreditCardWidget(
                              cardNumber: card.cno,
                              expiryDate: card.expiry,
                              cardHolderName: card.name,
                              cvvCode: card.cvcode,
                              showBackView: false, onCreditCardWidgetChange: (CreditCardBrand ) {  },
                            ),
                          );
                        },
                      ),
                    ),
                );
                // return Container(
                //   padding: const EdgeInsets.only(left: 8,right:8 ,top: 10,bottom: 10),
                //   child: ListView.builder(
                //     itemCount: listCards.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       var card = listCards[index];
                //       return InkWell(
                //         onTap: () {
                //           payViaExistingCard(context, card,_orderProvider.amount).then((value){
                //
                //             _orderProvider.paymentStatus(value.success);
                //
                //           });
                //         },
                //         child: CreditCardWidget(
                //           cardNumber: card.cno,
                //           expiryDate: card.expiry,
                //           cardHolderName: card.name,
                //           cvvCode: card.cvcode,
                //           showBackView: false, onCreditCardWidgetChange: (CreditCardBrand ) {  },
                //         ),
                //       );
                //     },
                //   ),
                // );

              }

            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }

      ),
    );
  }
}
