import 'dart:developer';

import 'package:flutter/material.dart';


void findErrorBuilder(BuildContext context) {
  try{
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      log('errorDetailsResult.toString() ${errorDetails.toString()}');
      Future.delayed(const Duration(seconds: 1),(){
      });
      return const Scaffold(
          body: Center(
              child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Something went wrong',style: TextStyle(color: Colors.black),),
                  )
                ],
              ))
          ));
    };
  }
  catch(e){
    log('error check error $e');
  }
}