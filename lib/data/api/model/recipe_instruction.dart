import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_instruction.g.dart';

@JsonSerializable()
class RecipeInstruction extends Equatable {
  final int id;
  final int recipeId;
  final int step;
  final String instruction;
  final String? icon;
  final int? timer;
  final String? timerText;
  final bool runTimerInBackground;
  final DateTime createdAt;

  const RecipeInstruction(
      {required this.id,
      required this.recipeId,
      required this.step,
      required this.instruction,
      this.icon,
      this.timer,
      this.timerText,
      required this.runTimerInBackground,
      required this.createdAt});

  factory RecipeInstruction.fromJson(Map<String, dynamic> data) =>
      _$RecipeInstructionFromJson(data);

  Map<String, dynamic> toJson() => _$RecipeInstructionToJson(this);

  @override
  List<Object?> get props =>
      [id, recipeId, step, instruction, icon, timer, createdAt];
}
