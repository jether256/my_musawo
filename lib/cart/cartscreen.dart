import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {

  int disc=0;
  int delivery=40;
  @override
  Widget build(BuildContext context) {

   // var _payable= _cartprovider.subtotal + delivery-disc;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
     appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.lightGreen
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title:const Text( 'My Cart',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
      ),
      bottomSheet: Container(

        height: 144,
        color: Colors.blueGrey[900],
        child: Column(
          children: [

            const Divider(color: Colors.grey,),
            Container(
              width: MediaQuery.of(context).size.width,

              height: 80,
              color: Colors.white,
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Row(
                      children: const [
                        Expanded(child: Text('Deliver to this Address',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)),
                        Text('Change',style:TextStyle(color: Colors.redAccent,fontSize: 12),),
                      ],
                    ),
                    const Text('maska kirumira nkuyajo banange temuja kutuwon anze ababulila mbwa mwe',
                    style: TextStyle(color: Colors.grey,fontSize: 12),)
                  ],

                ),
              ) ,
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right:20 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [

                      //  Text('\$${sub.toStringAsFixed(0)}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        Text('Including Taxes',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        Text('Including Taxes',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                      ],
                    ),
                    ElevatedButton(
                      onPressed:()
                      {


                      },
                      child:const Text('CHECK OUT',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body:ListView(
    shrinkWrap: true,
    padding:const EdgeInsets.only(left: 2,right: 2),
    children: [

      Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.green))
        ),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Stack(
            children: [

              Row(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/doc.png',fit: BoxFit.contain,),
                    ),
                  ),

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('kamasu'),
                        const Text('wei',style: TextStyle(color: Colors.grey),),

                        const SizedBox(height: 30,),

                        // if('comp'>0)
                        // Text('comp'.toString(),style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12),),
                         Text('comp'.toString(),style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12),),

                         //Text('price'.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.bold),),
                         Text('price',style: TextStyle(fontWeight: FontWeight.bold),),

                      ],
                    ),
                  )
                ],
              ),
              
              Positioned(
                right: 0.0,bottom: 0.0,
                  child:Container(
                    margin: const EdgeInsets.only(left: 20,right: 20),
                    height: 56,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Row(
                            children: [

                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: const BorderRadius.only(topLeft:Radius.circular(10),bottomLeft:Radius.circular(10)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.remove,color: Colors.red,),
                                ),

                              ),


                              Container(
                                decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                  ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left:20,right: 20,top: 12,bottom: 12),
                                  child:Text('1',style: TextStyle(color: Colors.red),),
                                ),

                              ),


                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: const BorderRadius.only(topRight:Radius.circular(10),bottomRight:Radius.circular(10)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.add,color: Colors.green,),
                                ),

                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ),

             // if(saving >0)
              const Positioned(
                  child:CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('sh 8',style:TextStyle(color: Colors.white),),
                      ),

                    ),
                  ),
              ),


            ],
          ),
        ),

      ),

      const Divider(color: Colors.grey,thickness: 3,),

      Padding(
        padding: const EdgeInsets.only(right: 4.0,left: 4,top: 4,bottom: 80),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              children: [
                const Text('Bill Details',style:TextStyle(fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                Row(
                  children: [

                    Expanded(child: Text('Basket Value',style: TextStyle(color: Colors.grey),)),
                   // Text('${_cartpr.subtotal.toStringAsFixed(0)}'),
                    Text('898--98',style: TextStyle(color: Colors.grey),),
                  ],
                ),

                const SizedBox(height: 10,),


                Row(
                  children: [

                    Expanded(child: Text('Delivery Fee',style: TextStyle(color: Colors.grey),)),
                    // Text('${_cartpr.subtotal.toStringAsFixed(0)}'),
                    Text('w3433',style: TextStyle(color: Colors.grey),),

                  ],
                ),
                const SizedBox(height: 10,),


                Row(
                  children: const [

                    Expanded(child: Text('Basket Value',style: TextStyle(color: Colors.grey),)),
                    // Text('${_cartpr.subtotal.toStringAsFixed(0)}'),
                    Text('898--98',style: TextStyle(color: Colors.grey),),
                  ],
                ),
                const Divider(color: Colors.grey,),

                Row(
                  children:  [

                    Expanded(child: Text('Total Amount Payable',style: TextStyle(fontWeight: FontWeight.bold),)),
                    // Text('${_cartpr.subtotal.toStringAsFixed(0)}'),
                  //  Text(_payable, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('898--98', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),

                const SizedBox(height: 10,),


                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.lightGreen,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [

                        Expanded(child: Text('Total Saving',style: TextStyle(color: Colors.grey),)),
                        // Text('${_cartpr.subtotal.toStringAsFixed(0)}'),
                        Text('w3433',style: TextStyle(color: Colors.green),),

                      ],
                    ),
                  ),
                ),
              ],

            ),
          ),
        ),
      ),

    ]
      ),
    );
  }
}
