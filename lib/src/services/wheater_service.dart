/*
*  Service: WheaterService
*  Function: It is in charge of consulting the information of the weather api
*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location_model.dart';
import '../models/wheater_model.dart';

class WheaterService{

  static const String _appid = '45f9e67e34b3189e0855580a0078d07f';
  final _baseUrl = 'http://api.openweathermap.org';

  Future<List<LocationModel>> searchLocations( String name ) async {
    try {
      final locations = await http.get(
        Uri.parse('$_baseUrl/geo/1.0/direct?limit=5&appid=$_appid&q=$name')
      );

      if( locations.statusCode == 200 ){
        final List decoded = json.decode( locations.body );
        return decoded.map(( location ) => LocationModel.fromJson( location )  ).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<WheaterModel?> getWheaterByLatLon({ required double lat, required double lon, required bool metric  }) async {
    try {
      final locations = await http.get(
        Uri.parse('$_baseUrl/data/2.5/weather?appid=$_appid&lat=$lat&lon=$lon&lang=es&units=${ metric ? 'metric' : 'standard' }')
      );
      
      if( locations.statusCode == 200 ){
        return WheaterModel.fromRawJson( locations.body );
      }

      return null;
    } catch (e){
      return null;
    }
  }

}