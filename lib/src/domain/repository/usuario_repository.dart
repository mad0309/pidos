

import 'dart:io';

import 'package:pidos/src/data/remote/api_result.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/states/auth_state.dart';
import 'package:pidos/src/presentation/states/login_message.dart';
import 'package:pidos/src/presentation/states/recuperar_contrasena_message.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';

abstract class UsuarioRepository {

  Future<AuthenticationState> getAuthState();
  Future<ApiResult<LoginMessage>> login(Usuario user);
  Future<bool> logut();
  Future<ApiResult<RegistroMessage>> registroUsuario(Usuario usuario);
  Future<ApiResult<RegistroMessage>> registroEmpresa({
    String razonSocial,
    String nit,
    String correoEmpresa,
    String contrasena,
    File rut,
    File camaraDeComercio,
    File cedula,
    File logo,
  });
  Future<ApiResult<RegistroMessage>> enviarCodigo(Usuario usuario);
  Future<ApiResult<RegistroMessage>> checkCodigoInsertado(Usuario usuario, String code);
  Stream<Usuario> retornasSaldo();
  Future<ApiResult<RecuperarContrasenaMessage>> recuperarContrasena(String  email);

}