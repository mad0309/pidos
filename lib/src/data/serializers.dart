import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:pidos/src/data/local/entities/usuario_entity.dart';
import 'package:pidos/src/domain/models/usuario.dart';

part 'serializers.g.dart';

@SerializersFor([
  UsuarioEntity,

  Usuario
])
final Serializers _serializers = _$_serializers;
final serializers = (_serializers.toBuilder()
      ..add(Iso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();