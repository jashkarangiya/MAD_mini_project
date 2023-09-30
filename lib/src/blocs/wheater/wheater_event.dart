/*
*  BLOC: WheaterBloc
*  Function: Events for WheaterBloc
*/

part of 'wheater_bloc.dart';

abstract class WheaterEvent extends Equatable {
  const WheaterEvent();

  @override
  List<Object> get props => [];
}

class ChangeCurrentWheaterEvent extends WheaterEvent{
  final WheaterModel wheaterModel;
  const ChangeCurrentWheaterEvent({ required this.wheaterModel});
}

class ChangeIsLoadingEvent extends WheaterEvent{
  final bool isLoading;
  const ChangeIsLoadingEvent({ required this.isLoading});
}

class ChangeLocationEvent extends WheaterEvent{
  final LocationModel currentLocation;
  const ChangeLocationEvent({ required this.currentLocation});
}

class ChangeLocationsEvent extends WheaterEvent{
  final List<LocationModel> locations;
  const ChangeLocationsEvent({ required this.locations});
}

class SaveLocationEvent extends WheaterEvent{
  final LocationModel locationModel;
  const SaveLocationEvent(this.locationModel);
}

class DeleteLocationEvent extends WheaterEvent{
  final LocationModel locationModel;
  const DeleteLocationEvent(this.locationModel);
}

class ChangeUnitsEvent extends WheaterEvent{
  final bool unitsMetrics;
  const ChangeUnitsEvent(this.unitsMetrics);
}