import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pidos/src/data/serializers.dart';
import 'package:pidos/src/domain/models/usuario.dart';

part 'usuario_and_token.g.dart';

abstract class UsuarioAndToken implements Built<UsuarioAndToken, UsuarioAndTokenBuilder> {
  
  String get token;
  Usuario get usuarios;

  UsuarioAndToken._();
  factory UsuarioAndToken([void Function(UsuarioAndTokenBuilder) updates]) = _$UsuarioAndToken;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UsuarioAndToken.serializer, this);
  }

  static UsuarioAndToken fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UsuarioAndToken.serializer, json);
  }

  static Serializer<UsuarioAndToken> get serializer => _$usuarioAndTokenSerializer;
}