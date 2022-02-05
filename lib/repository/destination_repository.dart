import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:projects/models/source_entity.dart';
import 'package:projects/web_services/end_points.dart';
import 'package:projects/web_services/http_client.dart';
import 'package:sqflite/sqflite.dart';

class DestinationRepository {

  Dio? httpClient;
  Database? database;

  DestinationRepository() {
    httpClient = HttpClient().getInstance();
    initDataBase();
  }

  initDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'cities.db';
    database = await openDatabase(
        path, version: 1, onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE City (id INTEGER PRIMARY KEY, name TEXT, lat REAL, lng REAL, country TEXT)');
    });
  }

  Future<List<SourceEntity>> getCities({required String search, required int page}) async {
    try {
      if (!await checkDataBaseTableLength()) {
        await getDestinationCities();
      }
      return await searchOnCities(page: page, search: search);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkDataBaseTableLength() async {
    int? count = Sqflite
        .firstIntValue(await database!.rawQuery('SELECT COUNT(*) FROM City'));
    if(count != null && count > 0){
      return true;
    }
    return false;
  }

  Future getDestinationCities() async {
    try {
      var response = await httpClient!.get(EndPoints.getCities);
      var data = json.decode(response.data);
      saveCitiesToDataBase(data);
    } catch (e) {
      rethrow;
    }
  }

  saveCitiesToDataBase(List data) async {
    for(int i = 0;i< data.length;i++){
      await database!.insert("City", data[i]);
    }
  }

  Future<List<SourceEntity>> searchOnCities({required String search, required int page,}) async {
    var response = await database!.query("City",where:"name LIKE '%$search%'");
    return getPaginatedResults(page, response.map<SourceEntity>((item)=> SourceEntity().fromJson(item)).toList());
  }


  List<SourceEntity> getPaginatedResults(int page,List<SourceEntity> results){
    int startIndex = page * 10;
    int endIndex = startIndex + 10;
    if (startIndex > results.length) return [];
    else if (endIndex > results.length) return results.sublist(startIndex);
    else return results.sublist(startIndex,endIndex);
  }

}