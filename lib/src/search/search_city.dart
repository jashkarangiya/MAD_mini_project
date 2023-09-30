/*
*  SearchDelegate: SearchCityDelegate
*  Function: Shows the city search
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examen_practico_clima/src/blocs/wheater/wheater_bloc.dart';
import 'package:examen_practico_clima/src/models/location_model.dart';

class SearchCityDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Search cities';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon( Icons.close ),
        onPressed: (){
          query = '';
        }, 
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon( Icons.arrow_back_ios_new_outlined ),
      onPressed: ()async{
        final navigator = Navigator.of(context);
        FocusScope.of(context).unfocus();
        await Future.delayed( const Duration( milliseconds: 150 ) );
        
        navigator.pop();
      }, 
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final wheaterBloc = BlocProvider.of<WheaterBloc>(context, listen: false);
    return _buildResults( wheaterBloc, context );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final wheaterBloc = BlocProvider.of<WheaterBloc>(context, listen: false);
    return _buildResults( wheaterBloc, context );
  }

  Widget _buildResults( WheaterBloc wheaterBloc, context){

    if( query.isEmpty ){
      return const Center(
        child: Text('Enter a city to find out its climate.'),
      );
    }

    return FutureBuilder(
      future: wheaterBloc.searchLocations(query),
      builder: ( _, AsyncSnapshot<List<LocationModel>> snapshot ){
        if( snapshot.connectionState == ConnectionState.waiting ){
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
          
                CircularProgressIndicator(),
                Text('Search cities'),
                Icon( Icons.location_city )
          
              ],
            ),
          );
        }

        if( !snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(
            child: Text('The city was not found'),
          );
        }

        final locations = snapshot.data;

        return ListView.separated(
          itemCount: locations?.length ?? 0,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: ( _, index ){

            final location = locations?[ index ];

            return ListTile(
              title: Text( location?.name ?? 'A stranger' ),
              leading: const Icon( Icons.location_city ),
              trailing: const Icon( Icons.arrow_forward_ios_sharp ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( 'Estado: ${location?.state ?? 'State' }' ),
                  Text( 'Country code: ${location?.country ?? 'A stranger' }'),
                ],
              ),
              onTap: () async {
                FocusScope.of(context).unfocus();
                final navigator = Navigator.of(context);
                if( location?.lat != null && location?.lon != null ){
                  final wheater = await wheaterBloc.getWheaterByLatLon(lat: location!.lat, lon: location.lon);

                  if( wheater != null ){

                    wheaterBloc.add( ChangeCurrentWheaterEvent(wheaterModel: wheater) );
                    wheaterBloc.add( ChangeLocationEvent( currentLocation : LocationModel(name: wheater.name, lat: wheater.coord.lat, lon: wheater.coord.lon)) );

                    navigator.pop();
                  }else{
                    showDialog(context: context, builder: ( context ){
                      return AlertDialog(
                        content: SizedBox(
                          child: Text('Could not get weather of ${ location.name }'),
                        ),
                      );
                    });
                  }
                }

              },
            );

          }
        );

      }
    );
  }

}