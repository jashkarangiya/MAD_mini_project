import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon( Icons.cloud, size:50, color: Colors.grey, ),

          SizedBox(
            height: 20,
          ),

          Text('VERIFICA LA CONEXION A INTERNET',
          textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400
            )
          ),

          SizedBox(
            height: 20,
          ),

          Icon( Icons.sunny, size:50, color: Colors.amber, )
        ],
      )
    );
  }
}