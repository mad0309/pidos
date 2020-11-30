import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pidos/app/global_singleton.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/domain/models/movimientos.dart';
import 'package:pidos/src/presentation/blocs/login/login_bloc.dart';
import 'package:pidos/src/presentation/blocs/movimientos/movimientos_bloc.dart';
import 'package:pidos/src/presentation/states/result_state.dart';
import 'package:pidos/src/presentation/widgets/bottom_nav_widgets/movimientos_widget.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/utils/colors.dart';
import 'package:pidos/src/utils/extensions.dart';

class MovimientosTabPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalScaffoldKey;

  MovimientosTabPage({this.globalScaffoldKey});

  @override
  _MovimientosTabPageState createState() => _MovimientosTabPageState();
}

class _MovimientosTabPageState extends State<MovimientosTabPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _shortName;
  int movimientosLenght = 0;

  @override
  void initState() {
    final usuario = PreferenciasUsuario().getUsuario();
    _shortName = usuario.shortName;
    super.initState();
  }

  // Metodo para mostrar un snackbar
  void mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 3000),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  ///
  /// METODO BUILD
  ///
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _movimientosBloc = BlocProvider.of<MovimientosBloc>(context);
    final _prefs = PreferenciasUsuario();
    final idUsuario = _prefs.getUsuario().id;
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: cyanColor),
          onPressed: () => Navigator.of(context).pop(),
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
              collapseMode:
                  CollapseMode.none, //give effect if there was an image
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
                    child: Text(
                      "Tus movimientos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Raleway', fontWeight: FontWeight.w600),
                    ),
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
          StreamBuilder<ResultState<List<Movimientos>>>(
            stream: _movimientosBloc.listarMovimientos$,
            initialData: _movimientosBloc.listarMovimientos$.value,
            builder: (context, snapshot) {
              final state = snapshot.data;
              return state.maybeWhen(
                  loading: () => loading(),
                  error: (e) {
                    e.maybeWhen(
                        unauthorizedRequest: () {
                          final contextApp = GlobalSingleton().contextApp;
                          BlocProvider.of<LoginBloc>(context).logout();
                          // Navigator.of(contextApp).pushReplacementNamed('/login');
                          Navigator.of(contextApp).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                        },
                        noInternetConnection: () => mostrarSnackBar('No hay conexion a internet'),
                        orElse: () => mostrarSnackBar('Ocurrio un error intentelo más tarde'));
                    return Container();
                  },
                  data: (lsMovimientos) {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      if (lsMovimientos.length == 0) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 80.0),
                              Image(
                                color: Colors.black.withOpacity(0.6),
                                image: AssetImage(
                                    'assets/img/movimientos_icon_tab.png'),
                                fit: BoxFit.cover,
                                width: 50.0,
                              ),
                              SizedBox(height: 20.0),
                              Text('Aún no cuentas con movimientos',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black.withOpacity(0.6)))
                            ],
                          ),
                        );
                      } else {
                        final movimiento = lsMovimientos[index];
                        final dia = DateFormat('dd', 'es')
                            .format(movimiento.createdAt ?? DateTime.now());
                        final mes = DateFormat('MMMM', 'es')
                            .format(movimiento.createdAt ?? DateTime.now());
                        final ano = DateFormat('y', 'es')
                            .format(movimiento.createdAt ?? DateTime.now());
                        final fechaDeMovimiento =
                            '$dia/${mes.capitalize()}/$ano';
                        final idGenrador = movimiento.generator.id;
                        bool isEnviado = false;
                        if (idGenrador == idUsuario) {
                          isEnviado = true;
                        }
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: MovimientosWidget(
                              isEnviado: isEnviado,
                              fechaMovimiento: fechaDeMovimiento ?? '',
                              pids: movimiento.amount?.toString() ?? '0',
                              pidId:
                                  movimiento.generator?.document.toString() ??
                                      '0',
                              comerciante:
                                  movimiento.receptor?.name ?? '', //receptor
                              comercianteId:
                                  movimiento.receptor?.document.toString() ??
                                      ''),
                        );
                      }
                    },
                            childCount: (lsMovimientos.length == 0)
                                ? 1
                                : lsMovimientos.length));
                  },
                  orElse: () => Container());
            },
          ),
        ],
      ),
    );
  }

  Widget loading() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80.0),
            SpinKitThreeBounce(size: 25.0, color: primaryColor)
          ],
        ),
      );
    }, childCount: 1));
  }
}
