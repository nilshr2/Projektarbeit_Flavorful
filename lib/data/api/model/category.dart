import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final int id;
  final String name;
  final int categoryTypeId;
  final String? imageUrl;

  const Category(
      {required this.id,
      required this.name,
      required this.categoryTypeId,
      this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> data) =>
      _$CategoryFromJson(data);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [id, name, categoryTypeId, imageUrl];
}
