class BusinessModo {
  final String ID;
  final String userID;
  final String Logo;
  final String ShopIm;
  final String ShopNem;
  final String Phone;
  final String Mail;
  final String Tax;
  final String Tin;
  final String Ad;
  final String Lon;
  final String Lat;
  final String Time1;
  final String State1;
  final String Serve;
  final String open1;
  final String Rating;
  final String totalRating1;
  final String isTopPicked;
  final String creat_t;

  BusinessModo( this.ID, this.userID, this.Logo, this.ShopIm, this.ShopNem, this.Phone, this.Mail, this.Tax, this.Tin, this.Ad, this.Lon, this.Lat, this.Time1, this.State1, this.Serve, this.open1, this.Rating, this.totalRating1, this.isTopPicked, this.creat_t);

  BusinessModo.fromJson(Map<String, dynamic> data)
  :ID = data['ID'],
  userID = data['user_id'],
  Logo=data['logo'],
  ShopIm=data['shopImage'],
  ShopNem=data['bizname'],
  Phone=data['phone1'],
  Mail=data['email1'],
  Tax=data['taxRegistered'],
  Tin=data['tinNumber'],
  Ad=data['address'],
  Lon=data['lon'],
  Lat=data['lat'],
  Time1= data['time1'],
  State1= data['status1'],
  Serve=data['service'],
  open1=data['shopOpen'],
  Rating=data['rating'],
  totalRating1=data['totalRating'],
  isTopPicked= data['isTopPicked'],
  creat_t= data['creat_t'];

  Map<String, dynamic> toJson() =>
      {

  ID :'ID',
  userID : 'user_id',
  Logo:'logo',
  ShopIm:'shopImage',
  ShopNem:'bizname',
  Phone:'phone1',
  Mail:'email1',
  Tax:'taxRegistered',
  Tin:'tinNumber',
  Ad:'address',
  Lon:'lon',
  Lat:'lat',
  Time1:'time1',
  State1:'status1',
  Serve:'service',
  open1:'shopOpen',
  Rating:'rating',
  totalRating1:'totalRating',
  isTopPicked:'isTopPicked',
  creat_t:'creat_t',

      };
}