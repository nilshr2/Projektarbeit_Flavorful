import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe extends Equatable {
  final int id;
  final String name;
  final int calories;
  final int duration;
  final int? inactiveDuration;
  final int servings;
  final String? imageUrl;
  final DateTime createdAt;

  const Recipe({
    required this.id,
    required this.name,
    required this.calories,
    required this.duration,
    this.inactiveDuration,
    required this.servings,
    this.imageUrl,
    required this.createdAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> data) => _$RecipeFromJson(data);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  @override
  List<Object?> get props =>
      [id, name, calories, duration, inactiveDuration, imageUrl, createdAt];
}
