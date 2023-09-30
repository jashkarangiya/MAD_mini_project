/*
*  Singleton: DBProvider
*  Function: Create and provide functions to handle local city data
*/

import 'dart:io';
import 'package:examen_practico_clima/src/models/location_model.dart';
import '../db/db_tables.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async{

    //Path de donde se almacenara la base de datos
    Directory directory = await getApplicationDocumentsDirectory();
    final path =  '${directory.path}/Clima.db';

    //Crear la base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db)async{
        await db.execute( DBTables.favorites );
      },
      onCreate: ( Database db, int version )async{
        await db.execute( DBTables.favorites );
      }
    );
  }


  Future<int> saveCity( LocationModel locationModel )async {

    final db = await database;
    return await db.insert('Cities', locationModel.toJson() );
  }

  Future<int> deleteCity( String name)async {
    final db = await database;
    return await db.delete('Cities', where: 'name=?', whereArgs: [ name ]);
  }

  Future<List<LocationModel>> getAllCities() async {
    final db = await database;
    final cities = await db.query('Cities');
    return cities.map((e) => LocationModel.fromJson( e ) ).toList();
  }

  Future<LocationModel?> getCitybyName(  String name) async{

    try {
      final db = await database;
      final city = await db.query('Cities', where: 'name=?', whereArgs: [ name ]);
      return LocationModel.fromJson( city[0] );
    } catch (e) {
      return null;
    }

  }
  
}