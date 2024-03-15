import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_ingredient.g.dart';

@JsonSerializable()
class RecipeIngredient extends Equatable {
  final int id;
  final int recipeId;
  final int instructionId;
  final String ingredient;
  final bool plural;
  final int? quantity;
  final String? unit;
  final DateTime createdAt;

  const RecipeIngredient(
      {required this.id,
      required this.recipeId,
      required this.instructionId,
      required this.ingredient,
      required this.plural,
      this.quantity,
      this.unit,
      required this.createdAt});

  factory RecipeIngredient.fromJson(Map<String, dynamic> data) =>
      _$RecipeIngredientFromJson(data);

  Map<String, dynamic> toJson() => _$RecipeIngredientToJson(this);

  @override
  List<Object?> get props => [
        id,
        recipeId,
        instructionId,
        ingredient,
        plural,
        quantity,
        unit,
        createdAt
      ];
}
