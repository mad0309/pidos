
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/data/remote/api_result.dart';
import 'package:pidos/src/data/remote/api_service/transferencia_api_service.dart';
import 'package:pidos/src/domain/repository/transferencia_repository.dart';
import 'package:pidos/src/presentation/states/transferencia_message.dart';

class TransferenciaRepositoryImpl implements TransferenciaRepository {


  final TransferenciaApiService transferenciaApiService;
  final PreferenciasUsuario prefs;

  const TransferenciaRepositoryImpl({
    this.transferenciaApiService,
    this.prefs
  });

  @override
  Future<ApiResult<TransferenciaMessage>> tranferirPidPuntos({
    int pid,
    String documentDestination
  }) async {
    try{
      final usuario = prefs.getUsuario();
      final currentPids = usuario.pid;
      final resp = await transferenciaApiService.trasferirPidPuntos(
        pid: pid,
        documentDestination: documentDestination
      );
      if( resp['success'] == true ){
        final nuevaCantidadDePids = currentPids - pid;
        //TODO: CAMBIAR DOUBLE TO INT B.PID
        final nuevousuario = usuario.rebuild((b) => b.pid = nuevaCantidadDePids.toDouble() );
        await prefs.saveUsuarioDomain(nuevousuario);
        return ApiResult.success(data: const TransferenciaSuccessMessage());
      }else{
        throw 'Ocurrio un error durante la transaccion';
      }
      
    }catch(err){
      print('[TRANSFERENCIA_REPOSITORY_IMPL][tranferirPidPuntos] ERROR => $err');
      throw err;
    }
  }

  @override
  Future<ApiResult<TransferenciaMessage>> tranferirPidCash({
    int pidCash,
    String documentDestination
  }) async {
    try{
      final usuario = prefs.getUsuario();
      final currentPidsCash = usuario.pidcash;
      final resp = await  transferenciaApiService.trasferirPidCash(
        pidCash: pidCash,
        documentDestination: documentDestination
      );
      if( resp['success'] == true ){
        final nuevaCantidadDePidsCash = currentPidsCash - pidCash;
        //TODO: CAMBIAR DOUBLE TO INT B.PID
        final nuevousuario = usuario.rebuild((b) => b.pidcash = nuevaCantidadDePidsCash.toDouble() );
        await prefs.saveUsuarioDomain(nuevousuario);
        return ApiResult.success(data: const TransferenciaSuccessMessage());
      }else{
        throw 'Ocurrio un error durante la transaccion';
      }
    }catch(err){
      print('[TRANSFERENCIA_REPOSITORY_IMPL][tranferirPidPuntos] ERROR => $err');
      throw err;
    }
  }

}