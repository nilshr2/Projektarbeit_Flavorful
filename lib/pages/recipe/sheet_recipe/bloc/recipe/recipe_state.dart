part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();
}

class RecipeInitial extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeFailure extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeSuccess extends RecipeState {
  final Recipe recipe;

  const RecipeSuccess(this.recipe);

  @override
  List<Object> get props => [recipe];
}
