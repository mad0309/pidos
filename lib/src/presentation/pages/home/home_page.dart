import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:pidos/app/global_singleton.dart';
import 'package:pidos/src//utils/colors.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/blocs/login/login_bloc.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/dialogs/transferir_dialog.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/icons_widgets/bell_icon.dart';
import 'package:pidos/src/presentation/widgets/sesion_expirada_dialog.dart';
import 'package:pidos/src/utils/extensions.dart';

class HomePage extends StatefulWidget {
  /// [globalScaffoldKey]
  /// sirve para poder abrir el drawe nav
  final GlobalKey<ScaffoldState> globalScaffoldKey;

  const HomePage({Key key, this.globalScaffoldKey}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  double screenSizeHeight;
  double screenSizeWidth;
  Future<void> timer;

  final _carruselData = ['slide-app-2.jpg', 'slide-app-1.jpg'];

  /// variable para controlar los radio button
  /// incializa como 1 para marcar el primer radio button
  int idRadioButton = 1;

  Usuario usuario;
  String _username = '';
  String _pidNumber = '';
  String _perfil = '';
  String _shortName = '';

  @override
  void initState() {
    _inactivarSesion();
    WidgetsBinding.instance.addObserver(this);
    /// ======= get data from local storage ===== ///
    final _sharedPrefs = PreferenciasUsuario();
    usuario = _sharedPrefs.getUsuario();
    _username = usuario.firstName;
    _pidNumber = usuario.document.toString();
    _perfil = usuario.role;
    _shortName = usuario.shortName;
    // _perfil = _sharedPrefs.get(StorageKeys.perfil);
    // _shortName = _sharedPrefs.get(StorageKeys.shortName);
    /// ======= =========================== ===== ///
    super.initState();
  }

  @override
  void didChangeDependencies() {
    timer ??= Future.delayed(Duration(minutes: 100), () async {
      final contextApp = GlobalSingleton().contextApp;
      if( contextApp!=null ){
        await sesionExpiradaDialog(
          context: context,
        );
        BlocProvider.of<LoginBloc>(context).logout();
        // Navigator.of(contextApp).pushReplacementNamed('/login');
        Navigator.of(contextApp)..pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('THE APP IS ON RESUMED');
    }
    if (state == AppLifecycleState.paused) {
      print('THE APP IS PAUSED');
    }
    if (state == AppLifecycleState.detached) {
      _setLastActivehour();
      print('THE APP IS DETACHED');
    }
    if (state == AppLifecycleState.inactive) {
      print('THE APP IS INACTIVE');
    }
  }

  @override
  void dispose() { 
    print('[HOME_PAGE] dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _setLastActivehour(){
    final prefs = PreferenciasUsuario();
    prefs.set(StorageKeys.lastHourActive, DateTime.now().toIso8601String());
  }

  _inactivarSesion() async {
    final prefs = PreferenciasUsuario();
    final lastHourString = prefs.get(StorageKeys.lastHourActive);
    if( lastHourString!=null && lastHourString!='' ){
      final lastHour = DateTime.parse(lastHourString);
      final now = DateTime.now();
      final diferencia = lastHour.difference(now);
      if( diferencia.inMinutes >= 10 ) {
        final contextApp = GlobalSingleton().contextApp;
        await sesionExpiradaDialog(
          context: context,
        );
        BlocProvider.of<LoginBloc>(context).logout();
        // Navigator.of(contextApp).pushReplacementNamed('/login');
        Navigator.of(contextApp)..pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    }
  }

  ///
  /// Main Seccion
  ///
  Widget _bodySection() {
    final dia = DateFormat('dd', 'es').format(DateTime.now());
    final mes = DateFormat('MMMM', 'es').format(DateTime.now());
    final ano = DateFormat('y', 'es').format(DateTime.now());
    final fechaActual = '$dia de ${mes.capitalize()} del $ano';
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¡Hola $_username!',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenSizeHeight * 0.008445), //vertical: 5.0
              child: Text(
                fechaActual,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              (_perfil != roleUsuarioName[RoleUsuario.cliente])
                  ? 'PID - $_pidNumber'
                  : 'Pidos ID: PID - $_pidNumber',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            _carruselHorizontal(),
            (_perfil != roleUsuarioName[RoleUsuario.cliente])
                ? _radioButtonSection()
                : Padding(padding: EdgeInsets.symmetric(vertical: 30.0)),
            _transferirButton()
          ],
        ),
      ),
    );
  }

  ///
  /// Carrusel de Silder horizontal Scroll
  ///
  Widget _carruselHorizontal() {
    return Padding(
      padding: EdgeInsets.only(top: screenSizeHeight * 0.0337), //top: 20.0
      child: Container(
        // color: Colors.red,
        height: screenSizeHeight * 0.337, //height: 200.0,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: _carruselData.map((data) {
              final index = _carruselData.indexOf(data);
              if (index == _carruselData.length - 1) {
                //ultimo valor
                return Padding(
                  padding: EdgeInsets.only(right: screenSizeWidth * 0.0416),
                  child: _carruselChild(data),
                );
              } else {
                return _carruselChild(data);
              }
            }).toList()),
      ),
    );
  }

  ///
  /// Card
  ///
  Widget _carruselChild(String title) {
    return Padding(
      padding: EdgeInsets.only(left: screenSizeWidth * 0.0416), //left: 15.0
      child: Container(
        width: screenSizeWidth * 0.833, //width: 300.0,
        height: double.infinity,
        decoration: BoxDecoration(
            color: secundaryColor, borderRadius: BorderRadius.circular(30.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image(
            image: AssetImage('assets/img/$title'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  ///
  /// Seccion de los radio Buttons
  ///
  Widget _radioButtonSection() {
    return Padding(
        padding:
            EdgeInsets.only(bottom: screenSizeHeight * 0.016), // bottom: 10.0
        child: SizedBox(
          width: screenSizeWidth * 0.5, //width: 180.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Enviar PIDS',
                    style: new TextStyle(fontSize: 15.0),
                  ),
                  Radio(
                    value: 1,
                    groupValue: idRadioButton,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: primaryColor,
                    onChanged: (val) {
                      setState(() {
                        idRadioButton = 1;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Recibir PIDS',
                    style: new TextStyle(fontSize: 15.0),
                  ),
                  Radio(
                    value: 2,
                    groupValue: idRadioButton,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: primaryColor,
                    focusColor: primaryColor,
                    onChanged: (val) {
                      setState(() {
                        idRadioButton = 2;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

  ///
  /// botton de transferir
  ///
  Widget _transferirButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSizeHeight * 0.00844,
          horizontal:
              screenSizeWidth * 0.0833), //vertical: 5.0, horizontal: 30.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenSizeHeight * 0.0253), //vertical: 15.0
              child: Text('Transferir',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0)),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: primaryColor,
            elevation: 0.0,
            textColor: Colors.white,
            // onPressed:() => muyProntoDialog(context: context)
            // onPressed:() {
            //   final contextApp = GlobalSingleton().contextApp;
            //   Navigator.of(contextApp).pushNamed('/transferencia',arguments: true);
            // }
            onPressed: () {
              transferirDialog(
                context: context,
                // fromPage: '/'
              );
              // final contextApp = GlobalSingleton().contextApp;
              // Navigator.of(contextApp).pushNamed('/action_not_avaible',
              //     arguments:
              //         'En este momento no cuentas con Pidos disponibles para realizar esta acción');
            }
        ),
      ),
    );
  }

  ///
  /// metodo build
  ///

  @override
  Widget build(BuildContext context) {
    screenSizeHeight = MediaQuery.of(context).size.height;
    screenSizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: BellIcon(
            imageUrl: 'assets/img/bell_icon.png',
            size: 28.0,
          ),
          onPressed: () {},
        ),
        actions: [
          InkResponse(
            onTap: () => widget.globalScaffoldKey.currentState.openEndDrawer(),
            child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: CircleAvatarName(
                  diameterOutside: 40.0,
                  diameterInside: 25.0,
                  shortName: _shortName,
                  textSize: 10.0,
                )),
          )
        ],
      ),
      // endDrawer: (_perfil == 'CLIENTE') ? null : DrawerNav(),
      body: Stack(
        children: [
          Container(
            color: primaryColor,
            width: double.infinity,
            height: (screenSizeHeight > 600)
                ? screenSizeHeight * 0.5
                : screenSizeHeight * 0.6,
          ),
          SingleChildScrollView(child: _bodySection())
        ],
      ),
    );
  }
}
