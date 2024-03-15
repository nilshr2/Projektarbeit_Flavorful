// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeIngredient _$RecipeIngredientFromJson(Map<String, dynamic> json) =>
    RecipeIngredient(
      id: json['id'] as int,
      recipeId: json['recipeId'] as int,
      instructionId: json['instructionId'] as int,
      ingredient: json['ingredient'] as String,
      plural: json['plural'] as bool,
      quantity: json['quantity'] as int?,
      unit: json['unit'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RecipeIngredientToJson(RecipeIngredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'instructionId': instance.instructionId,
      'ingredient': instance.ingredient,
      'plural': instance.plural,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'createdAt': instance.createdAt.toIso8601String(),
    };
