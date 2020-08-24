import 'package:flutter/material.dart';
import 'package:pidos/src//utils/colors.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';




class DrawerNav extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _sharedPrefs = PreferenciasUsuario();
    final _shortName = _sharedPrefs.get(StorageKeys.shortName);
    final _username = _sharedPrefs.get(StorageKeys.usuario);
    return SizedBox(
      width: _screenSize.width * 0.6,
      child: Drawer(
        child: Container(
          alignment: Alignment.center,
          color: electricVioletColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: CircleAvatarName(
                    diameterOutside: 40.0,
                    diameterInside: 25.0,
                    shortName: _shortName,
                    textSize: 10.0,
                  ) 
                )
              ),
              Text(_username,textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Divider(color: Colors.white, thickness: 1.0),
              ),
              InkWell(
                onTap: () => Navigator.popAndPushNamed(context, '/mi_cuenta'),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text('Mi cuenta',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600)),
                ),
              ),
              InkWell(
                onTap: () => Navigator.popAndPushNamed(context, '/ayuda'),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Ayuda',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600)),
                ),
              ),
              InkWell(
                onTap: () => Navigator.popAndPushNamed(context, '/acerca_de'),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Acerca de',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}