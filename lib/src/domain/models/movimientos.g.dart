// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movimientos.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Movimientos> _$movimientosSerializer = new _$MovimientosSerializer();
Serializer<Generator> _$generatorSerializer = new _$GeneratorSerializer();
Serializer<Receptor> _$receptorSerializer = new _$ReceptorSerializer();
Serializer<Reason> _$reasonSerializer = new _$ReasonSerializer();

class _$MovimientosSerializer implements StructuredSerializer<Movimientos> {
  @override
  final Iterable<Type> types = const [Movimientos, _$Movimientos];
  @override
  final String wireName = 'Movimientos';

  @override
  Iterable<Object> serialize(Serializers serializers, Movimientos object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.amount != null) {
      result
        ..add('amount')
        ..add(serializers.serialize(object.amount,
            specifiedType: const FullType(int)));
    }
    if (object.generatorId != null) {
      result
        ..add('generator_id')
        ..add(serializers.serialize(object.generatorId,
            specifiedType: const FullType(int)));
    }
    if (object.receptorId != null) {
      result
        ..add('receptor_id')
        ..add(serializers.serialize(object.receptorId,
            specifiedType: const FullType(int)));
    }
    if (object.createdAt != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(DateTime)));
    }
    if (object.generator != null) {
      result
        ..add('generator')
        ..add(serializers.serialize(object.generator,
            specifiedType: const FullType(Generator)));
    }
    if (object.receptor != null) {
      result
        ..add('receptor')
        ..add(serializers.serialize(object.receptor,
            specifiedType: const FullType(Receptor)));
    }
    if (object.reason != null) {
      result
        ..add('reason')
        ..add(serializers.serialize(object.reason,
            specifiedType: const FullType(Reason)));
    }
    return result;
  }

  @override
  Movimientos deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MovimientosBuilder();

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
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'generator_id':
          result.generatorId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'receptor_id':
          result.receptorId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'generator':
          result.generator.replace(serializers.deserialize(value,
              specifiedType: const FullType(Generator)) as Generator);
          break;
        case 'receptor':
          result.receptor.replace(serializers.deserialize(value,
              specifiedType: const FullType(Receptor)) as Receptor);
          break;
        case 'reason':
          result.reason.replace(serializers.deserialize(value,
              specifiedType: const FullType(Reason)) as Reason);
          break;
      }
    }

    return result.build();
  }
}

class _$GeneratorSerializer implements StructuredSerializer<Generator> {
  @override
  final Iterable<Type> types = const [Generator, _$Generator];
  @override
  final String wireName = 'Generator';

  @override
  Iterable<Object> serialize(Serializers serializers, Generator object,
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
    return result;
  }

  @override
  Generator deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GeneratorBuilder();

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
      }
    }

    return result.build();
  }
}

class _$ReceptorSerializer implements StructuredSerializer<Receptor> {
  @override
  final Iterable<Type> types = const [Receptor, _$Receptor];
  @override
  final String wireName = 'Receptor';

  @override
  Iterable<Object> serialize(Serializers serializers, Receptor object,
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
    return result;
  }

  @override
  Receptor deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReceptorBuilder();

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
      }
    }

    return result.build();
  }
}

class _$ReasonSerializer implements StructuredSerializer<Reason> {
  @override
  final Iterable<Type> types = const [Reason, _$Reason];
  @override
  final String wireName = 'Reason';

  @override
  Iterable<Object> serialize(Serializers serializers, Reason object,
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
    return result;
  }

  @override
  Reason deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReasonBuilder();

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
      }
    }

    return result.build();
  }
}

class _$Movimientos extends Movimientos {
  @override
  final int id;
  @override
  final int amount;
  @override
  final int generatorId;
  @override
  final int receptorId;
  @override
  final DateTime createdAt;
  @override
  final Generator generator;
  @override
  final Receptor receptor;
  @override
  final Reason reason;

  factory _$Movimientos([void Function(MovimientosBuilder) updates]) =>
      (new MovimientosBuilder()..update(updates)).build();

  _$Movimientos._(
      {this.id,
      this.amount,
      this.generatorId,
      this.receptorId,
      this.createdAt,
      this.generator,
      this.receptor,
      this.reason})
      : super._();

  @override
  Movimientos rebuild(void Function(MovimientosBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MovimientosBuilder toBuilder() => new MovimientosBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Movimientos &&
        id == other.id &&
        amount == other.amount &&
        generatorId == other.generatorId &&
        receptorId == other.receptorId &&
        createdAt == other.createdAt &&
        generator == other.generator &&
        receptor == other.receptor &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), amount.hashCode),
                            generatorId.hashCode),
                        receptorId.hashCode),
                    createdAt.hashCode),
                generator.hashCode),
            receptor.hashCode),
        reason.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Movimientos')
          ..add('id', id)
          ..add('amount', amount)
          ..add('generatorId', generatorId)
          ..add('receptorId', receptorId)
          ..add('createdAt', createdAt)
          ..add('generator', generator)
          ..add('receptor', receptor)
          ..add('reason', reason))
        .toString();
  }
}

