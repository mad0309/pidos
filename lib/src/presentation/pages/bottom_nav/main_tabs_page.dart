import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/tabs/aliados_tab_page.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/tabs/comprar_tab_page.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/tabs/mi_monedero_tab_page.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/tabs/movimientos_tab_page.dart';




class MainTabsPage extends StatefulWidget {

  final PageController pageController;
  final GlobalKey<ScaffoldState> globalScaffoldKey;

  MainTabsPage({
    this.pageController,
    this.globalScaffoldKey
  });



  @override
  _MainTabsPageState createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage> {

  List<Widget> _screens;
  String _perfil = '';

  @override
  void initState() {
    final _sharedPrefs = PreferenciasUsuario();
    _perfil = _sharedPrefs.get(StorageKeys.perfil);

    _screens = [
      MiMonederoTabPage(globalScaffoldKey: widget.globalScaffoldKey),
      MovimientosTabPage(globalScaffoldKey: widget.globalScaffoldKey),
      ( _perfil=="CLIENTE" )
        ? ComprarTabPage(globalScaffoldKey: widget.globalScaffoldKey)
        : AliadosTabPage(globalScaffoldKey:widget.globalScaffoldKey)
  ];

    super.initState();
  }

  @override
  void dispose() { 
    widget.pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: widget.pageController,
        children: _screens,
        onPageChanged: (index){},
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}