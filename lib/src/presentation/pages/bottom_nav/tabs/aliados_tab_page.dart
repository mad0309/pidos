import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
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
    final usuario = PreferenciasUsuario().getUsuario();
    _shortName = usuario.shortName;
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
              child: LayoutBuilder(
                builder: (context, constrains) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constrains.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Aliados", style: TextStyle(fontFamily: 'Raleway', color:Colors.white, fontSize: 35.0, fontWeight: FontWeight.w600 ) ),
                            SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 45.0),
                              // child: AliadosInput(),
                              child: _filterInpustWidgets(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
                              child: _buscarButton(),
                            ),
                            SizedBox(height: 10.0),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(top:40.0, left: 20.0, right: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0),
                                  ),
                                  color:Colors.white
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Muy Pronto', style: TextStyle( color: primaryColor, fontSize: 35.0, fontWeight: FontWeight.w700 )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Text('encontrarás nuestros aliados aqui',textAlign: TextAlign.center, style: TextStyle( color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600 ), ),
                                      ),
                                    ],
                                  ),
                                ),
                                // child: GridView.builder(
                                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                //     mainAxisSpacing: 5.0,
                                //     crossAxisSpacing: 5.0, //space horizontal
                                //     crossAxisCount: 2,
                                //     childAspectRatio: 1.0
                                //   ),
                                //   itemCount: 9,
                                //   itemBuilder: (BuildContext context, int index) {
                                //     return AliadosWidget(
                                //       title: 'Aliado ${index + 1}',
                                //     );
                                //   }
                                // ),
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          )
        ],
      )
    );
  }

  Widget _filterInpustWidgets(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: AliadosInput(hintTitle: 'Elige un servicio')
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: AliadosInput(hintTitle: 'Categoría'),
              ),
              SizedBox(width: 15.0),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: AliadosInput(hintTitle: 'Ciudad'),
              ),
            ]
          ),
        )
      ],
    );
  }

  /// boton de buscar
  Widget _buscarButton(){
    return InkWell(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          color: secundaryColor,
          borderRadius: BorderRadius.circular(20.0)
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: double.infinity,
        child: Center(
          child: Text('Buscar', style: TextStyle(color: primaryColor ,fontSize: 18.0, fontWeight: FontWeight.w700))
        ),
      ),
    );
  }
}