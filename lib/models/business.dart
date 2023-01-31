

class BusinessModel {
   String ID;
   String userID;
   String Logo;
   String ShopIm;
   String ShopNem;
   String Phone;
   String Mail;
   String Tax;
   String Tin;
   String Ad;
   String Lon;
  String Lat;
   String Time1;
   String State1;
   String Serve;
   String open1;
   String Rating;
   String totalRating1;
   String isTopPicked;
   String creat_t;

  BusinessModel({
      required this.ID,  required this.userID,  required this.Logo, required this.ShopIm,  required this.ShopNem,  required this.Phone,  required this.Mail,  required this.Tax,  required this.Tin,  required this.Ad,  required this.Lon,  required this.Lat, required this.Time1,  required this.State1,  required this.Serve,  required this.open1,  required this.Rating,  required this.totalRating1,  required this.isTopPicked,  required this.creat_t,
  });


 factory BusinessModel.fromJson(data){
    return   BusinessModel(
    ID:data['ID'],
     userID:data['user_id'],
     Logo:data['logo'],
     ShopIm:data['shopImage'],
     ShopNem:data['bizname'],
    Phone:data['phone1'],
    Mail:data['email1'],
    Tax:data['taxRegistered'],
    Tin:data['tinNumber'],
    Ad:data['address'],
    Lon:data['lon'],
    Lat:data['lat'],
    Time1:data['time1'],
    State1: data['status1'],
    Serve:data['service'],
    open1:data['shopOpen'],
    Rating:data['rating'],
    totalRating1:data['totalRating'],
    isTopPicked:data['isTopPicked'],
    creat_t:data['creat_t'],
    );
  }


   // Map toMap() {
   //   return {
   //     "ID": ID,
   //     "user_id": userID,
   //     "logo": Logo,
   //     "shopImage":ShopIm,
   //     "bizname":ShopNem ,
   //     "phone1":Phone ,
   //     "email1":Mail ,
   //     "taxRegistered":Tax ,
   //     "tinNumber": Tin,
   //     "address":Ad ,
   //     "lon":Lon ,
   //     "lat":Lat ,
   //     "time1":Time1 ,
   //     "status1":State1 ,
   //     "service":Serve ,
   //     "shopOpen":open1 ,
   //     "rating": Rating,
   //     "totalRating":totalRating1 ,
   //     "isTopPicked":isTopPicked ,
   //     "create_t":creat_t ,
   //   };
   // }

}
