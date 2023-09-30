/*
*  Screen: ValidationScreen
*  Function: Show gps status
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examen_practico_clima/src/screens/screens.dart';

import '../blocs/gps/gps_bloc.dart';

class ValidationScreen extends StatelessWidget {
  const ValidationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isReady 
          ? const HomeScreen()
          : const AccessGpsScreen();
        },
      ),
    );
  }
}
