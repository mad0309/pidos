import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pidos/src/data/serializers.dart';

part 'settings.g.dart';

abstract class Settings implements Built<Settings, SettingsBuilder> {


  @nullable
  String get name;

  @nullable
  String get value;
  

  Settings._();
  factory Settings([void Function(SettingsBuilder) updates]) = _$Settings;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Settings.serializer, this);
  }

  static Settings fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Settings.serializer, json);
  }
  List<Settings> fromMapList(List<dynamic> jsonList) {
      return jsonList.map((json) => Settings.fromJson(json)).toList();
    }

  static Serializer<Settings> get serializer => _$settingsSerializer;
}