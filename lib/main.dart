import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:pidos/app/app.dart';
import 'package:pidos/device/size_config/size_config.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/blocs/provider/servicios_bloc.dart';
import 'package:pidos/src/presentation/pages/bottom_nav/tabs/aliados_tab_page.dart';
import 'package:pidos/src/presentation/pages/comprar_pidcash/compra_detalle_page.dart/compra_detalle_page.dart';
import 'package:pidos/src/presentation/pages/comprar_pidcash/comprar_pidcash_page.dart';
import 'package:pidos/src/presentation/pages/login/ingresa_codigo_page.dart';
import 'package:pidos/src/presentation/pages/login/login_page.dart';
import 'package:pidos/src/presentation/pages/login/registro_form_page.dart';
import 'package:pidos/src/presentation/pages/login/registro_page.dart';
import 'package:pidos/src/presentation/pages/settings/acerca_de_page.dart';
import 'package:pidos/src/presentation/pages/settings/ayuda_page.dart';
import 'package:pidos/src/presentation/pages/settings/mi_cuenta_page.dart';
import 'package:pidos/src/presentation/pages/settings/servicios_page.dart';
import 'package:pidos/src/presentation/pages/settings/trabaja_con_nosotros_page.dart';
import 'package:pidos/src/presentation/pages/transferir/transferir_page.dart';
import 'package:pidos/src/utils/portraid_mode_mixin.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Inicializa el SharedPreference
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(
    BlocProvider(
      initBloc: () => ServiciosBloc(
        preferenciasUsuario: prefs,
        initActive: prefs.getBool(StorageKeys.pidCash) ?? false
      ),
      child: MyApp()
    )
  );

}
 
class MyApp extends StatelessWidget with PortraitModeMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Pidos',
              theme: ThemeData(
                fontFamily: 'Lato',
                primaryColor:  Color(0xFF2f046b),
                accentColor: Color(0xFFf2f2f2),
                unselectedWidgetColor: Color(0xFF2f046b)
              ),
              // home: App(),
              initialRoute: '/login',
              routes: {
                '/home' :  ( BuildContext context ) => App(),
                '/login' : ( BuildContext context ) => LoginPage(),
                '/mi_cuenta' : ( BuildContext context ) => MiCuentapPage(),
                '/ayuda' : ( BuildContext context ) => AyudaPage(),
                '/acerca_de' : ( BuildContext context ) => AcercaDePage(),
                '/registro' : ( BuildContext context ) => RegistroPage(),
                '/ingresa_codigo' : ( BuildContext context ) => IngresaCodigoPage(),
                '/registro_form' : ( BuildContext context ) => RegistroFormPage(),
                '/transferencia' : ( BuildContext context ) {
                  final bool success = ModalRoute.of(context).settings.arguments;
                  return TransferirPage(
                    success: success ?? false,
                  );
                },
                '/servicios' : ( BuildContext context ) => ServiciosPage(),
                '/trabaja_con_nosotros' : ( BuildContext context ) => TrabajaConNosotrosPage(),
                '/comprar_pidcash' : ( BuildContext context ) => ComprarPidCashPage(),
                '/compra_detalle' : ( BuildContext context ) {
                  final bool success = ModalRoute.of(context).settings.arguments;
                  return CompraDetallePage(success: success);
                } 

              },
            );
          }
        );
      }
    );
  }
}