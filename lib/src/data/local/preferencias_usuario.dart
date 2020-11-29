import 'dart:convert';

import 'package:pidos/src/data/local/entities/usuario_entity.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StorageKeys {
  static final String token = "TOKEN";
  static final String usuario = "USUARIO";
  static final String newAccountFirstLogin = "FIRSTLOGIN";
  static final String lastHourActive = "LASTHOURACTIVE";
  
  // static final String perfil ="PERFIL";
  // static final String pid ="PID";
  // static final String shortName ="SHORTNAME";
  static final String pidCash ="PIDCASH";
}

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String get(String key) {
    return _prefs.getString(key) ?? '';
  }

  bool getBool(String key){
    return _prefs.getBool(key) ?? false;
  }
  void setBool(String key, bool value){
    _prefs.setBool(key, value);
  }

  void set(String key, dynamic value){
    _prefs.setString(key, value);
  }

  void remove(String key) {
    _prefs.remove(key);
  }



  //this is for App page
  Future<UsuarioEntity> get getUsuarioFuture async {
    final jsonString = _prefs.getString(StorageKeys.usuario);
    if( jsonString == null ){
      return Future.value(null);
    } else {
      return Future.value(UsuarioEntity.fromJson( json.decode(jsonString) ));
    }
  }

  Usuario getUsuario(){
    final jsonString = _prefs.getString(StorageKeys.usuario);
    if( jsonString == null ){
      return null;
    } else {
      return Usuario.fromJson( json.decode(jsonString) );
    }
  }

  Future<void> saveToken(String token) async {
    try{
      await _prefs.setString(StorageKeys.token, token);
      print('Saved $token');
    }catch (err) {
      throw ('Cannot save token => $err');
    }
  }
  
  Future<void> saveUsuario(UsuarioEntity usuario) async {
    bool resultU;
    try {
      resultU = await  _prefs.setString(StorageKeys.usuario, jsonEncode(usuario.toJson()));
      print('Saved $usuario');
    } catch (err) {
      throw ('Cannot save user => $err');
    }
    if (!resultU) {
      throw ('Cannot save user ');
    }
  }

  Future<void> saveUsuarioDomain(Usuario usuario) async {
    bool resultU;
    try {
      resultU = await  _prefs.setString(StorageKeys.usuario, jsonEncode(usuario.toJson()));
      print('Saved $usuario');
    } catch (err) {
      throw ('Cannot save user => $err');
    }
    if (!resultU) {
      throw ('Cannot save user ');
    }
  }

  Future<void> removeUsuarioAndToken() async {
    remove(StorageKeys.usuario);
    remove(StorageKeys.token);
    // remove(StorageKeys.pidCash);
    return Future.value();
  }


}