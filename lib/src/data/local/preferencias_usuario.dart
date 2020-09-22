import 'package:shared_preferences/shared_preferences.dart';


class StorageKeys {
  static final String token = "TOKEN";
  static final String usuario = "USUARIO";
  static final String perfil ="PERFIL";
  static final String pid ="PID";
  static final String shortName ="SHORTNAME";
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


}