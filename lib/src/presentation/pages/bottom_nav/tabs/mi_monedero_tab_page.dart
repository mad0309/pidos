import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:pidos/app/global_singleton.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/blocs/mi_monedero/mi_monedero_bloc.dart';
import 'package:pidos/src/presentation/blocs/servicios_bloc.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/dialogs/transferir_dialog.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/circle_color.dart';
import 'package:pidos/src/utils/colors.dart';
import 'package:pidos/src/utils/extensions.dart';

class MiMonederoTabPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalScaffoldKey;

  MiMonederoTabPage({this.globalScaffoldKey});

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
  // bool _pidsActive = false;

  PageController _pageController = PageController(initialPage: 0);
  double _currentIndexPage;

  @override
  void initState() {
    _currentIndexPage = 0.0;
    _pageController.addListener(() {
      setState(() {
        _currentIndexPage = _pageController.page;
      });
    });

    /// ======= get data from local storage ===== ///
    final _sharedPrefs = PreferenciasUsuario();
    final usuario = _sharedPrefs.getUsuario();
    _username = usuario.firstName;
    _pidNumber = usuario.document.toString();
    _perfil = usuario.role;
    _shortName = usuario.shortName;
    // _pidsActive = _sharedPrefs.getBool(StorageKeys.pidCash);

    /// ======= =========================== ===== ///
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  ///
  /// Seccion principal
  ///
  Widget _bodySection() {
    final dia = DateFormat('dd', 'es').format(DateTime.now());
    final mes = DateFormat('MMMM', 'es').format(DateTime.now());
    final ano = DateFormat('y', 'es').format(DateTime.now());
    final fechaActual = '$dia de ${mes.capitalize()} del $ano';
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: EdgeInsets.symmetric(
                        vertical: screenSizeHeight * 0.00844), //vertical: 5.0
                    child: Text(
                      fechaActual,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    (_perfil != roleUsuarioName[RoleUsuario.cliente])
                        ? 'PID - $_pidNumber'
                        : 'Pidos ID: PID - $_pidNumber',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  (_perfil != roleUsuarioName[RoleUsuario.cliente])
                      ? _cardPidsDisponibles()
                      : StreamBuilder<bool>(
                          stream: BlocProvider.of<ServiciosBloc>(context)
                              .isPidChasActive$,
                          initialData: BlocProvider.of<ServiciosBloc>(context)
                              .isPidChasActive$
                              .value,
                          builder: (context, snapshot) {
                            final isActive = snapshot.data ?? false;
                            if (isActive) {
                              return Column(children: [
                                _carrouselCards(),
                                _dotsIndicator()
                              ]);
                            } else {
                              return _cardPidsDisponibles();
                            }
                          })
                ],
              ),
              (_perfil != roleUsuarioName[RoleUsuario.cliente])
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: _mensajeInfoPuntos(),
                        ),
                        Padding(
                          // padding: EdgeInsets.only(bottom: 5.0, top: 0.08 * screenSizeHeight), //top: 50.0
                          padding: EdgeInsets.only(
                              bottom: 5.0,
                              top: 0.05 * screenSizeHeight), //top: 50.0
                          child: _transferirButton(),
                        ),
                      ],
                    )
                  : StreamBuilder<bool>(
                      stream: BlocProvider.of<ServiciosBloc>(context)
                          .isPidChasActive$,
                      initialData: BlocProvider.of<ServiciosBloc>(context)
                          .isPidChasActive$
                          .value,
                      builder: (context, snapshot) {
                        final isActive = snapshot.data ?? false;
                        if (isActive) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: _mensajeInfoPuntos(),
                              ),
                              _transferirButton(),
                              _comprarButton(context),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: _mensajeInfoPuntos(),
                              ),
                              Padding(
                                // padding: EdgeInsets.only(bottom: 5.0, top: 0.08 * screenSizeHeight), // top: 50.0
                                padding: EdgeInsets.only(
                                    bottom: 5.0,
                                    top: 0.05 * screenSizeHeight), // top: 30.0
                                child: _transferirButton(),
                              ),
                            ],
                          );
                        }
                      }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mensajeInfoPuntos() {
    return Padding(
      padding: EdgeInsets.only(
          left: screenSizeWidth * 0.111, right: screenSizeWidth * 0.111),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 30.0, color: Colors.red),
          SizedBox(width: 5.0),
          Expanded(
            child: Text(
              'Tus puntos pueden tardar un poco enverse reflejados aquí',
              style: TextStyle(color: Colors.black, fontSize: 13.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _carrouselCards() {
    return Container(
      height: screenSizeHeight * 0.372, //height: 200.0,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [_cardPidsDisponibles(), _cardPidCashDisponibles()],
      ),
    );
  }

  ///
  /// Card de pids disponibles
  ///
  Widget _cardPidsDisponibles() {
    final _miMonederoBloc = BlocProvider.of<MiMonederoBloc>(context);
    return Padding(
      padding: EdgeInsets.only(
          top: screenSizeHeight * 0.0337,
          right: screenSizeWidth * 0.111,
          left: screenSizeWidth * 0.111), //top: 20.0, right: 40.0, left: 40.0
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenSizeWidth * 0.097), //horizontal: 35.0
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
                    spreadRadius: 0.5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Tienes',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.white)), //fontSize: 20.0
              Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconPidDisponible(),
                  SizedBox(width: screenSizeWidth * 0.022), //width: 8.0
                  StreamBuilder<double>(
                      stream: _miMonederoBloc.pidosDisponibles$,
                      initialData: _miMonederoBloc.pidosDisponibles$.value,
                      builder: (context, snapshot) {
                        final pid = snapshot.data ?? 0.0;
                        return Flexible(
                          child: FittedBox(
                            child: Text(pid.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: screenSizeHeight *
                                        0.0591, //fontSize: 35.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ),
                        );
                      }),
                ],
              ),
              Text('Pidos disponibles',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.white)), //fontSize: 20.0
            ],
          )),
    );
  }

  Widget _iconPidDisponible() {
    return CircleWidget(
      width: screenSizeWidth * 0.111, //width: 40.0,
      height: screenSizeHeight * 0.067, //height: 40.0
      color: Colors.transparent,
      borderColor: Colors.white,
      borderWidth: 2.5,
      widget: Center(
        child: CircleWidget(
            width: screenSizeWidth * 0.0416, //width: 15.0,
            height: screenSizeHeight * 0.0253, //height: 15.0,
            color: Colors.white),
      ),
    );
  }

  ///
  /// Card de pidsCash disponibles
  ///
  Widget _cardPidCashDisponibles() {
    final _miMonederoBloc = BlocProvider.of<MiMonederoBloc>(context);
    return Padding(
      padding: EdgeInsets.only(
          top: screenSizeHeight * 0.0337,
          right: screenSizeWidth * 0.111,
          left: screenSizeWidth * 0.111), //top: 20.0, right: 40.0, left: 40.0
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenSizeWidth * 0.097), //horizontal: 35.0
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
                    spreadRadius: 0.5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Tienes',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.white)), //fontSize: 20.0
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.monetization_on,
                      color: Colors.white,
                      size: screenSizeHeight * 0.0675), //size: 40.0
                  SizedBox(width: screenSizeWidth * 0.022), //width: 8.0
                  StreamBuilder<double>(
                      stream: _miMonederoBloc.pidoscashDisponibles$,
                      initialData: _miMonederoBloc.pidoscashDisponibles$.value,
                      builder: (context, snapshot) {
                        final pidcash = snapshot.data ?? 0.0;
                        return Text(pidcash.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: screenSizeHeight *
                                    0.0591, //fontSize: 35.0,,
                                fontWeight: FontWeight.w700,
                                color: Colors.white));
                      }),
                ],
              ),
              Text('Pid Cash',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.white)), //fontSize: 20.0
              Text('disponibles',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.white)), //fontSize: 20.0
            ],
          )),
    );
  }

  Widget _dotsIndicator() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: DotsIndicator(
          dotsCount: 2,
          position: _currentIndexPage,
          decorator: DotsDecorator(
            color: Color(0xFF999999), // Inactive color
            activeColor: primaryColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
          ),
          onTap: (position) {
            setState(() {
              _pageController.animateToPage(position.toInt(),
                  duration: Duration(milliseconds: 400), curve: Curves.ease);
            });
          },
        ));
  }

  ///
  /// Boton de transferencia
  ///
  Widget _transferirButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSizeHeight * 0.00844,
          horizontal:
              screenSizeWidth * 0.0833), //vertical: 5.0, horizontal: 30.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenSizeHeight * 0.0253), //vertical: 15.0
              child: Text('Transferir',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0)),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: primaryColor,
            elevation: 0.0,
            textColor: Colors.white,
            onPressed: () => transferirDialog(context: context)),
      ),
    );
  }

  ///
  /// Boton de comprar
  ///
  Widget _comprarButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSizeHeight * 0.00844,
          horizontal:
              screenSizeWidth * 0.125), //vertical: 5.0, horizontal: 30.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenSizeHeight * 0.0168), //vertical: 15.0
              child: Text('Comprar',
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0)),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: primaryColor,
            elevation: 0.0,
            textColor: Color(0xff01F4FE),
            onPressed: () {
              final contextApp = GlobalSingleton().contextApp;
              Navigator.of(contextApp).pushNamed('/comprar_pidcash');
            }),
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
            onPressed: () => Navigator.of(context).pop()),
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
                )),
          )
        ],
      ),
      // endDrawer: DrawerNav(),
      body: Stack(
        children: [
          Container(
            color: primaryColor,
            width: double.infinity,
            height: (screenSizeHeight > 600)
                ? screenSizeHeight * 0.48
                : screenSizeHeight * 0.58,
          ),
          _bodySection(),
        ],
      ),
    );
  }
}
