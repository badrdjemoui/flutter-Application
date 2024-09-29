//import 'dart:ui';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {

    if (_db==null) {
                    _db =await initialDb();
                    return _db;
                   }else
                     {
                        return _db;
                     }
  }
  initialDb() async {
String dbpath = await getDatabasesPath();
String path =join(dbpath,'checken.db');
Database mydb =await openDatabase(path,onCreate:_onCreate,version: 2,onUpgrade: _onUpgrade);
return mydb;
}

  _onUpgrade(Database db , int oldversion , int newversion ) {


    print("onUpgrade =====================================") ;

  }

_onCreate(Database db ,int v) async{
  print('create db and table');
    await db.execute('''
     CREATE TABLE "sales" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "nom" TEXT NOT NULL ,
        "date" TEXT NOT NULL ,
        "nbr"  INTEGER  ,
        "poid" real NOT NULL ,
        "onekg" real NOT NULL ,
        "some" real,
        "vers" real
                        )
                      ''');
  await db.execute('''
     CREATE TABLE "purchases" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "nom" TEXT NOT NULL ,
        "date" TEXT NOT NULL ,
        "nbr"  INTEGER  ,
        "onekg" real NOT NULL ,
        "poid" real NOT NULL ,
        "some" real,
        "vers" real
                        )
                      ''');
  await db.execute('''
     CREATE TABLE "checkenaltar" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "breeder" TEXT NOT NULL ,
        "nomaltar" TEXT NOT NULL ,
        "date" TEXT NOT NULL ,
        "nbr"  INTEGER  ,
        "unityprice" real NOT NULL ,
        "some" real,
        "vers" real
                        )
                      ''');



}
readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
}
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
 deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
  mydeletedatabase() async{
    String databasepath = await getDatabasesPath();
    String path =join(databasepath,'checken.db');
    await deleteDatabase(path);
  }

}