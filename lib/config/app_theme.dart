
import 'package:flutter/material.dart';
import 'package:voting_app/constants/color_constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    //1
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: ColorConstants.primaryCOlor,
        elevation: 0.0,
        centerTitle: false,
      ),
     
      // iconTheme: IconThemeData(
      //   color: Colors.white,
      // ),

      //2
    
      textTheme: TextTheme(
          headline3: const TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
          bodyText1: const TextStyle(
            fontSize: 18,
           
           
            color:Colors.black,
          ),
          bodyText2: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
           color:Colors.black,
          ),
          subtitle1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            
            color: Colors.grey[700]!
          ),
         
        ),
    );
  }
}
