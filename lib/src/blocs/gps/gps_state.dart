/*
*  BLOC: GPSBloc
*  Function: State for gpsbloc
*/

part of 'gps_bloc.dart';

class GpsState extends Equatable {

  final bool isGpsEnabled;
  final bool isGpsGrantedPermission;

  bool get isReady => isGpsEnabled && isGpsGrantedPermission;

  const GpsState({
    required this.isGpsEnabled,
    required this.isGpsGrantedPermission
  });

  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsGrantedPermission
  }) => GpsState(
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled, 
    isGpsGrantedPermission: isGpsGrantedPermission ?? this.isGpsGrantedPermission
  );
  
  @override
  List<Object> get props => [
    isGpsEnabled,
    isGpsGrantedPermission
  ];
}
