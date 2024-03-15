part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeFailure extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSuccess extends HomeState {
  final List<Recipe> latestRecipes;
  final List<Recipe> randomRecipes;
  final List<Category> randomCategories;

  const HomeSuccess(
      {required this.latestRecipes,
      required this.randomRecipes,
      required this.randomCategories});

  @override
  List<Object> get props => [latestRecipes];
}
