import 'package:flutter/material.dart';
import 'package:pidos/app/global_singleton.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/drawer_nav.dart';
import 'package:pidos/src/presentation/widgets/muy_pronto_dialog.dart';
import 'package:pidos/src/utils/colors.dart';

class ComprarPidCashPage extends StatefulWidget {
  
  @override
  _ComprarPidCashPageState createState() => _ComprarPidCashPageState();
}

class _ComprarPidCashPageState extends State<ComprarPidCashPage> {

  double screenSizeHeight ;
  double screenSizeWidth ;

  bool compraSucess = false;

  /// [pidCounter] variable que contraola los nro de pids
  int pidCounter = 0;

  String shortName;

  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    final _sharedPrefs = PreferenciasUsuario();
    final usuario = _sharedPrefs.getUsuario();
    shortName = usuario.shortName;
    super.initState();
  }

  ///
  /// Titulo de pagina
  ///
  Widget _headerTitle(){
    return SafeArea(
      child: Container(
        // color:Colors.red,
        child: Padding(
          padding: EdgeInsets.only(bottom: screenSizeHeight * 0.138, top: screenSizeHeight * 0.0337), //bottom: 80.0, top: 20.0
          child: Text('Comprar', style: TextStyle(fontFamily: 'Raleway',fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }


  ///
  /// contenedor princiapal
  ///
  Widget _bodyContainer(){
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenSizeHeight * 0.067, bottom: screenSizeHeight * 0.0337), //top: 40.0, bottom: 20.0
              child: Text('Pid Cash', style: TextStyle(fontSize: 25.0, color: Color(0xFF4D4D4D),fontWeight: FontWeight.w600 ))
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSizeWidth * 0.111), //horizontal: 40.0
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => setState(() {
                          if(pidCounter>0){
                            pidCounter--; 
                          }
                        }),
                        icon: Text('-', style: TextStyle(color: Color(0xFF666666),fontSize: 25.0,fontWeight: FontWeight.w500))
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: screenSizeWidth * 0.022, vertical: screenSizeHeight * 0.0005), //horizontal: 8.0, vertical: 3.0
                        width: screenSizeWidth * 0.1944, //width: 70.0,
                        color: secundaryColor,
                        child: Text('$pidCounter', textAlign: TextAlign.start, style: TextStyle(color: Color(0xFF666666),fontSize: 20.0)),
                      ),
                      IconButton(
                        onPressed: () => setState(() {
                            pidCounter++; 
                        }),
                        icon: Text('+', style: TextStyle(color: Color(0xFF666666),fontSize: 25.0,fontWeight: FontWeight.w500))
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenSizeWidth * 0.0277), //right: 10.0
                    child: Text('\$0',style: TextStyle(color: Color(0xFF666666),fontSize: 20.0, fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            ),
            // SizedBox(height: screenSizeHeight * 0.084), //height: 50.0
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text('Valor Pid Cash \$3.799 ',textAlign: TextAlign.center,style: TextStyle(fontSize: 15.0,color: Colors.black))
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSizeWidth * 0.111), //horizontal: 40.0
              child: Divider(color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenSizeHeight  * 0.033), //vertical: 20.0
              child: Text('\$00.0', style: TextStyle(color: Colors.black,fontSize: 25.0, fontWeight: FontWeight.w700)),
            ),
            _comprarButton()
            
          ],
        ),
      ),
    );
  }


  ///
  /// boton de comrar
  ///
  Widget _comprarButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.00844, horizontal: screenSizeWidth * 0.111  ), //vertical: 5.0, horizontal: 40.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: screenSizeHeight * 0.016 ), //vertical: 10.0
            child: Text(
              'Comprar',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0
              )
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: primaryColor,
          elevation: 0.0,
          textColor: cyanColor,
          // onPressed:()  => muyProntoDialog(context: context)
          // onPressed:()  {
          //   Navigator.of(context).pushNamed('/compra_detalle', arguments: !compraSucess);
          //   compraSucess = !compraSucess;
          // }
          onPressed:()  => Navigator.of(context).pushNamed(
            '/action_not_avaible', 
            arguments: 'En este momento no es posible realizar esta acción intenta más tarde'
          )
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
      key: scaffoldKey,
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: cyanColor),
          onPressed:() => Navigator.of(context).pop()
        ),
        actions: [
          InkResponse(
            onTap: () => scaffoldKey.currentState.openEndDrawer(),
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: CircleAvatarName(
                diameterOutside: 40.0,
                diameterInside: 25.0,
                shortName: shortName,
                textSize: 10.0,
              ),
            ),
          )
        ],
      ),
      endDrawer: DrawerNav(),
      body: Stack(
        children: [
          Container(
            color: primaryColor,
            width: double.infinity,
            height: double.infinity,
          ),
          SizedBox(
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constrains) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constrains.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _headerTitle(),
                          _bodyContainer()
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}