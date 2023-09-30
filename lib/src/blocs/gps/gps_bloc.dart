/*
*  BLOC: GPSBloc
*  Function: It is pending to the changes of the gps
*/

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsStreamSuscription;

  GpsBloc() : super( const GpsState(isGpsEnabled: false, isGpsGrantedPermission: false ) ) {

    on<ChangeGpsEvent>((event, emit) => emit( state.copyWith(
      isGpsEnabled: event.isGpsEnabled,
      isGpsGrantedPermission: event.isGpsGrantedPermission
    )));

    _init();
  }

  _init() async {
    final gpsStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    add( ChangeGpsEvent(isGpsEnabled: gpsStatus[0], isGpsGrantedPermission: gpsStatus[1]));

    getGpsAccess();
  }

  Future<void> getGpsAccess() async {

    final status = await Geolocator.requestPermission();

    switch(status){
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        add( ChangeGpsEvent(isGpsEnabled: state.isGpsEnabled, isGpsGrantedPermission: true ));  
        break;
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
      case LocationPermission.unableToDetermine:
        add( ChangeGpsEvent(isGpsEnabled: state.isGpsEnabled, isGpsGrantedPermission: false ));  
        openAppSettings();
        break;
    }
  }

  Future<bool>_checkGpsStatus()async{

    final isEnabled = await Geolocator.isLocationServiceEnabled();

    gpsStreamSuscription = Geolocator.getServiceStatusStream().listen((event) { 
      add( 
        ChangeGpsEvent(
          isGpsEnabled: event.index == 1 ? true : false, 
          isGpsGrantedPermission: state.isGpsGrantedPermission
        ) 
      );
    });

    return isEnabled;
  }

  Future<bool> _isPermissionGranted()async{
    return await Permission.location.status.isGranted;
  }

  @override
  Future<void> close() {
    gpsStreamSuscription?.cancel();
    return super.close();
  }

}
