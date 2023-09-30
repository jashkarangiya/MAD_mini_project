/*
*  Screen: AccessGpsScreen
*  Function: Show gps status
*/

import 'package:examen_practico_clima/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/gps/gps_bloc.dart';

class AccessGpsScreen extends StatelessWidget {

  const AccessGpsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isGpsEnabled 
          ? const GpsNotGranted()
          : const GpsDisabled();
        },
      ),
    );
  }
}

class GpsNotGranted extends StatelessWidget {
  const GpsNotGranted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ACCEPT THE LOCATION PEMISSION',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
      
              const SizedBox(
                height: 20,
              ),
              
              CustomButton(
                text: 'REQUEST PERMISSION',
                onPressed: () async {
                  final gpsBloc = BlocProvider.of<GpsBloc>(context, listen: false);
                  await gpsBloc.getGpsAccess();
                },
              )
            ],
          ),
        ),
    ); 
  }
}


class GpsDisabled extends StatelessWidget {

const GpsDisabled ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [

        Center(
          child: Text(
            'ACTIVATE YOUR LOCATION',
          style: TextStyle( 
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
        ),
        
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}