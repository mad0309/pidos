import 'package:meta/meta.dart';
///
/// TRANSFERENCIA MESSAGE
///

@immutable
abstract class TransferenciaMessage {}

class TransferenciaSuccessMessage implements TransferenciaMessage {
  const TransferenciaSuccessMessage();
}

class TransferenciaErrorMessage implements TransferenciaMessage {
  final String message;

  const TransferenciaErrorMessage([this.message]);

  @override
  String toString() => 'TransferenciaErrorMessage{message=$message}';
}