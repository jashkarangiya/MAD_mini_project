/*
*  Widget: Custom button
*  Function: Reusable button
*/

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

const CustomButton({ Key? key, this.backgroundColor, required this.text, this.onPressed }) : super(key: key);

  final Color? backgroundColor;
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context){
    return MaterialButton(
      color: backgroundColor ?? Colors.black,
      elevation: 0,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      onPressed: onPressed,
      textColor: Colors.white,
      child: Text( text ),
    );
  }
}