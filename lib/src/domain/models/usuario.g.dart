// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Usuario> _$usuarioSerializer = new _$UsuarioSerializer();

class _$UsuarioSerializer implements StructuredSerializer<Usuario> {
  @override
  final Iterable<Type> types = const [Usuario, _$Usuario];
  @override
  final String wireName = 'Usuario';

  @override
  Iterable<Object> serialize(Serializers serializers, Usuario object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.nroCelular != null) {
      result
        ..add('nroCelular')
        ..add(serializers.serialize(object.nroCelular,
            specifiedType: const FullType(String)));
    }
    if (object.contrasena != null) {
      result
        ..add('contrasena')
        ..add(serializers.serialize(object.contrasena,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.lastName != null) {
      result
        ..add('lastName')
        ..add(serializers.serialize(object.lastName,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.document != null) {
      result
        ..add('document')
        ..add(serializers.serialize(object.document,
            specifiedType: const FullType(int)));
    }
    if (object.pid != null) {
      result
        ..add('pid')
        ..add(serializers.serialize(object.pid,
            specifiedType: const FullType(double)));
    }
    if (object.pidcash != null) {
      result
        ..add('pidcash')
        ..add(serializers.serialize(object.pidcash,
            specifiedType: const FullType(double)));
    }
    if (object.firstName != null) {
      result
        ..add('firstName')
        ..add(serializers.serialize(object.firstName,
            specifiedType: const FullType(String)));
    }
    if (object.shortName != null) {
      result
        ..add('shortName')
        ..add(serializers.serialize(object.shortName,
            specifiedType: const FullType(String)));
    }
    if (object.role != null) {
      result
        ..add('role')
        ..add(serializers.serialize(object.role,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Usuario deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsuarioBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nroCelular':
          result.nroCelular = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contrasena':
          result.contrasena = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'document':
          result.document = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'pid':
          result.pid = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'pidcash':
          result.pidcash = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shortName':
          result.shortName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'role':
          result.role = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Usuario extends Usuario {
  @override
  final int id;
  @override
  final String nroCelular;
  @override
  final String contrasena;
  @override
  final String name;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final int document;
  @override
  final double pid;
  @override
  final double pidcash;
  @override
  final String firstName;
  @override
  final String shortName;
  @override
  final String role;

  factory _$Usuario([void Function(UsuarioBuilder) updates]) =>
      (new UsuarioBuilder()..update(updates)).build();

  _$Usuario._(
      {this.id,
      this.nroCelular,
      this.contrasena,
      this.name,
      this.lastName,
      this.email,
      this.document,
      this.pid,
      this.pidcash,
      this.firstName,
      this.shortName,
      this.role})
      : super._();

  @override
  Usuario rebuild(void Function(UsuarioBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsuarioBuilder toBuilder() => new UsuarioBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Usuario &&
        id == other.id &&
        nroCelular == other.nroCelular &&
        contrasena == other.contrasena &&
        name == other.name &&
        lastName == other.lastName &&
        email == other.email &&
        document == other.document &&
        pid == other.pid &&
        pidcash == other.pidcash &&
        firstName == other.firstName &&
        shortName == other.shortName &&
        role == other.role;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, id.hashCode),
                                                nroCelular.hashCode),
                                            contrasena.hashCode),
                                        name.hashCode),
                                    lastName.hashCode),
                                email.hashCode),
                            document.hashCode),
                        pid.hashCode),
                    pidcash.hashCode),
                firstName.hashCode),
            shortName.hashCode),
        role.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Usuario')
          ..add('id', id)
          ..add('nroCelular', nroCelular)
          ..add('contrasena', contrasena)
          ..add('name', name)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('document', document)
          ..add('pid', pid)
          ..add('pidcash', pidcash)
          ..add('firstName', firstName)
          ..add('shortName', shortName)
          ..add('role', role))
        .toString();
  }
}

class UsuarioBuilder implements Builder<Usuario, UsuarioBuilder> {
  _$Usuario _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _nroCelular;
  String get nroCelular => _$this._nroCelular;
  set nroCelular(String nroCelular) => _$this._nroCelular = nroCelular;

  String _contrasena;
  String get contrasena => _$this._contrasena;
  set contrasena(String contrasena) => _$this._contrasena = contrasena;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  int _document;
  int get document => _$this._document;
  set document(int document) => _$this._document = document;

  double _pid;
  double get pid => _$this._pid;
  set pid(double pid) => _$this._pid = pid;

  double _pidcash;
  double get pidcash => _$this._pidcash;
  set pidcash(double pidcash) => _$this._pidcash = pidcash;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _shortName;
  String get shortName => _$this._shortName;
  set shortName(String shortName) => _$this._shortName = shortName;

  String _role;
  String get role => _$this._role;
  set role(String role) => _$this._role = role;

  UsuarioBuilder();

  UsuarioBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _nroCelular = _$v.nroCelular;
      _contrasena = _$v.contrasena;
      _name = _$v.name;
      _lastName = _$v.lastName;
      _email = _$v.email;
      _document = _$v.document;
      _pid = _$v.pid;
      _pidcash = _$v.pidcash;
      _firstName = _$v.firstName;
      _shortName = _$v.shortName;
      _role = _$v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Usuario other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Usuario;
  }

  @override
  void update(void Function(UsuarioBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Usuario build() {
    final _$result = _$v ??
        new _$Usuario._(
            id: id,
            nroCelular: nroCelular,
            contrasena: contrasena,
            name: name,
            lastName: lastName,
            email: email,
            document: document,
            pid: pid,
            pidcash: pidcash,
            firstName: firstName,
            shortName: shortName,
            role: role);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