class MovimientosBuilder implements Builder<Movimientos, MovimientosBuilder> {
  _$Movimientos _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _amount;
  int get amount => _$this._amount;
  set amount(int amount) => _$this._amount = amount;

  int _generatorId;
  int get generatorId => _$this._generatorId;
  set generatorId(int generatorId) => _$this._generatorId = generatorId;

  int _receptorId;
  int get receptorId => _$this._receptorId;
  set receptorId(int receptorId) => _$this._receptorId = receptorId;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  GeneratorBuilder _generator;
  GeneratorBuilder get generator =>
      _$this._generator ??= new GeneratorBuilder();
  set generator(GeneratorBuilder generator) => _$this._generator = generator;

  ReceptorBuilder _receptor;
  ReceptorBuilder get receptor => _$this._receptor ??= new ReceptorBuilder();
  set receptor(ReceptorBuilder receptor) => _$this._receptor = receptor;

  ReasonBuilder _reason;
  ReasonBuilder get reason => _$this._reason ??= new ReasonBuilder();
  set reason(ReasonBuilder reason) => _$this._reason = reason;

  MovimientosBuilder();

  MovimientosBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _amount = _$v.amount;
      _generatorId = _$v.generatorId;
      _receptorId = _$v.receptorId;
      _createdAt = _$v.createdAt;
      _generator = _$v.generator?.toBuilder();
      _receptor = _$v.receptor?.toBuilder();
      _reason = _$v.reason?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Movimientos other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Movimientos;
  }

  @override
  void update(void Function(MovimientosBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Movimientos build() {
    _$Movimientos _$result;
    try {
      _$result = _$v ??
          new _$Movimientos._(
              id: id,
              amount: amount,
              generatorId: generatorId,
              receptorId: receptorId,
              createdAt: createdAt,
              generator: _generator?.build(),
              receptor: _receptor?.build(),
              reason: _reason?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'generator';
        _generator?.build();
        _$failedField = 'receptor';
        _receptor?.build();
        _$failedField = 'reason';
        _reason?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Movimientos', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Generator extends Generator {
  @override
  final int id;
  @override
  final String name;
  @override
  final int document;

  factory _$Generator([void Function(GeneratorBuilder) updates]) =>
      (new GeneratorBuilder()..update(updates)).build();

  _$Generator._({this.id, this.name, this.document}) : super._();

  @override
  Generator rebuild(void Function(GeneratorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeneratorBuilder toBuilder() => new GeneratorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Generator &&
        id == other.id &&
        name == other.name &&
        document == other.document;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), name.hashCode), document.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Generator')
          ..add('id', id)
          ..add('name', name)
          ..add('document', document))
        .toString();
  }
}

class GeneratorBuilder implements Builder<Generator, GeneratorBuilder> {
  _$Generator _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _document;
  int get document => _$this._document;
  set document(int document) => _$this._document = document;

  GeneratorBuilder();

  GeneratorBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _document = _$v.document;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Generator other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Generator;
  }

  @override
  void update(void Function(GeneratorBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Generator build() {
    final _$result =
        _$v ?? new _$Generator._(id: id, name: name, document: document);
    replace(_$result);
    return _$result;
  }
}

class _$Receptor extends Receptor {
  @override
  final int id;
  @override
  final String name;
  @override
  final int document;

  factory _$Receptor([void Function(ReceptorBuilder) updates]) =>
      (new ReceptorBuilder()..update(updates)).build();

  _$Receptor._({this.id, this.name, this.document}) : super._();

  @override
  Receptor rebuild(void Function(ReceptorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReceptorBuilder toBuilder() => new ReceptorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Receptor &&
        id == other.id &&
        name == other.name &&
        document == other.document;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), name.hashCode), document.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Receptor')
          ..add('id', id)
          ..add('name', name)
          ..add('document', document))
        .toString();
  }
}

class ReceptorBuilder implements Builder<Receptor, ReceptorBuilder> {
  _$Receptor _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _document;
  int get document => _$this._document;
  set document(int document) => _$this._document = document;

  ReceptorBuilder();

  ReceptorBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _document = _$v.document;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Receptor other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Receptor;
  }

  @override
  void update(void Function(ReceptorBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Receptor build() {
    final _$result =
        _$v ?? new _$Receptor._(id: id, name: name, document: document);
    replace(_$result);
    return _$result;
  }
}

class _$Reason extends Reason {
  @override
  final int id;
  @override
  final String name;

  factory _$Reason([void Function(ReasonBuilder) updates]) =>
      (new ReasonBuilder()..update(updates)).build();

  _$Reason._({this.id, this.name}) : super._();

  @override
  Reason rebuild(void Function(ReasonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReasonBuilder toBuilder() => new ReasonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Reason && id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Reason')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class ReasonBuilder implements Builder<Reason, ReasonBuilder> {
  _$Reason _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  ReasonBuilder();

  ReasonBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Reason other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Reason;
  }

  @override
  void update(void Function(ReasonBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Reason build() {
    final _$result = _$v ?? new _$Reason._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
