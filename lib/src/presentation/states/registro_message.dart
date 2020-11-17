import 'package:meta/meta.dart';
import 'package:pidos/src/domain/models/usuario.dart';
///
/// REGISTRO MESSAGE
///

@immutable
abstract class RegistroMessage {}

class RegistroSuccessMessage implements RegistroMessage {
  final Usuario usuario;
  const RegistroSuccessMessage([this.usuario]);
  
  @override
  String toString() => 'RegistroSuccessMessage{usuario=$usuario}';
}

class RegistroErrorMessage implements RegistroMessage {
  final String message;

  const RegistroErrorMessage([this.message]);

  @override
  String toString() => 'RegistroErrorMessage{message=$message}';
}
class RegistroEmpresaSuccessMessage implements RegistroMessage {
  // final Usuario usuario;
  const RegistroEmpresaSuccessMessage();
}

class RegistroEmpresaErrorMessage implements RegistroMessage {
  final String message;

  const RegistroEmpresaErrorMessage([this.message]);

  @override
  String toString() => 'RegistroEmpresaErrorMessage{message=$message}';
}

class EnviarCodigoSuccessMessage implements RegistroMessage {
  final Usuario usuario;
  const EnviarCodigoSuccessMessage([this.usuario]);
  
}

class EnviarCodigoErrorMessage implements RegistroMessage {
  final String message;

  const EnviarCodigoErrorMessage([this.message]);

  @override
  String toString() => 'EnviarCodigoErrorMessage{message=$message}';
}

class CodigoIngresadoSuccessMessage implements RegistroMessage {

  const CodigoIngresadoSuccessMessage();
  
}

class CodigoIngresadoErrorMessage implements RegistroMessage {
  final String message;

  const CodigoIngresadoErrorMessage([this.message]);

  @override
  String toString() => 'CodigoIngresadoErrorMessage{message=$message}';
}
