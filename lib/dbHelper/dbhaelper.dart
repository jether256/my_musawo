// import 'dart:async';
//
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
//
// class DBConn{
//
//   late Database _db;
//
//   Future<Database> get ebdata async {
//
//     if(_db==null){
//
//       _db=await initDB();
//     }
//
//     return _db;
//
//   }
//
//   Future<Database> initDB() async{
//     String dbPath=join(await getDatabasesPath(),"ebdata.db");
//     var eTradeDb=await openDatabase(dbPath,version: 1,onCreate: createDB);
//     return eTradeDb;
//   }
//
//   Future<void> createDB(Database ebdata,int version) async{
//     await ebdata.execute("CREATE TABLE business(ID int,user_id text,logo text,shopImage text,bizname text, phone1 text, email1 text,taxRegistered text,tinNumber text, address text, lon text, lat text,time1 text, status1 text,service text,shopOpen text,rating text,totalRating text,isTopPicked text,create_t text)");
//   }
//
//   Future<int>  insertData( BusinessModel trndata) async{
//     final Database db= await this.ebdata;
//     var result=await db.insert("business", trndata.toMap());
//     return result;
//   }
//
//
//   Future<List> getAllRecords(String dbTable) async{
//     var dbClient=await this.ebdata;
//     var result=await dbClient.rawQuery("SELECT * FROM business");
//     return result.toList();
//   }
//
//   Future<void> updateTrans( BusinessModel busdata) async {
//     Database db =await this.ebdata;
//     var result =await db.update("business",busdata.toMap(),
//     where:"ID=?" ,
//     whereArgs: [busdata.ID]
//   );
// }
//
//
// Future<int> deleteTrans(String ID) async {
//     final db=await this.ebdata;
//     var result= await db.rawDelete("delete * from business where ID=$ID");
//     return result;
//
// }
//
// Future<int> deleteAllTrans() async{
//   final db=await this.ebdata;
//   var result= await db.rawDelete("delete * from business");
//   return result;
//
// }
//
//
//
// }