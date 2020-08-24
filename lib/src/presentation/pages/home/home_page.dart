import 'package:flutter/material.dart';
import 'package:pidos/src//utils/colors.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/icons_widgets/bell_icon.dart';
import 'package:pidos/src/presentation/widgets/muy_pronto_dialog.dart';


class HomePage extends StatefulWidget {

  /// [globalScaffoldKey]
  /// sirve para poder abrir el drawe nav
  final GlobalKey<ScaffoldState> globalScaffoldKey;

  const HomePage({Key key, this.globalScaffoldKey}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _carruselData = ['Foto 1','Foto 2','Foto 3' ]; 

  /// variable para controlar los radio button
  /// incializa como 1 para marcar el primer radio button
  int idRadioButton = 1;

  String _username = '';
  String _pidNumber = '';
  String _perfil = '';
  String _shortName = '';


  @override
  void initState() { 
    /// ======= get data from local storage ===== ///
    final _sharedPrefs = PreferenciasUsuario();
    _username = _sharedPrefs.get(StorageKeys.usuario);
    _pidNumber = _sharedPrefs.get(StorageKeys.pid);
    _perfil = _sharedPrefs.get(StorageKeys.perfil);
    _shortName = _sharedPrefs.get(StorageKeys.shortName);
    /// ======= =========================== ===== ///
    super.initState();
  }


  ///
  /// Main Seccion
  ///
  Widget _bodySection() {
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
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                '06 de Agosto del 2020',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              (_perfil == "CLIENTE") ? 'PID - $_pidNumber' : 'Pidos ID: PID - $_pidNumber',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            _carruselHorizontal(),
            ( _perfil == 'CLIENTE' )
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
  Widget _carruselHorizontal(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        // color: Colors.red,
        height: 200.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _carruselData.map((data) => _carruselChild(data)).toList(),
        ),
      ),
    );
  }

  ///
  /// Card
  ///
  Widget _carruselChild(String title){
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: Container(
        width: 300.0,
        height: double.infinity,
        decoration: BoxDecoration(
          color: secundaryColor,
          borderRadius: BorderRadius.circular(30.0)
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w700
            )
          ),
        ),
      ),
    );
  }

  ///
  /// Seccion de los radio Buttons
  ///
  Widget _radioButtonSection(){
    
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        width: 180.0,
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
      )
    );
  }


  ///
  /// botton de transferir
  ///
  Widget _transferirButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0 ),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: 15.0 ),
            child: Text(
              'Transferir',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0
              )
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          ),
          color: primaryColor,
          elevation: 0.0,
          textColor: Colors.white,
          onPressed:() => muyProntoDialog(context: context)
        ),
      ),
    );
  }
  
  ///
  /// metodo build
  ///

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
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
          onPressed:() {},
        ),
        actions: [
          (_perfil == 'CLIENTE')
            ? Container()
            : InkResponse(
                onTap: () => widget.globalScaffoldKey.currentState.openEndDrawer(),
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: CircleAvatarName(
                    diameterOutside: 40.0,
                    diameterInside: 25.0,
                    shortName: _shortName,
                    textSize: 10.0,
                  )
                ),
              )
        ],
      ),
      // endDrawer: (_perfil == 'CLIENTE') ? null : DrawerNav(),
      body: Stack(
        children: [
          Container(
            color: primaryColor,
            width: double.infinity,
            height: _screenSize.height * 0.6,
          ),
          SingleChildScrollView(child: _bodySection())
        ],
      ),
    );
  }
}