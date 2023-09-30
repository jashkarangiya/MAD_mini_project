/*
*  View: FavoriteView
*  Function: List favorite cities
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examen_practico_clima/src/widgets/wheater_favorite.dart';
import '../blocs/wheater/wheater_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BlocBuilder<WheaterBloc, WheaterState>(
            builder: (context, state) {
        
              final locations = state.locations;
        
              if( locations.isEmpty ){
                return  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'You haven\'t saved any places',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                
                    ),
                
                    Icon( 
                      Icons.favorite_border,
                      color: Colors.pink,
                      size: 30,
                    )
                  ],
                );
              }
        
              return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (_, index) {
                  return WheaterFavorite(locationModel: locations[index]);
                },
              );
            },
          ),
        ));
  }
}
