import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pidos/src/data/serializers.dart';

part 'usuario.g.dart';

abstract class Usuario implements Built<Usuario, UsuarioBuilder> {
  
  @nullable
  int get id;

  @nullable
  String get nroCelular;

  @nullable
  String get contrasena;

  @nullable
  String get name;

  @nullable
  // @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @nullable
  String get email;

  @nullable
  int get document;

  @nullable
  double get pid;

  @nullable
  double get pidcash;

  @nullable
  // @BuiltValueField(wireName: 'first_name')
  String get firstName;
  // @BuiltValueField(serialize: false, compare: false)
  @nullable
  String get shortName;

  // @BuiltValueField(serialize: false, compare: false)
  @nullable
  String get role;

  

  Usuario._();
  factory Usuario([void Function(UsuarioBuilder) updates]) = _$Usuario;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Usuario.serializer, this);
  }

  static Usuario fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Usuario.serializer, json);
  }

  static Serializer<Usuario> get serializer => _$usuarioSerializer;
}

//perfil usuario
enum RoleUsuario { 
  cliente, 
  comerciante
}
Map<RoleUsuario, String> roleUsuarioName = {
  RoleUsuario.cliente: 'client',
  RoleUsuario.comerciante: 'company'
};


//tipo registro
enum TipoRegistro { 
  persona, 
  empresa
}
Map<TipoRegistro, String> tipoRegistroName = {
  TipoRegistro.persona: 'Persona',
  TipoRegistro.empresa: 'Empresa Aliada'
};