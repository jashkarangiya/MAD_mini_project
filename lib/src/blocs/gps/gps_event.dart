/*
*  BLOC: GPSBloc
*  Function: Events for gpsbloc
*/

part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class ChangeGpsEvent extends GpsEvent{
  
  final bool isGpsEnabled;
  final bool isGpsGrantedPermission;

  const ChangeGpsEvent({
    required this.isGpsEnabled, 
    required this.isGpsGrantedPermission
  });
}
