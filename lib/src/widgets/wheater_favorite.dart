/*
*  Widget: WheaterFavorite
*  Function: Favorite cities reusable card
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examen_practico_clima/src/blocs/wheater/wheater_bloc.dart';
import 'package:examen_practico_clima/src/models/location_model.dart';

class WheaterFavorite extends StatelessWidget {

  final LocationModel locationModel;

  const WheaterFavorite({ Key? key, required this.locationModel }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final wheaterBloc = BlocProvider.of<WheaterBloc>(context);

    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 15, vertical: 5 ),
      padding: const EdgeInsets.all( 15 ),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all( color: Colors.white, width: 2 ),
        borderRadius: BorderRadius.circular( 15 ),
      ),
      child: Column(
        children: [
          Row(
            children: [

              const Icon( Icons.location_on_rounded, size: 40, color: Colors.white, ),

              const SizedBox(
                width: 10,
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text( 
                      locationModel.name ,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
              
                    ),
                    
                    BlocBuilder<WheaterBloc, WheaterState>(
                      builder: (context, state) {
                        return IconButton(
                          icon: const Icon( Icons.favorite, color: Colors.red ),
                          onPressed: (){
                            wheaterBloc.add( DeleteLocationEvent( locationModel ));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: FutureBuilder(
              future: wheaterBloc.getWheaterByLatLon( lat: locationModel.lat, lon: locationModel.lon ),
              builder: (_, snapshot){
          
                if( snapshot.data == null || !snapshot.hasData ){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,  
                    children: const [ 
                      CircularProgressIndicator()
                    ]
                  );
                }
          
                final wheater = snapshot.data;
          
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
          
                    Column(
                      children: [
                        SizedBox(
                          width: 100,
                          child: FadeInImage(
                          placeholder: const AssetImage('assets/loading-4.gif'),
                          image: NetworkImage('https://openweathermap.org/img/wn/${ wheater?.weather[0].icon ?? '01d' }@4x.png'),
                          fit: BoxFit.fill,
                        ),
                        ),
                        Text('${wheater?.weather[0].description.toUpperCase()}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          )
                        ),
                      ],
                    ),
          
                    BlocBuilder<WheaterBloc, WheaterState>(
                      builder: (context, state) {
                        return Text(
                          '${ wheater?.main.temp ?? '-' } ${ state.unitsMetrics ? '°C' : '°F'}',
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          ),
                        );
                      },
                    ),
                  ],
                );
          
              }
            ),
          )
        ],
      ),
    );
    
  }
}