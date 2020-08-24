import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/dialogs/transferir_dialog.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/circle_color.dart';
import 'package:pidos/src/utils/colors.dart';


class MiMonederoTabPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalScaffoldKey;

  MiMonederoTabPage({
    this.globalScaffoldKey
  });

  @override
  _MiMonederoTabPageState createState() => _MiMonederoTabPageState();
}

class _MiMonederoTabPageState extends State<MiMonederoTabPage> {

  double screenSizeHeight;
  double screenSizeWidth;


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
  /// Seccion principal
  ///
  Widget _bodySection() {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(height: 20.0),
                Text(
                  '¡Hola $_username!',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.00844), //vertical: 5.0
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
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _cardPidsDisponibles(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenSizeHeight * 0.0337), //bottom: 20.0
              child: _transferirButton(),
            )
          ],
        ),
      ),
    );
  }


  ///
  /// Card de pids disponibles
  ///
  Widget _cardPidsDisponibles(){
    return Padding(
      padding: EdgeInsets.only(top: screenSizeHeight * 0.0337, right:screenSizeWidth * 0.111, left: screenSizeWidth * 0.111), //top: 20.0, right: 40.0, left: 40.0
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenSizeWidth * 0.097), //horizontal: 35.0
        width: double.infinity,
        height: screenSizeHeight * 0.337, //height: 200.0,
        decoration: BoxDecoration(
          color: electricVioletColor,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: Offset(0.0, 5.0),
            spreadRadius: 0.5
          )
        ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Tienes', style: TextStyle( fontSize: 20.0, color: Colors.white )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleWidget(
                  width: screenSizeWidth * 0.111, //width: 40.0,
                  height: screenSizeHeight * 0.067, //height: 40.0
                  color: Colors.transparent,
                  borderColor: Colors.white,
                  borderWidth: 2.5,
                  widget: Center(
                    child: CircleWidget(
                      width: screenSizeWidth * 0.0416, //width: 15.0, 
                      height: screenSizeHeight * 0.0253,  //height: 15.0,  
                      color: Colors.white
                    ),
                  ),
                ),
                SizedBox(width: screenSizeWidth * 0.022), //width: 8.0
                Text('1.000.000', style: TextStyle( fontSize: 35.0, fontWeight: FontWeight.w700,color: Colors.white )),
              ],
            ),
            Text('pids disponibles', style: TextStyle( fontSize: 20.0, color: Colors.white )),
          ],
        )
      ),
    );
  }


  ///
  /// Boton de transferencia
  ///
  Widget _transferirButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.00844, horizontal: screenSizeWidth * 0.0833  ), //vertical: 5.0, horizontal: 30.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: screenSizeHeight * 0.0253 ), //vertical: 15.0
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
          onPressed:() => transferirDialog(context: context)
        ),
      ),
    );
  }









  @override
  Widget build(BuildContext context) {
    screenSizeHeight = MediaQuery.of(context).size.height;
    screenSizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: cyanColor),
          onPressed:() => Navigator.of(context).pop()
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
              )
            ),
          )
        ],
      ),
      // endDrawer: DrawerNav(),
      body: Stack(
        children: [
          Container(
            color: primaryColor,
            width: double.infinity,
            height: (screenSizeHeight>600) ? screenSizeHeight * 0.48 : screenSizeHeight * 0.58,
          ),
          _bodySection(),
        ],
      ),
    );
  }
}