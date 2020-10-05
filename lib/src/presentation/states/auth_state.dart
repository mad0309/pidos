import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';
import 'package:pidos/src/domain/models/usuario.dart';

part 'auth_state.g.dart';


@immutable
abstract class AuthenticationState {
  const AuthenticationState();

  Usuario get usuario;
}



/// AuthenticatedState
abstract class AuthenticatedState implements Built<AuthenticatedState, AuthenticatedStateBuilder>, AuthenticationState {
  
  @override
  Usuario get usuario;

  AuthenticatedState._();
  factory AuthenticatedState([void Function(AuthenticatedStateBuilder) updates]) = _$AuthenticatedState;
}



/// UnauthenticatedState
abstract class UnauthenticatedState implements Built<UnauthenticatedState, UnauthenticatedStateBuilder>, AuthenticationState  {
  
  @override
  Usuario get usuario => null;

  UnauthenticatedState._();
  factory UnauthenticatedState([void Function(UnauthenticatedStateBuilder) updates]) = _$UnauthenticatedState;
}
