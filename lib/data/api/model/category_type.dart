import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_type.g.dart';

@JsonSerializable()
class CategoryType extends Equatable {
  final int id;
  final String name;

  const CategoryType({required this.id, required this.name});

  factory CategoryType.fromJson(Map<String, dynamic> data) =>
      _$CategoryTypeFromJson(data);

  Map<String, dynamic> toJson() => _$CategoryTypeToJson(this);

  @override
  List<Object?> get props => [id, name];
}
