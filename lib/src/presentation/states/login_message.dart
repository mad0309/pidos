import 'package:meta/meta.dart';
///
/// LOGIN MESSAGE
///

@immutable
abstract class LoginMessage {}

class LoginSuccessMessage implements LoginMessage {
  const LoginSuccessMessage();
}

class LoginErrorMessage implements LoginMessage {
  final String message;

  const LoginErrorMessage([this.message]);

  @override
  String toString() => 'LoginErrorMessage{message=$message}';
}

class InvalidInformationMessage implements LoginMessage {
  final String message;
  const InvalidInformationMessage([this.message]);
}

class LogoutSuccessMessage implements LoginMessage {
  const LogoutSuccessMessage();
}

class LogoutErrorMessage implements LoginMessage {
  final String message;

  const LogoutErrorMessage([this.message]);

  @override
  String toString() => 'LogoutErrorMessage{message=$message}';
}