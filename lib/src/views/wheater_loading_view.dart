/*
*  View: WheaterLoadingView
*  Function: Show loading screen while getting initial setup
*/


import 'package:flutter/material.dart';

class WheaterLoadingView extends StatelessWidget {
  const WheaterLoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon( Icons.cloud, size: 70, color: Colors.grey,),
              SizedBox( width: 20 ,),
              Icon( Icons.cloud, size: 70, color: Colors.grey,),
            ],
          ),

          const SizedBox(
            height: 20,
          ),
          
          const Text('PLEASE WAIT', style: TextStyle( fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic ),),

          const SizedBox(
            height: 20,
          ),
          
          const LinearProgressIndicator(),

          const SizedBox(
            height: 20,
          ),

          const Icon(Icons.sunny, size: 70, color: Colors.amber,)
        ],
      ),
    );
  }
}