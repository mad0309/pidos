import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pidos/src/data/serializers.dart';

part 'movimientos.g.dart';

abstract class Movimientos implements Built<Movimientos, MovimientosBuilder> {
  
  @nullable
  int get id;

  @nullable
  int get amount;

  @BuiltValueField(wireName: 'generator_id')
  @nullable
  int get generatorId;

  @BuiltValueField(wireName: 'receptor_id')
  @nullable
  int get receptorId;

  @BuiltValueField(wireName: 'created_at')
  @nullable
  DateTime get createdAt;
  
  @nullable
  Generator get generator;

  @nullable
  Receptor get receptor;

  @nullable
  Reason get reason;




  Movimientos._();
  factory Movimientos([void Function(MovimientosBuilder) updates]) = _$Movimientos;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Movimientos.serializer, this);
  }

  static Movimientos fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Movimientos.serializer, json);
  }

  static Serializer<Movimientos> get serializer => _$movimientosSerializer;
}


///
/// GENERATOR
///
abstract class Generator implements Built<Generator, GeneratorBuilder> {
  
  @nullable
  int get id;
  
  @nullable
  String get name;

  @nullable
  int get document;


  Generator._();
  factory Generator([void Function(GeneratorBuilder) updates]) = _$Generator;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Generator.serializer, this);
  }

  static Generator fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Generator.serializer, json);
  }

  static Serializer<Generator> get serializer => _$generatorSerializer;
}



///
/// RECEPTOR
///
abstract class Receptor implements Built<Receptor, ReceptorBuilder> {
  
  @nullable
  int get id;
  
  @nullable
  String get name;

  @nullable
  int get document;


  Receptor._();
  factory Receptor([void Function(ReceptorBuilder) updates]) = _$Receptor;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Receptor.serializer, this);
  }

  static Receptor fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Receptor.serializer, json);
  }

  static Serializer<Receptor> get serializer => _$receptorSerializer;
}


///
/// REASON
///
abstract class Reason implements Built<Reason, ReasonBuilder> {
  
  @nullable
  int get id;
  
  @nullable
  String get name;


  Reason._();
  factory Reason([void Function(ReasonBuilder) updates]) = _$Reason;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Reason.serializer, this);
  }

  static Reason fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Reason.serializer, json);
  }

  static Serializer<Reason> get serializer => _$reasonSerializer;
}



