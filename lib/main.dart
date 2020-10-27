import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pidos/device/size_config/size_config.dart';
import 'package:pidos/route_generator.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/data/remote/api_service/login_api_service.dart';
import 'package:pidos/src/data/remote/api_service/movimientos_api_service.dart';
import 'package:pidos/src/data/remote/api_service/transferencia_api_service.dart';
import 'package:pidos/src/data/remote/network_utils.dart';
import 'package:pidos/src/data/repository/movimientos_repository_impl.dart';
import 'package:pidos/src/data/repository/transferencia_repository_impl.dart';
import 'package:pidos/src/data/repository/usuario_repository_impl.dart';
import 'package:pidos/src/domain/repository/movimientos_repository.dart';
import 'package:pidos/src/domain/repository/transferencia_repository.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/blocs/login/login_bloc.dart';
import 'package:pidos/src/presentation/states/auth_state.dart';
import 'package:pidos/src/utils/colors.dart';
import 'package:pidos/src/utils/portraid_mode_mixin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Inicializa el SharedPreference
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  final networkUtil = NetworkUtil();
  await networkUtil.initNetwork();

  //intl lenguaje
  // Intl.defaultLocale = "es_AR";   //sets global,
  initializeDateFormatting();

  final UsuarioRepository usuarioRepository = UsuarioRepositoryImpl(
    loginApiService: LoginApiService(networkUtil),
    preferenciasUsuario: prefs,
  );
  final TransferenciaRepository transferenciaRepository = TransferenciaRepositoryImpl(
    transferenciaApiService: TransferenciaApiService(networkUtil),
    prefs: prefs
  );
  final MovimientosRepository movimientosRepository = MovimientosRepositoryImpl(
    movimientosApiService: MovimientosApiService(networkUtil),
  );

  runApp(
    Providers(
      providers: [
        Provider<UsuarioRepository>(value: usuarioRepository),
        Provider<TransferenciaRepository>(value: transferenciaRepository),
        Provider<MovimientosRepository>(value: movimientosRepository),
      ],
      child: BlocProvider(
        initBloc: () => LoginBloc(usuarioRepository: usuarioRepository),
        child: MyApp(),
        // child: BlocProvider(
        //     initBloc: () => ServiciosBloc(
        //         preferenciasUsuario: prefs,
        //         initActive: prefs.getBool(StorageKeys.pidCash) ?? false),
        //     child: MyApp()),
      )));
}

class MyApp extends StatelessWidget with PortraitModeMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pidos',
          theme: ThemeData(
              fontFamily: 'Lato',
              primaryColor: Color(0xFF2f046b),
              accentColor: Color(0xFFf2f2f2),
              unselectedWidgetColor: Color(0xFF2f046b)),
          initialRoute: '/init',
          // initialRoute: '/ingresa_codigo',
          routes: appRoutes,
        );
      });
    });
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getAuthState = Provider.of<UsuarioRepository>(context).getAuthState;
    return FutureBuilder<AuthenticationState>(
        future: getAuthState(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('[HOME] home [1] >> [waiting...]');
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: primaryColor,
              // child: Center(
              //   child: CircularProgressIndicator(
              //     valueColor: const AlwaysStoppedAnimation(Colors.white),
              //   ),
              // ),
            );
          }

          if (snapshot.hasError || snapshot.data is UnauthenticatedState) {
            print('[HOME] home [2] >> [NotAuthenticated]');
            return appRoutes['/login'](context);
          }

          if (snapshot.data is AuthenticatedState) {
            print('[HOME] home [3] >> [Authenticated]');
            final usuarioAuthenticated = snapshot.data.usuario;
            final _prefs = PreferenciasUsuario();
            final idNuevoUsuario = _prefs.get(StorageKeys.newAccountFirstLogin);
            if( idNuevoUsuario!=null && idNuevoUsuario!="" && num.parse(idNuevoUsuario) == usuarioAuthenticated.id ){
              // _prefs.remove(StorageKeys.newAccountFirstLogin);
              return appRoutes['/mi_cuenta'](context);
            }
            return appRoutes['/home'](context);
          }
          return Container(width: 0, height: 0);
        });
  }
}
