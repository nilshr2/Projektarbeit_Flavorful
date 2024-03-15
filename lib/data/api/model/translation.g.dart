// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Translation _$TranslationFromJson(Map<String, dynamic> json) => Translation(
      id: json['id'] as int,
      langId: json['langId'] as String,
      translation: json['translation'] as String,
      textContentId: json['textContentId'] as String,
    );

Map<String, dynamic> _$TranslationToJson(Translation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'langId': instance.langId,
      'translation': instance.translation,
      'textContentId': instance.textContentId,
    };
