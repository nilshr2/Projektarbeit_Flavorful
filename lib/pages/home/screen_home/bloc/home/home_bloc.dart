import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavorful/data/api/model/category.dart';
import 'package:flavorful/data/api/model/recipe.dart';
import 'package:flavorful/data/cookbook_repository.dart';
import 'package:flavorful/data/recipe_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RecipeRepository recipeRepository;
  final CookbookRepository cookbookRepository;

  HomeBloc(this.recipeRepository, this.cookbookRepository)
      : super(HomeInitial()) {
    on<FetchHome>((event, emit) async {
      try {
        List<dynamic> futures = await Future.wait([
          recipeRepository.getLatestRecipes(10),
          recipeRepository.getRandomRecipes(20),
          cookbookRepository.getRandomCategories(10)
        ]);
        List<Recipe> latestRecipes = futures[0];
        List<Recipe> randomRecipes = futures[1];
        List<Category> randomCategories = futures[2];
        emit(HomeSuccess(
            latestRecipes: latestRecipes,
            randomRecipes: randomRecipes,
            randomCategories: randomCategories));
      } catch (e) {
        emit(HomeFailure());
      }
    });
  }
}
