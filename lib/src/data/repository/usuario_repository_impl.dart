import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/data/local/entities/usuario_entity.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/data/remote/api_result.dart';
import 'package:pidos/src/data/remote/api_service/login_api_service.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/states/login_message.dart';

import 'package:pidos/src/presentation/states/auth_state.dart';

part 'mappers.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {

  final PreferenciasUsuario preferenciasUsuario;
  final LoginApiService loginApiService;

  const UsuarioRepositoryImpl({
    this.preferenciasUsuario,
    this.loginApiService,
  });


  @override
  Future<AuthenticationState> getAuthState() async {
    try{
      final usuario = await preferenciasUsuario.getUsuarioFuture;
      final authenticationState = _Mappers.usuarioAndTokenEntityToDomainAuthState(usuario);
      return authenticationState;
    }catch(err){
      return UnauthenticatedState();
    }
  }
  

  @override
  Future<ApiResult<LoginMessage>> login(Usuario user) async {
    try{
      //get Token from Rest Service
      final String token = await loginApiService.login(user);
      //save token to sharedPreference
      await preferenciasUsuario.saveToken(token);
      //get Usuario from Rest Service
      final usuario = await loginApiService.retornaUsuario();
      //set shortname and only first name
      String shortName = '';
      String firstName = '';
      final nameParts = usuario.name.split(' ');
      firstName = nameParts[0];
      for(String part in nameParts ){
        if(shortName.length<2){
          final firstWord = part.substring(0,1);
          shortName = shortName + firstWord.toUpperCase();
        }else{
          break;
        }
      }
      //
      final usuarioWithShortName = usuario.rebuild((b) => b
        ..firstName = firstName
        ..shortName = shortName);
      await preferenciasUsuario.saveUsuario(_Mappers.usuarioDomainToUserEntity(usuarioWithShortName).build());
      return ApiResult.success(data: const LoginSuccessMessage());
    }catch(err){
      print('[USUARIO_REPOSITORY][retornUsuario][ERROR] => $err');
      await preferenciasUsuario.removeUsuarioAndToken();
      throw err;
    }
  }

  @override
  Future<bool> logut() async {
    try{
      await preferenciasUsuario.removeUsuarioAndToken();
      return true;
    }catch(err){
      print('[USUARIO_REPOSITORY][retornUsuario][ERROR] => $err');
      throw err;
    }
  }

  

}