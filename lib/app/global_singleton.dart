


import 'package:flutter/material.dart';

class GlobalSingleton {

  BuildContext contextApp;
  GlobalKey<ScaffoldState> globalScaffoldKey;

  static final GlobalSingleton _instancia = new GlobalSingleton._();

  GlobalSingleton._();
  

  factory GlobalSingleton({
    BuildContext contextApp,
    GlobalKey<ScaffoldState> globalScaffoldKey,
  }) {
    if( contextApp!=null ){
      _instancia.contextApp = contextApp;
    }
    if( globalScaffoldKey!=null ){
      _instancia.globalScaffoldKey = globalScaffoldKey;
    }
    return _instancia;
  }

  
}