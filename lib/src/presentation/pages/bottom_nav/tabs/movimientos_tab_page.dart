import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/widgets/bottom_nav_widgets/movimientos_widget.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/utils/colors.dart';


class MovimientosTabPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalScaffoldKey;

  MovimientosTabPage({
    this.globalScaffoldKey
  });

  @override
  _MovimientosTabPageState createState() => _MovimientosTabPageState();
}

class _MovimientosTabPageState extends State<MovimientosTabPage> {

  String _shortName;
  int movimientosLenght = 0;

  @override
  void initState() {
    final usuario = PreferenciasUsuario().getUsuario();
    _shortName = usuario.shortName;
    super.initState();
  }
  

  ///
  /// METODO BUILD
  ///
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: cyanColor),
          onPressed:() => Navigator.of(context).pop(),
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
              ),
            ),
          )
        ],
      ),
      // endDrawer: DrawerNav(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(),
            actions: [Container()],
            pinned: true, //fixed
            expandedHeight: _screenSize.height * 0.25,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none, //give effect if there was an image
              titlePadding: EdgeInsets.zero,
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 1,
                    child:
                        Text("Tus movimientos", textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600),),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: primaryColor,
              height: 20.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if(movimientosLenght == 0){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80.0),
                      Image(
                        color: Colors.black.withOpacity(0.6),
                        image: AssetImage('assets/img/movimientos_icon_tab.png'),
                        fit: BoxFit.cover,
                        width: 50.0,
                      ),
                      SizedBox(height: 20.0),
                      Text('Aun no cuenta con movimientos', style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w700, color: Colors.black.withOpacity(0.6)))
                    ],
                  ),
                );
              }else{
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: MovimientosWidget(
                    fechaMovimiento: '10/Enero/20',
                    pids: '350',
                    pidId: 'A900697856',
                    comerciante: 'Pollos Frisby',
                    comercianteId: '0012345679',
                  ),
                );
              }
            }, childCount: 1)
          )
        ],
      ),
    );
  }
}