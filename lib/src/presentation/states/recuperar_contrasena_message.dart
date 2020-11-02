import 'package:meta/meta.dart';
///
/// RECUPERAR CONTRASEÑA MESSAGE
///

@immutable
abstract class RecuperarContrasenaMessage {}

class RecuperarContrasenaSuccessMessage implements RecuperarContrasenaMessage {
  const RecuperarContrasenaSuccessMessage();
}

class RecuperarContrasenaErrorMessage implements RecuperarContrasenaMessage {
  final String message;

  const RecuperarContrasenaErrorMessage([this.message]);

  @override
  String toString() => 'RecuperarContrasenaErrorMessage{message=$message}';
}