

import 'dart:async';

import 'package:pidos/src/data/constanst.dart';


class Validators {

  final validatorNombre = StreamTransformer<String, bool>.fromHandlers(
    handleData:(nombre, sink){
      if( nombre!=null ){
        if(nombre.length >= 2){
          sink.add(true);
        }else{
          sink.add(false);
        }
      }else{
        sink.add(null);
      }
    }
  );
  final validatorApellido = StreamTransformer<String, bool>.fromHandlers(
    handleData:(apellido, sink){
      if( apellido!=null ){
        if(apellido.length >= 2){
          sink.add(true);
        }else{
          sink.add(false);
        }
      }else{
        sink.add(null);
      }
    }
  );
  final validatorEmail = StreamTransformer<String, bool>.fromHandlers(
    handleData:(email, sink){
      if( email!=null ){
        RegExp regExp = new RegExp(pattern);
        if(regExp.hasMatch(email)&& email.length >=1){
          sink.add(true);
        }else{
          sink.add(false);
        }
      }else{
        sink.add(null);
      }
    }
  );
  final validatorNroDoucumento = StreamTransformer<String, bool>.fromHandlers(
    handleData:(documento, sink){
      if( documento!=null ){
        if(documento.length <=10){
          sink.add(true);
        }else{
          sink.add(false);
        }
      }else{
        sink.add(null);
      }
    }
  );
  final validatorContrasena = StreamTransformer<String, bool>.fromHandlers(
    handleData:(contrasena, sink){
      if( contrasena!=null ){
        if(contrasena.length > 0){
          sink.add(true);
        }else{
          sink.add(false);
        }
      }else{
        sink.add(null);
      }
    }
  );
  final validatorCodigoVendedor = StreamTransformer<String, bool>.fromHandlers(
    handleData:(cod, sink){
      if( cod!=null ){
        if(cod.length > 0){
          sink.add(true);
        }else{
          sink.add(false);
        }
      }else{
        sink.add(null);
      }
    }
  );
  final validatorNit = StreamTransformer<String, bool>.fromHandlers(
    handleData:(nit, sink){
      if( nit!=null ){
        if(nit.length <=13){
          sink.add(true);
        }else{
          sink.add(false);
        }
      }else{
        sink.add(null);
      }
    }
  );
  


    




  


}