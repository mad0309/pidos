import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/bottom_navigation.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/main_tabs_page.dart';
import 'package:pidos/src/presentation/pages/home/home_page.dart';


class TabNavigatorRoutes {
  static const String home = '/';
  static const String mainTabs = '/main_tabs';
}

typedef void ContextNavigatorPage(BuildContext contextNavigatorPage);

class TabNavigator extends StatelessWidget {

  /// [variable importante]
  /// El navigator es el que hace posible que se peude pushear una ruta sin que 
  /// se destruya el bottom navigation
  final GlobalKey<NavigatorState> navigatorKey;

  final GlobalKey<ScaffoldState> globalScaffoldKey;

  ///
  /// tabItem
  ///
  final TabItem tabItem;

  ///
  /// [CALLBACK]
  /// hace un callback del contexto hacia el padre
  ///
  final ContextNavigatorPage contextNavigatorPage;

  TabNavigator({
    this.navigatorKey,
    this.globalScaffoldKey,
    this.tabItem,
    this.contextNavigatorPage
  });


  ///contiene las rutas 
  ///Routes: ['/']['/main_tabs']
  ///
  Map<String, WidgetBuilder> _routeBuilders( BuildContext context ) {
    return {
      TabNavigatorRoutes.home: (context) {
        contextNavigatorPage(context);
        return HomePage(globalScaffoldKey: globalScaffoldKey);
      },
      TabNavigatorRoutes.mainTabs: (context) {
        return MainTabsPage();
      }
    };
  }


  ///
  /// metodo Builder
  ///
  @override
  Widget build(BuildContext context) {
    print('callback(context); execute');
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.home,
      onGenerateRoute: (routeSettings) {
        final routeBuilders = _routeBuilders(context);
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}