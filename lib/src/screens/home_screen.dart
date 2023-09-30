/*
*  Screen: Home Screen
*  Function: Show current view ( HomeView or FavoritesView )
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:examen_practico_clima/src/blocs/view/view_cubit.dart';
import 'package:examen_practico_clima/src/views/favorite_view.dart';
import '../views/home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final time = DateTime.now().hour;

    return Scaffold(

      body: Container(
        padding: const EdgeInsets.all( 10 ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              
              time >= 0 && time <= 6
              ? Colors.black
              : time >= 7 && time <= 12
              ?Colors.amber.shade600
              : time >= 13 && time <= 19
              ? Colors.blue
              : Colors.black,
              Colors.blue
              
            ]
          )
        ),
        child: BlocBuilder<ViewCubit, int>(
          builder: (context, state) {
            
            switch( state ){
              case 0: return const HomeView();
              case 1: return const FavoriteView();
              default: return const HomeView();
            }
      
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<ViewCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            currentIndex: state,
            items: const [
              BottomNavigationBarItem(label: 'Clima', icon: Icon(Icons.cloud)),
              BottomNavigationBarItem( label: 'Favourites', icon: Icon(Icons.place_sharp)),
            ],
            onTap: ( value ){
              final viewBloc = BlocProvider.of<ViewCubit>(context, listen: false);
              viewBloc.changePage( value );
            },
          );
        },
      ),
    );
  }
}
