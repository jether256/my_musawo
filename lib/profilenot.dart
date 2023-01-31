import 'package:flutter/material.dart';

import 'login/login.dart';

class ProfileNot extends StatefulWidget {
  static const  String id='profilenot';

  @override
  State<ProfileNot> createState() => _ProfileNotState();
}

class _ProfileNotState extends State<ProfileNot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
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
                            child: const Icon(Icons.login,color: Colors.white,)
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

        ),
      ),
      body:Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              alignment: Alignment.center,
              matchTextDirection: true,
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/doc.png')
          ),
          color: Colors.white10,
          border: Border.all(
              color: Theme.of(context).primaryColor
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              const Text('Login to See  Profile',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightGreen),),
              const SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: ()
                  {

                    // Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginForm(),),);

                    Navigator.pushReplacementNamed(context,LoginForm.id);


                  },
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor)),
                  child:const Text('Login First',style: TextStyle(color: Colors.white),)
              ),

            ],
          ),
        ),
      ),
    );
  }
}
