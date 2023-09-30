/*
*  BLOC: WheaterBloc
*  Function: State for WheaterBloc
*/

part of 'wheater_bloc.dart';

class WheaterState extends Equatable {

  const WheaterState({
    required this.isLoading,
    required this.locations, 
    required this.currentLocation,
    required this.unitsMetrics,
    this.wheaterModel
  });
  
  final bool isLoading;
  final WheaterModel? wheaterModel;
  final List<LocationModel> locations;
  final LocationModel currentLocation;
  final bool unitsMetrics;

  WheaterState copyWith({ 
    bool? isLoading,
    WheaterModel? wheaterModel,
    List<LocationModel>? locations,
    LocationModel? currentLocation,
    bool? unitsMetrics
  }) => WheaterState(
    isLoading: isLoading ?? this.isLoading,
    wheaterModel: wheaterModel ?? this.wheaterModel,
    locations: locations ?? this.locations,
    currentLocation: currentLocation ?? this.currentLocation,
    unitsMetrics: unitsMetrics ?? this.unitsMetrics
  );

  @override
  List<Object> get props => [  
    isLoading,
    locations,
    currentLocation,
    unitsMetrics,
    wheaterModel ?? 0,
  ];
}

