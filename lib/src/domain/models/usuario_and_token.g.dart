// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_and_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsuarioAndToken> _$usuarioAndTokenSerializer =
    new _$UsuarioAndTokenSerializer();

class _$UsuarioAndTokenSerializer
    implements StructuredSerializer<UsuarioAndToken> {
  @override
  final Iterable<Type> types = const [UsuarioAndToken, _$UsuarioAndToken];
  @override
  final String wireName = 'UsuarioAndToken';

  @override
  Iterable<Object> serialize(Serializers serializers, UsuarioAndToken object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'usuarios',
      serializers.serialize(object.usuarios,
          specifiedType: const FullType(Usuario)),
    ];

    return result;
  }

  @override
  UsuarioAndToken deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsuarioAndTokenBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'usuarios':
          result.usuarios.replace(serializers.deserialize(value,
              specifiedType: const FullType(Usuario)) as Usuario);
          break;
      }
    }

    return result.build();
  }
}

class _$UsuarioAndToken extends UsuarioAndToken {
  @override
  final String token;
  @override
  final Usuario usuarios;

  factory _$UsuarioAndToken([void Function(UsuarioAndTokenBuilder) updates]) =>
      (new UsuarioAndTokenBuilder()..update(updates)).build();

  _$UsuarioAndToken._({this.token, this.usuarios}) : super._() {
    if (token == null) {
      throw new BuiltValueNullFieldError('UsuarioAndToken', 'token');
    }
    if (usuarios == null) {
      throw new BuiltValueNullFieldError('UsuarioAndToken', 'usuarios');
    }
  }

  @override
  UsuarioAndToken rebuild(void Function(UsuarioAndTokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsuarioAndTokenBuilder toBuilder() =>
      new UsuarioAndTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsuarioAndToken &&
        token == other.token &&
        usuarios == other.usuarios;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, token.hashCode), usuarios.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UsuarioAndToken')
          ..add('token', token)
          ..add('usuarios', usuarios))
        .toString();
  }
}

class UsuarioAndTokenBuilder
    implements Builder<UsuarioAndToken, UsuarioAndTokenBuilder> {
  _$UsuarioAndToken _$v;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  UsuarioBuilder _usuarios;
  UsuarioBuilder get usuarios => _$this._usuarios ??= new UsuarioBuilder();
  set usuarios(UsuarioBuilder usuarios) => _$this._usuarios = usuarios;

  UsuarioAndTokenBuilder();

  UsuarioAndTokenBuilder get _$this {
    if (_$v != null) {
      _token = _$v.token;
      _usuarios = _$v.usuarios?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsuarioAndToken other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UsuarioAndToken;
  }

  @override
  void update(void Function(UsuarioAndTokenBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UsuarioAndToken build() {
    _$UsuarioAndToken _$result;
    try {
      _$result = _$v ??
          new _$UsuarioAndToken._(token: token, usuarios: usuarios.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'usuarios';
        usuarios.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UsuarioAndToken', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
