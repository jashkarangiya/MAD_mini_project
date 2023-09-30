/*
*  View: HomeView
*  Function: Shows the weather information of the location selected or loading screen
*/

import 'package:examen_practico_clima/src/views/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/wheater/wheater_bloc.dart';
import 'wheater_loading_view.dart';
import 'wheater_view.dart';

class HomeView extends StatelessWidget {

  const HomeView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: BlocBuilder<WheaterBloc, WheaterState>(
          builder: (context, state) {

            if( state.isLoading ){
              return const WheaterLoadingView();
            }else if( !state.isLoading && state.wheaterModel == null){
              return const ErrorView();
            }

            return const WheaterView();
          },
        ),
      ),

    );
  }
}