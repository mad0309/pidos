import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:pidos/src//utils/colors.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/blocs/login/login_bloc.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';




class DrawerNav extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _sharedPrefs = PreferenciasUsuario();
    final usuario = _sharedPrefs.getUsuario();
    final _shortName = usuario.shortName ?? '';
    final _username = usuario.name ?? '';
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
                onTap: () => Navigator.popAndPushNamed(context, '/home'),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Text('Inicio',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600)),
                ),
              ),
              InkWell(
                onTap: () => Navigator.popAndPushNamed(context, '/mi_cuenta'),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Mi cuenta',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600)),
                ),
              ),
              // InkWell(
              //   onTap: () => Navigator.popAndPushNamed(context, '/servicios'),
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(vertical: 10.0),
              //     child: Text('Servicios',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600)),
              //   ),
              // ),
              InkWell(
                onTap: () => Navigator.popAndPushNamed(context, '/ayuda'),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Ayuda',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600)),
                ),
              ),
              InkWell(
                onTap: () => Navigator.popAndPushNamed(context, '/acerca_de'),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Acerca de',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600)),
                ),
              ),
              InkWell(
                onTap: () => Navigator.popAndPushNamed(context, '/trabaja_con_nosotros'),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Trabaja con nosotros',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600)),
                ),
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<LoginBloc>(context).logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Cerrar sesión',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}