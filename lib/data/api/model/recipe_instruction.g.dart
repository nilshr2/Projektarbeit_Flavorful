// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeInstruction _$RecipeInstructionFromJson(Map<String, dynamic> json) =>
    RecipeInstruction(
      id: json['id'] as int,
      recipeId: json['recipeId'] as int,
      step: json['step'] as int,
      instruction: json['instruction'] as String,
      icon: json['icon'] as String?,
      timer: json['timer'] as int?,
      timerText: json['timerText'] as String?,
      runTimerInBackground: json['runTimerInBackground'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RecipeInstructionToJson(RecipeInstruction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'step': instance.step,
      'instruction': instance.instruction,
      'icon': instance.icon,
      'timer': instance.timer,
      'timerText': instance.timerText,
      'runTimerInBackground': instance.runTimerInBackground,
      'createdAt': instance.createdAt.toIso8601String(),
    };
