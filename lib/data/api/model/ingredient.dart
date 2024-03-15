import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient extends Equatable {
  final int id;
  final String name;
  final String? imageUrl;

  const Ingredient({required this.id, required this.name, this.imageUrl});

  factory Ingredient.fromJson(Map<String, dynamic> data) =>
      _$IngredientFromJson(data);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  @override
  List<Object?> get props => [id, name, imageUrl];
}
