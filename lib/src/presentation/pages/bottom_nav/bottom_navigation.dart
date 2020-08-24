import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';

// importante el orden
enum TabItem { 
  miMonedero, 
  movimientos, 
  comprar, 
  aliados,
  home 
}

/// titulo de los tabs
Map<TabItem, String> tabName = {
  TabItem.miMonedero: 'Mi Monedero',
  TabItem.movimientos: 'Movimientos',
  TabItem.comprar: 'Comprar',
  TabItem.aliados: 'Aliados',
};





class BottomNavigation extends StatelessWidget {

  /// Tab seleccionado
  final TabItem currentTab;

  /// funcion que se ejecuta cuando se da click en le tab
  final ValueChanged<TabItem> onPushTab;

  

  BottomNavigation({
    this.currentTab, 
    this.onPushTab
  });


  ///
  /// metodo build
  ///
  @override
  Widget build(BuildContext context) {
    final _perfil = PreferenciasUsuario().get(StorageKeys.perfil);
    return BottomAppBar(
      child: Container(
          height: 60.0,
          child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLeftIcon(tabItem: TabItem.miMonedero),
            _buildSeparator(),
            _buildMiddleIcon(tabItem: TabItem.movimientos),
            _buildSeparator(),
            ( _perfil=="CLIENTE" )
              ? _buildRightIconCliente(tabItem: TabItem.comprar)
              : _buildRightIconComerciante(tabItem: TabItem.aliados)
          ]
        ),
        )
    );
  }
  ///
  /// SEPARADOR
  ///
  _buildSeparator(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        color: Colors.black, width: 1
      )
    );
  }

  ///
  /// TAB IZQUIERDO
  ///
  _buildLeftIcon({TabItem tabItem}){
    return FlatButton(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0,10.0),
      onPressed: () => onPushTab(TabItem.values[0]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(
            image: AssetImage('assets/img/mi_monedero_icon_tab.png'),
            fit: BoxFit.cover,
            width: 20.0,
            color: _colorTabMatching(item: tabItem)
          ),
          Text(
            tabName[tabItem],
            style: TextStyle(
              fontSize: 13.0, 
              color: _colorTabMatching(item: tabItem)
            )
          )
        ],
      ),
    );
  }

  ///
  /// TAB DEL MEDIO
  ///
  _buildMiddleIcon({TabItem tabItem}){
    return FlatButton(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0,10.0),
      onPressed: () => onPushTab(TabItem.values[1]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(
            image: AssetImage('assets/img/movimientos_icon_tab.png'),
            fit: BoxFit.cover,
            width: 18.0,
            color: _colorTabMatching(item: tabItem)
          ),
          Text(
            tabName[tabItem],
            style: TextStyle(
              fontSize: 13.0, 
              color: _colorTabMatching(item: tabItem)
            )
          )
        ],
      ),
    );
  }


  ///
  /// TAB DERECHO
  /// perfil: cliente
  ///
  _buildRightIconCliente({TabItem tabItem}){
    return FlatButton(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 25.0,10.0),
      onPressed: () {
        onPushTab(TabItem.comprar);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(
            image: AssetImage('assets/img/comprar_icon_tab.png'),
            fit: BoxFit.cover,
            width: 22.0,
            color: _colorTabMatching(item: tabItem)
          ),
          Text(
            tabName[tabItem],
            style: TextStyle(
              fontSize: 13.0, 
              color: _colorTabMatching(item: tabItem)
            )
          )
        ],
      ),
    );
  }
  
  ///
  /// TAB DERECHO
  /// perfil: comerciante
  ///
  _buildRightIconComerciante({TabItem tabItem}){
    return FlatButton(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 25.0,10.0),
      onPressed: () => onPushTab(TabItem.aliados),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(
            image: AssetImage('assets/img/aliado_icon_tab.png'),
            fit: BoxFit.cover,
            width: 24.0,
            color: _colorTabMatching(item: tabItem)
          ),
          Text(
            tabName[tabItem],
            style: TextStyle(
              fontSize: 13.0, 
              color: _colorTabMatching(item: tabItem)
            )
          )
        ],
      ),
    );
  }

  


  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? Colors.black : Colors.grey;
  }





}


