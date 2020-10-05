import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pidos/src/data/serializers.dart';

part 'usuario_entity.g.dart';


abstract class UsuarioEntity implements Built<UsuarioEntity, UsuarioEntityBuilder> {
  
  @nullable
  int get id;

  // @BuiltValueField(wireName: 'id_usuarios')
  @nullable
  String get name;

  @nullable
  int get document;

  @nullable
  double get pid;

  @nullable
  double get pidcash;

  @nullable
  String get firstName;

  // @BuiltValueField(serialize: false, compare: false)
  @nullable
  String get shortName;

  // @BuiltValueField(serialize: false, compare: false)
  @nullable
  String get role;



  UsuarioEntity._();
  factory UsuarioEntity([void Function(UsuarioEntityBuilder) updates]) = _$UsuarioEntity;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UsuarioEntity.serializer, this);
  }

  static UsuarioEntity fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UsuarioEntity.serializer, json);
  }

  static Serializer<UsuarioEntity> get serializer => _$usuarioEntitySerializer;
}