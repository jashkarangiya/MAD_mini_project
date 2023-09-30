
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:examen_practico_clima/src/db/db_provider.dart';
import 'package:examen_practico_clima/src/blocs/view/view_cubit.dart';
import 'package:examen_practico_clima/src/blocs/gps/gps_bloc.dart';
import 'package:examen_practico_clima/src/blocs/wheater/wheater_bloc.dart';
import 'package:examen_practico_clima/src/screens/screens.dart';
import 'package:examen_practico_clima/src/shar_prefs/shar_prefs.dart';
import 'package:examen_practico_clima/src/services/wheater_service.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final shared =  SharPrefs();
  await shared.initPrefs();
  await DBProvider.db.initDB();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GpsBloc()),
        BlocProvider(create: (_) => WheaterBloc( wheaterService: WheaterService() )),
        BlocProvider(create: (_) => ViewCubit() ),
      ], 
      child: const WheaterApp()
    )
  );
}

class WheaterApp extends StatelessWidget {
const WheaterApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValidationScreen(),
    );
  }
}