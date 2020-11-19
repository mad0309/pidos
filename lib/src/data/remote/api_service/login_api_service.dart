import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/data/remote/api_result.dart';
import 'package:pidos/src/data/remote/network_utils.dart';
import 'package:pidos/src/domain/models/usuario.dart';

class LoginApiService {
  final NetworkUtil networkUtil;
  const LoginApiService(this.networkUtil);

  Future<String> login(Usuario user) async {
    try {
      final resp = await networkUtil.post(
          url: '/auth/login',
          data: {"email": user.nroCelular, "password": user.contrasena});
      // if (resp.statusCode < 200 || resp.statusCode >= 300) {
      //   throw NetworkException(resp.statusCode, resp.statusMessage);
      // }
      return resp.data['access_token'];
    } catch (err) {
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }

  Future<Usuario> retornaUsuario() async {
    try {
      final resp = await networkUtil.post(url: '/me', data: {});
      return Usuario.fromJson(resp.data);
    } catch (err) {
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }

  Future<Usuario> crearUsuario(Usuario usuario) async {
    try {
      final resp = await networkUtil.post(url: '/client/create', data: {
        "first_name": usuario.firstName,
        "last_name": usuario.lastName,
        "email": usuario.email,
        "document": usuario.document,
        "password": usuario.contrasena
      });
      resp.data['document'] = int.parse(resp.data['document']);
      return Usuario.fromJson(resp.data);
    } catch (err) {
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }

  Future<Usuario> crearEmpresa({
    String razonSocial,
    String nit,
    String correoEmpresa,
    String contrasena,
    String codigoDeVendedor,
    File rut,
    File camaraDeComercio,
    File cedula,
    File logo,
  }) async {
    try {
      String rutFileName = rut.path.split('/').last;
      String camaraDeComercioFileName = camaraDeComercio.path.split('/').last;
      String cedulaFileName = cedula.path.split('/').last;
      String logoFileName = logo.path.split('/').last;
      FormData formData = FormData.fromMap({
        "name": razonSocial,
        'document': nit,
        'email': correoEmpresa,
        'password': contrasena,
        'code': codigoDeVendedor,
        'file_rut':
            await MultipartFile.fromFile(rut.path, filename: rutFileName),
        'file_id': await MultipartFile.fromFile(camaraDeComercio.path,
            filename: camaraDeComercioFileName),
        'file_document':
            await MultipartFile.fromFile(cedula.path, filename: cedulaFileName),
        'logo': await MultipartFile.fromFile(logo.path, filename: logoFileName),
      });
      final resp =
          await networkUtil.post(url: '/company/create', data: formData);
      return Usuario.fromJson(resp.data);
    } catch (err) {
      throw err;
    }
  }

  Future<dynamic> enviarCodigo(Usuario usuario) async {
    try {
      final resp = await networkUtil.post(url: '/verify', data: {
        "id": usuario.id,
        "phone": usuario.nroCelular,
        "email": usuario.email,
      });
      return resp.data;
    } catch (err) {
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }

  Future<dynamic> checkCode(Usuario usuario, String code) async {
    try {
      final resp = await networkUtil.post(url: '/verify/checkcode', data: {
        "id": usuario.id,
        "email": usuario.email,
        "code": code,
      });
      return resp.data;
    } catch (err) {
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }

  Future<bool> recuprarContrasena(String email) async {
    try {
      final resp = await networkUtil
          .post(url: '/password/reset', data: {"email": email});
      if (resp.data['error'] != null && resp.data['error'] == false) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw err;
    }
  }
}
