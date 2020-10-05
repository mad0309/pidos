// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsuarioEntity> _$usuarioEntitySerializer =
    new _$UsuarioEntitySerializer();

class _$UsuarioEntitySerializer implements StructuredSerializer<UsuarioEntity> {
  @override
  final Iterable<Type> types = const [UsuarioEntity, _$UsuarioEntity];
  @override
  final String wireName = 'UsuarioEntity';

  @override
  Iterable<Object> serialize(Serializers serializers, UsuarioEntity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
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
  UsuarioEntity deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsuarioEntityBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
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

class _$UsuarioEntity extends UsuarioEntity {
  @override
  final int id;
  @override
  final String name;
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

  factory _$UsuarioEntity([void Function(UsuarioEntityBuilder) updates]) =>
      (new UsuarioEntityBuilder()..update(updates)).build();

  _$UsuarioEntity._(
      {this.id,
      this.name,
      this.document,
      this.pid,
      this.pidcash,
      this.firstName,
      this.shortName,
      this.role})
      : super._();

  @override
  UsuarioEntity rebuild(void Function(UsuarioEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsuarioEntityBuilder toBuilder() => new UsuarioEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsuarioEntity &&
        id == other.id &&
        name == other.name &&
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
                        $jc($jc($jc(0, id.hashCode), name.hashCode),
                            document.hashCode),
                        pid.hashCode),
                    pidcash.hashCode),
                firstName.hashCode),
            shortName.hashCode),
        role.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UsuarioEntity')
          ..add('id', id)
          ..add('name', name)
          ..add('document', document)
          ..add('pid', pid)
          ..add('pidcash', pidcash)
          ..add('firstName', firstName)
          ..add('shortName', shortName)
          ..add('role', role))
        .toString();
  }
}

class UsuarioEntityBuilder
    implements Builder<UsuarioEntity, UsuarioEntityBuilder> {
  _$UsuarioEntity _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

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

  UsuarioEntityBuilder();

  UsuarioEntityBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
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
  void replace(UsuarioEntity other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UsuarioEntity;
  }

  @override
  void update(void Function(UsuarioEntityBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UsuarioEntity build() {
    final _$result = _$v ??
        new _$UsuarioEntity._(
            id: id,
            name: name,
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
