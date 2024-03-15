
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavorful/data/api/model/recipe.dart';
import 'package:flavorful/data/cookbook_repository.dart';
import 'package:flavorful/data/recipe_repository.dart';

part 'recipes_event.dart';

part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final CookbookRepository categoryRepository;
  final RecipeRepository recipeRepository;

  RecipesBloc(this.categoryRepository, this.recipeRepository)
      : super(RecipesInitial()) {
    on<FetchRecipes>((event, emit) async {
      try {
        List<int> recipeIds =
            await categoryRepository.getRecipeIdsForCategory(event.categoryId);
        List<Recipe> recipes = await recipeRepository.getRecipes(recipeIds);
        emit(RecipesSuccess(recipes));
      } catch (e) {
        emit(RecipesFailure());
      }
    });
  }
}
