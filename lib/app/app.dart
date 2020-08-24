import 'package:flutter/material.dart';
import 'package:pidos/app/tab_navigator.dart';
import 'package:pidos/device/nav/nav_slide_from_right.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/bottom_navigation.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/main_tabs_page.dart';
import 'package:pidos/src/presentation/pages/home/home_page.dart';
import 'package:pidos/src/presentation/widgets/drawer_nav.dart';


class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// tab actual
  TabItem _currentTab = TabItem.home;

  ///
  /// [variable importante]
  /// [contextNavigatorPage] contiene el contexto del widget hijo
  /// sirve para poder pusher una ruta sin que se elimine el bottom navigation bar
  ///
  BuildContext contextNavigatorPage;

  // variable para el nombre de la ruta
  String routeName;

  // controller para manejar la navegacion de los tabs
  PageController _pageController;

  /// vaiable que contiene la ruta actual
  /// RUTAS: ['/']['main_tabas']
  String currentTabRoute = TabNavigatorRoutes.home;

  /// [variable importante]
  /// El navigator es el que hace posible que se peude pushear una ruta sin que 
  /// se destruya el bottom navigation
  final _navigatorKey = GlobalKey<NavigatorState>();

  ///
  /// Global Scafol Key 
  /// varaible para manejar el drawer nav
  ///
  final GlobalKey<ScaffoldState> _globalScaffoldKey = new GlobalKey(); 


  // void _selectTab(TabItem tabItem) {
  //   if (tabItem == _currentTab) {
  //     // pop to first route
  //     _navigatorKey.currentState.popUntil((route) => route.isFirst);
  //   } else {
  //     setState(() => _currentTab = tabItem);
  //   }
  // }


  ///
  /// metodo que se ejecuta cuando se clickea un tab
  ///
  void _onPushTab(TabItem tabItem) {
    
    if(tabItem != _currentTab){
      // varialbe que el indica tab seleccionado
      int indexSelected = 0;
      /// retorna el index selecionado en el Tab
      for(int i=0; i<TabItem.values.length;i++ ){
        if( tabItem == TabItem.values[i] ){
          indexSelected = i;
          break;
        }
      }
      /// indexSelected = 3 ; solo si estane la pesataña de aliados
      /// se setea a indexSelected = 2 porque solo exiten 3 tabs
      if( indexSelected == 3 ) indexSelected = 2;
      /// se hace un setState para pintar el tab seleccionado
      setState(() => _currentTab = tabItem);
      
      /// Si se esta en la pestaña de los tabs y el tab actual es diferente al de Home
      /// entonces salta entre pestañas
      /// de lo contrario se navegaga a las vistas de los tabs
      if( currentTabRoute == TabNavigatorRoutes.mainTabs && _currentTab!=TabItem.home ){
        _pageController.jumpToPage(indexSelected);
      }else{
        currentTabRoute = TabNavigatorRoutes.mainTabs;
        _pageController = PageController(initialPage: indexSelected);
        _push(contextNavigatorPage,indexSelected);
      }
      
    }
  }

  ///
  /// Function que se encarga de pushear la ruta seleccionada
  ///
  void _push(BuildContext contextNav, int indexSelected) async {
    var routeBuilders = _routeBuilders(contextNav, indexSelected);
    await Navigator.push(
      contextNav,
      MaterialPageRoute(
        builder: (contextNav) => routeBuilders[TabNavigatorRoutes.mainTabs](contextNav),
      ),
    );
    currentTabRoute = TabNavigatorRoutes.home;
    setState(() => _currentTab = TabItem.home);
  }

  ///contiene las rutas 
  ///Routes: ['/']['/main_tabs']
  ///
  Map<String, WidgetBuilder> _routeBuilders( BuildContext context, int indexSelected ) {
    return {
      TabNavigatorRoutes.home: (context) => HomePage(globalScaffoldKey: _globalScaffoldKey),
      TabNavigatorRoutes.mainTabs: (context) {
        return MainTabsPage(
          pageController: _pageController,
          globalScaffoldKey: _globalScaffoldKey
        );
      }
    };
  }


  ///
  /// metodo Build
  ///
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =!await _navigatorKey.currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != TabItem.home) {
            return true;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        key: _globalScaffoldKey,
        body: _buildBody(),
        endDrawer: DrawerNav(),
        bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            onPushTab: _onPushTab,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return TabNavigator(
      navigatorKey: _navigatorKey,
      globalScaffoldKey: _globalScaffoldKey,
      contextNavigatorPage: (ctxNavPage) {
        contextNavigatorPage = ctxNavPage;
      },
    );
  }

}