import 'package:flutter/material.dart';
import 'package:pidos/app/app.dart';
import 'package:pidos/main.dart';
import 'package:pidos/src/presentation/pages/comprar_pidcash/compra_detalle_page.dart/compra_detalle_page.dart';
import 'package:pidos/src/presentation/pages/comprar_pidcash/comprar_pidcash_page.dart';
import 'package:pidos/src/presentation/pages/login/ingresa_codigo_page.dart';
import 'package:pidos/src/presentation/pages/login/login_page.dart';
import 'package:pidos/src/presentation/pages/login/registro_form_page.dart';
import 'package:pidos/src/presentation/pages/login/registro_page.dart';
import 'package:pidos/src/presentation/pages/login/registro_webview_page.dart';
import 'package:pidos/src/presentation/pages/no_action_avaible_page.dart';
import 'package:pidos/src/presentation/pages/settings/acerca_de_page.dart';
import 'package:pidos/src/presentation/pages/settings/ayuda_page.dart';
import 'package:pidos/src/presentation/pages/settings/mi_cuenta_page.dart';
import 'package:pidos/src/presentation/pages/settings/servicios_page.dart';
import 'package:pidos/src/presentation/pages/settings/trabaja_con_nosotros_page.dart';
import 'package:pidos/src/presentation/pages/transferir/transferir_page.dart';

final appRoutes = <String, WidgetBuilder>{
  '/init': ( BuildContext context ) => Home(),
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
  },
  '/action_not_avaible' : ( BuildContext context ) {
    final String message = ModalRoute.of(context).settings.arguments;
    return NoActionAvaiblePage(text: message ?? '');
  },
  '/registro_webview': ( BuildContext context  ) => RegistroWebviewPage()
};