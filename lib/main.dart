import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_musawo/appnot.dart';
import 'package:my_musawo/categories/cart.dart';



import 'package:my_musawo/dashboard.dart';
import 'package:my_musawo/hist.dart';
import 'package:my_musawo/logged/account/applo.dart';
import 'package:my_musawo/logged/account/cards.dart';
import 'package:my_musawo/logged/categor/cartlogged.dart';
import 'package:my_musawo/logged/dashlogged.dart';
import 'package:my_musawo/logged/account/histolo.dart';
import 'package:my_musawo/logged/homescreenlo.dart';

import 'package:my_musawo/logged/prolo.dart';
import 'package:my_musawo/logged/prologged/productlogged.dart';
import 'package:my_musawo/product/product.dart';
import 'package:my_musawo/logged/prologged/productdeatils.dart';
import 'package:my_musawo/profilenot.dart';
import 'package:my_musawo/splash.dart';
import 'package:provider/provider.dart';
import 'Provider/auth.dart';
import 'Provider/cartprovider.dart';
import 'Provider/docprovider.dart';
import 'Provider/locationPro.dart';
import 'Provider/paymentmethod.dart';
import 'Provider/productprovider.dart';
import 'Provider/shopprov.dart';
import 'Provider/sliderpro.dart';
import 'below.dart';
import 'home.dart';
import 'location.dart';

import 'login/login.dart';
import 'login/reg.dart';
import 'map/map.dart';


void main() async{

  Provider.debugCheckInvalidValueType=null;

  runApp(

    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create:(_) => AuthProvider(),
        ),


        ChangeNotifierProvider(
          create:(_) => LocationProvider(),
        ),
        //
        ChangeNotifierProvider(
          create:(_) => CategoryProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ProductProvider(),
        ),


        ChangeNotifierProvider(
          create:(_) => SliderProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ShopProvider(),
        ),
        //

        ChangeNotifierProvider(
          create:(_) => DoctorDetailProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => PaymentProvider(),
        ),
        //
        // ChangeNotifierProvider(
        //   create:(_) => ProductIDProvider(),
        // ),


      ],
      child: const MyApp(),
    ),

  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musawo Wange',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          fontFamily: 'Gothic'
      ),
      builder:EasyLoading.init(),
      initialRoute: Splash.id,// first route
      routes: {
        //we will add the screens here for easy navigation
        Splash.id:(context)=>Splash(),
        LoginForm.id:(context)=>LoginForm(),
        DashBoard.id:(context)=>DashBoard(),
        DashboardLogged.id:(context)=>DashboardLogged(),
        HomeScreenLogged.id:(context)=>HomeScreenLogged(),
        AppointmentLogged.id:(context)=>AppointmentLogged(),
        HistoryLogged.id:(context)=>HistoryLogged(),
        ProfileLogged.id:(context)=>ProfileLogged(),
        AppointmentNot.id:(context)=>AppointmentNot(),
        HistoryNot.id:(context)=>HistoryNot(),
        ProfileNot.id:(context)=>ProfileNot(),
        Below.id:(context)=>Below(),
        HomeScreen.id:(context)=>HomeScreen(),
        Categories.id:(context)=>Categories(),
        Product.id:(context)=>Product(),
        productLogged.id:(context)=>productLogged(),
        CategoryLogged.id:(context)=>CategoryLogged(),
        Reg.id:(context)=>Reg(),
        locationL.id:(context)=>locationL(),
        Mapma.id:(context)=>Mapma(),
        // StripeHome.id:(context)=>StripeHome(),
        // ExistingCardsPage.id:(context)=>ExistingCardsPage(),
        Cards.id:(context)=>Cards(),



      },
    );
  }
}

