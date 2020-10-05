

import 'package:pidos/src/data/remote/api_result.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/states/auth_state.dart';
import 'package:pidos/src/presentation/states/login_message.dart';

abstract class UsuarioRepository {

  Future<AuthenticationState> getAuthState();
  Future<ApiResult<LoginMessage>> login(Usuario user);
  Future<bool> logut();

}