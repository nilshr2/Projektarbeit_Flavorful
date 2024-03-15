part of 'recipes_bloc.dart';

abstract class RecipesState extends Equatable {
  const RecipesState();
}

class RecipesInitial extends RecipesState {
  @override
  List<Object> get props => [];
}

class RecipesFailure extends RecipesState {
  @override
  List<Object> get props => [];
}

class RecipesSuccess extends RecipesState {
  final List<Recipe> recipes;

  const RecipesSuccess(this.recipes);

  @override
  List<Object> get props => [recipes];
}
