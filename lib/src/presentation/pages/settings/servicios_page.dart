import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/blocs/servicios_bloc.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/drawer_nav.dart';
import 'package:pidos/src/utils/colors.dart';


class ServiciosPage extends StatefulWidget {

  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool isPidCashActive = false;
  PreferenciasUsuario _prefs;

  @override
  void initState() { 
    _prefs = PreferenciasUsuario();
    final active = _prefs.getBool(StorageKeys.pidCash);
    if(active){
      isPidCashActive = active;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: cyanColor),
          onPressed:()  => Navigator.of(context).pop(),
        ),
        actions: [
          InkResponse(
            onTap: () => _scaffoldKey.currentState.openEndDrawer(),
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: CircleAvatarName(
                diameterOutside: 40.0,
                diameterInside: 25.0,
                shortName: 'K',
                textSize: 10.0,
              ),
            ),
          )
        ],
      ),
      endDrawer: DrawerNav(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                child: Text('Servicios', style: TextStyle(fontFamily: 'Raleway',color: primaryColor, fontSize: 30.0,fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                child: Text('Encuentra aquí tus servicios disponibles',textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF666666), fontSize: 18.0)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Puntos Pidos', style: TextStyle(color: primaryColor, fontSize: 22.0,fontWeight: FontWeight.w700)),
                    IgnorePointer(
                      child: FlutterSwitch(
                        activeColor: primaryColor,
                        inactiveColor: Color(0xFF666666),
                        toggleColor: Colors.white,
                        value: true,
                        onToggle: (val) => print('$val'),
                        padding: 2.0,
                        toggleSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Pid Cash', style: TextStyle(color: primaryColor, fontSize: 22.0,fontWeight: FontWeight.w700)),
                    FlutterSwitch(
                      activeColor: primaryColor,
                      inactiveColor: Color(0xFF666666),
                      toggleColor: Colors.white,
                      value: isPidCashActive,
                      onToggle: (val) {
                        setState(() {
                          isPidCashActive=!isPidCashActive;
                          BlocProvider.of<ServiciosBloc>(context).isPidChasActiveSink$.add(isPidCashActive);
                          // _prefs.setBool(StorageKeys.pidCash, isPidCashActive);
                        });
                      },
                      padding: 2.0,
                      toggleSize: 30.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}