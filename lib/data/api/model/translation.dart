import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translation.g.dart';

@JsonSerializable()
class Translation extends Equatable {
  final int id;
  final String langId;
  final String translation;
  final String textContentId;

  const Translation(
      {required this.id,
      required this.langId,
      required this.translation,
      required this.textContentId});

  factory Translation.fromJson(Map<String, dynamic> data) =>
      _$TranslationFromJson(data);

  Map<String, dynamic> toJson() => _$TranslationToJson(this);

  @override
  List<Object?> get props => [id, langId, translation, textContentId];
}
