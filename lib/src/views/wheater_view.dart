/*
*  View: WheaterView
*  Function: Show weather information
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/wheater/wheater_bloc.dart';
import '../search/search_city.dart';

class WheaterView extends StatelessWidget {
  const WheaterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final wheaterBloc = BlocProvider.of<WheaterBloc>(context);

    return BlocBuilder<WheaterBloc, WheaterState>(
      builder: (context, state) {

        final wheater = state.wheaterModel!;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox( width: 15 ),
                      const Icon( Icons.location_on_rounded, size: 30,color: Colors.white ),
                      const SizedBox( width: 10 ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wheater.name,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                            Text(
                              wheater.sys.country,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            
                Row(
                  children: [

                    IconButton(
                      icon: const Icon( Icons.settings, color: Colors.white ),
                      onPressed: (){
                        showDialog(context: context, builder: (_) => AlertDialog(
                          content: SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                const Text('UNIT OF MEASUREMENT'),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('*F'),
                                    Expanded(
                                      child: BlocBuilder<WheaterBloc, WheaterState>(
                                        builder: ( context, state) => SwitchListTile(
                                          value: state.unitsMetrics, 
                                          onChanged: ( value ){
                                            wheaterBloc.add( ChangeUnitsEvent( value ));
                                          }
                                        )
                                      ),
                                    ),
                                    const Text('*C'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
                      }, 
                    ),

                    BlocBuilder<WheaterBloc, WheaterState>(
                      builder: (context, state) {

                        final contain = state.locations.indexWhere( ( e ) => e.name == state.currentLocation.name ); 

                        return IconButton(
                          icon: contain != -1  
                          ? const Icon( Icons.favorite, color: Colors.red, ) 
                          : const Icon( Icons.favorite_border, color: Colors.white,),
                          onPressed: (){
                            if( contain != -1 ){
                              wheaterBloc.add( DeleteLocationEvent( state.currentLocation ));
                            }else{
                              wheaterBloc.add( SaveLocationEvent( state.currentLocation ));
                            }
                          }
                        );
                      },
                    ),

                    IconButton(
                      icon: const Icon( Icons.search, color: Colors.white ),
                      onPressed: (){
                        showSearch(
                          context: context, 
                          delegate: SearchCityDelegate() 
                        );
                      }, 
                    ),
                  ],
                )
              ],
            ),
                
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              
                  SizedBox(
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading-4.gif'),
                      image: NetworkImage('https://openweathermap.org/img/wn/${ wheater.weather[0].icon }@4x.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
              
                  Text("Temperature",
                    style: const TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    )
                  ),
              
              
                  const SizedBox(
                    height: 10,
                  ),
              
                  Text(
                    '${ wheater.main.temp } ${ state.unitsMetrics ? '°C' : '°F'}',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w700
                    ),
                  ),
              
                  const SizedBox(
                    height: 10,
                  ),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              
                      Row(
                        children: [
                          const Icon( Icons.air ),
                          Text('${ wheater.wind.speed } m/s',
                            style: const TextStyle(
                              fontSize: 15
                            )
                          )
                        ],
                      ),
              
                      const SizedBox(
                        width: 20,
                      ),
              
                      Row(
                        children: [
                          const Icon( Icons.water_drop ),
                          Text('${ wheater.main.humidity }%',
                            style: const TextStyle(
                              fontSize: 15
                            )
                          )
                        ],
                      ),
              
                    ],
                  ),
                ],
              )
            ),
            
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _ItemWheater(
                      label: 'Sensation',
                      value: '${ wheater.main.feelsLike }${ state.unitsMetrics ? '°C' : '°F'}',
                      iconData: Icons.surfing_outlined,
                    ),
                    _ItemWheater(
                      label: 'Percipitation',
                      value: '${ wheater.clouds.all }%',
                      iconData: Icons.cloud,
                    ),
                  ],
                ),
              )
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                 _ItemWheater(
                      label: 'Temp. Min',
                      value: '${ wheater.main.tempMin }${ state.unitsMetrics ? '°C' : '°F'}',
                      iconData: Icons.thermostat,
                    ),
                    _ItemWheater(
                      label: 'Temp. Max',
                      value: '${ wheater.main.tempMax} ${ state.unitsMetrics ? '°C' : '°F'}',
                      iconData: Icons.thermostat,
                    ),
                  ],
                ),
              )
            ),
          ],
        );
      },
    );
  }
}

class _ItemWheater extends StatelessWidget {

  final String label;
  final String value;
  final IconData? iconData;

  const _ItemWheater({
    required this.label,
    required this.value,
    required this.iconData
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 140,
      margin: const EdgeInsets.all( 4 ),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular( 15 )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
            
          Text(
            label,
            style: const TextStyle(
              fontSize: 18
            ),
            textAlign: TextAlign.center,
          ),
            
          Icon( iconData ?? Icons.person, size: 30, color: Colors.white,),
            
          Text( value ,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
            
        ],
      ),
    );
  }
}