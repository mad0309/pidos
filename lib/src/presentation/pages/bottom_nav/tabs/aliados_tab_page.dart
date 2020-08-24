import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/widgets/bottom_nav_widgets/aliados_widget.dart';
import 'package:pidos/src/presentation/widgets/bottom_nav_widgets/search_widget.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/utils/colors.dart';


class AliadosTabPage extends StatefulWidget {

  final GlobalKey<ScaffoldState> globalScaffoldKey;

  AliadosTabPage({
    this.globalScaffoldKey
  });

  @override
  _AliadosTabPageState createState() => _AliadosTabPageState();
}

class _AliadosTabPageState extends State<AliadosTabPage> {

  String _shortName;
  @override
  void initState() { 
    _shortName = PreferenciasUsuario().get(StorageKeys.shortName);
    super.initState();
  }
  

  ///metodo build
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    print('width: ${_screenSize.width}');
    print('width: ${_screenSize.height}');
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
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: primaryColor
          ),
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Aliados", style: TextStyle(color:Colors.white, fontSize: 35.0, fontWeight: FontWeight.w500 ) ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 5.0),
                    child: SearchWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: _filterButton(),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top:40.0, left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                        ),
                        color:Colors.white
                      ),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0, //space horizontal
                          crossAxisCount: 2,
                          childAspectRatio: 1.0
                        ),
                        itemCount: 9,
                        itemBuilder: (BuildContext context, int index) {
                          return AliadosWidget(
                            title: 'Aliado ${index + 1}',
                          );
                        }
                      ),
                    )
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }

  /// boton de filtro
  Widget _filterButton(){
    return Container(
      decoration: BoxDecoration(
        color: secundaryColor,
        borderRadius: BorderRadius.circular(20.0)
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      width: 120.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.filter_list, size: 15.0, color: Colors.grey ),
          Text('Filtros', style: TextStyle(color: Colors.grey, fontSize: 15.0 ))
        ],
      ),
    );
  }
}