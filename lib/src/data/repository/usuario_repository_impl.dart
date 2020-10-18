import 'package:pidos/src/data/local/entities/usuario_entity.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/data/remote/api_result.dart';
import 'package:pidos/src/data/remote/api_service/login_api_service.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/states/login_message.dart';

import 'package:pidos/src/presentation/states/auth_state.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';

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

  @override
  Future<ApiResult<RegistroMessage>> registroUsuario(Usuario usuario) async {
    try{
       final resp = await loginApiService.crearUsuario(usuario);
       if( resp.id>0 ){ 
         return ApiResult.success(data: RegistroSuccessMessage(resp));
       }else{
         throw 'Ocurrio un error durante la transaccion';
       }
    }catch(err){
      print('[USUARIO_REPOSITORY][registroUsuario][ERROR] => $err');
      throw err;
    }
  }

  @override
  Future<ApiResult<RegistroMessage>> enviarCodigo(Usuario usuario) async {
    try{
       final resp = await loginApiService.enviarCodigo(usuario);
       if( resp['pending'] == true ){ 
         return ApiResult.success(data: EnviarCodigoSuccessMessage(usuario));
       }else{
         throw 'Ocurrio un error durante la transaccion';
       }
    }catch(err){
      print('[USUARIO_REPOSITORY][registroUsuario][ERROR] => $err');
      throw err;
    }
  }
  @override
  Future<ApiResult<RegistroMessage>> checkCodigoInsertado(Usuario usuario, String code) async {
    try{
       final resp = await loginApiService.checkCode(usuario, code);
       if( resp['approved'] == true ){
         preferenciasUsuario.set(StorageKeys.newAccountFirstLogin, usuario.id.toString());
         return ApiResult.success(data: const CodigoIngresadoSuccessMessage());
       }else{
         throw 'Codigo Invalido';
       }
    }catch(err){
      print('[USUARIO_REPOSITORY][registroUsuario][ERROR] => $err');
      throw err;
    }
  }
  @override
  Stream<Usuario> retornasSaldo() async* {
    try{
       final usuario = await loginApiService.retornaUsuario();
       yield usuario;
    }catch(err){
      print('[USUARIO_REPOSITORY][retornasSaldo][ERROR] => $err');
      throw err;
    }
  }

  

}