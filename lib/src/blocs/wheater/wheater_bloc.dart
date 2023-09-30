/*
*  BLOC: WheaterBloc
*  Function: Maintains the reference of the entire weather app
*/

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:examen_practico_clima/src/db/db_provider.dart';
import 'package:examen_practico_clima/src/models/wheater_model.dart';
import 'package:examen_practico_clima/src/services/wheater_service.dart';
import 'package:examen_practico_clima/src/shar_prefs/shar_prefs.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/location_model.dart';

part 'wheater_event.dart';
part 'wheater_state.dart';

class WheaterBloc extends Bloc<WheaterEvent, WheaterState> {

  final _db = DBProvider.db;
  final _prefs = SharPrefs();
  final WheaterService wheaterService;

  WheaterBloc({
    required this.wheaterService
  }) : super( WheaterState( 
    unitsMetrics: true,
    isLoading: false, 
    locations: const [], 
    currentLocation: LocationModel(name: 'Location', lat: 0, lon: 0)
  )){

    on<ChangeCurrentWheaterEvent>((event, emit) { 
      emit( state.copyWith( wheaterModel: event.wheaterModel ));
    });

    on<ChangeLocationEvent>((event, emit) {
      emit( state.copyWith( currentLocation: event.currentLocation ) );
    });

    on<ChangeLocationsEvent>((event, emit) {
      emit( state.copyWith( locations: event.locations ) );
    });

    on<SaveLocationEvent>( _saveLocationEvent );

    on<DeleteLocationEvent>( _deleteLocationEvent );

    on<ChangeIsLoadingEvent>((event, emit) => emit( state.copyWith( isLoading: event.isLoading ) ));

    on<ChangeUnitsEvent>((event, emit) async {
      emit( state.copyWith( unitsMetrics: event.unitsMetrics ));
      final res = await getWheaterByLatLon( lat: state.currentLocation.lat, lon: state.currentLocation.lon );
      if( res != null ){
        add( ChangeCurrentWheaterEvent(wheaterModel: res ));
        add( ChangeLocationEvent(currentLocation: LocationModel( name: res.name, lat: res.coord.lat, lon: res.coord.lon)));
      }
    });

    _init();
  }

  _init() async {
    
    final metric = _prefs.metric;
    add( ChangeUnitsEvent( metric ));

    add( const ChangeIsLoadingEvent( isLoading: true ));
    final position = await Geolocator.getCurrentPosition();
    final res = await getWheaterByLatLon( lat: position.latitude, lon: position.longitude );
    final cities = await _db.getAllCities();
    add( const ChangeIsLoadingEvent( isLoading: false ));
    
    if( res != null ){
      add( ChangeCurrentWheaterEvent(wheaterModel: res ));
      //add( ChangeLocationEvent(currentLocation: LocationModel( name: res.name, lat: res.coord.lat, lon: res.coord.lon)));
    }

    if( cities.isNotEmpty ){
      add( ChangeLocationsEvent(locations: cities));
    }
  }

  Future<WheaterModel?> getWheaterByLatLon( { required double lat, required double lon } ) async {
    final wheater = await wheaterService.getWheaterByLatLon(lat: lat , lon: lon, metric: state.unitsMetrics);
    if( wheater != null ){
      return wheater;
    }
    return null;
  }

  Future<List<LocationModel>> searchLocations( String query ) async {
    return await wheaterService.searchLocations( query );
  }

  Future<bool> searchLocationByName( String query ) async {
    final db = await DBProvider.db.getCitybyName( query );
    if( db == null || db.name.isEmpty ){
      return false;
    }
    return true;
  }

  _saveLocationEvent( 
    SaveLocationEvent event,
    Emitter<WheaterState> emit
  ) async {

    final location = event.locationModel;
    await _db.saveCity( location );
    emit( state.copyWith( locations: [ ...state.locations, location ] ));
  }

  _deleteLocationEvent( 
    DeleteLocationEvent event,
    Emitter<WheaterState> emit
  ) async {
    final location = event.locationModel;
    await _db.deleteCity( location.name );
    final locations = await _db.getAllCities();
    emit( state.copyWith( locations: [ ...locations ] ));
  }

}
