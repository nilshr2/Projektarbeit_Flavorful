import 'package:flavorful/data/cookbook_repository.dart';
import 'package:flavorful/pages/home/screen_home/screen_home.dart';
import 'package:flavorful/pages/recipe/screen_instructions/screen_instructions.dart';
import 'package:flavorful/pages/recipe/sheet_recipe/sheet_recipe.dart';
import 'package:flavorful/shared/components/custom_scaffold.dart';
import 'package:flavorful/pages/categories/screen_categories/screen_categories.dart';
import 'package:flavorful/pages/categories/screen_recipes/screen_recipes.dart';
import 'package:flavorful/shared/components/sheet/modal_bottom_sheet_page.dart';
import 'package:flavorful/supabase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/translation/translation_bloc.dart';
import 'data/recipe_repository.dart';
import 'data/translation_repository.dart';

void main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: DefaultSupabaseOptions.url, anonKey: DefaultSupabaseOptions.anonKey);
  runApp(const FlavorfulProviders());
}

class FlavorfulProviders extends StatelessWidget {
  const FlavorfulProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TranslationRepository(),
        ),
        RepositoryProvider(
          create: (context) => CookbookRepository(),
        ),
        RepositoryProvider(
          create: (context) => RecipeRepository(),
        ),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) => TranslationBloc(
            RepositoryProvider.of<TranslationRepository>(context)),
        child: FlavorfulApp(),
      ),
    );
  }
}

class FlavorfulApp extends StatelessWidget {
  FlavorfulApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      //Resolution of the locale used for the app and the api data.
      localeResolutionCallback: (loc, supportedLocales) {
        Locale locale = supportedLocales.firstWhere(
            (e) => e.languageCode == loc?.languageCode,
            orElse: () => const Locale('en', 'US'));
        context
            .read<TranslationBloc>()
            .add(FetchTranslations(locale.toLanguageTag()));
        return locale;
      },
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      routerConfig: _router,
    );
  }

  //Allows Flutter to differentiate both navigators.
  static final GlobalKey<NavigatorState> _rootNavigator =
      GlobalKey(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigator =
      GlobalKey(debugLabel: 'shell');

  //All routes within the app.
  final _router = GoRouter(
    navigatorKey: _rootNavigator,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
                StatefulNavigationShell navigationShell) =>
            CustomScaffold(
          navigationShell: navigationShell,
        ),
        branches: <StatefulShellBranch>[
          //Routes contained in the navigation shell.
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => ScreenHome(
                navToRecipe: (recipeId) => context.push('/recipes/$recipeId'),
                navToCategory: (categoryId) =>
                    context.go('/categories/$categoryId'),
              ),
            ),
          ]),
          StatefulShellBranch(navigatorKey: _shellNavigator, routes: [
            GoRoute(
                path: '/categories',
                builder: (context, state) => ScreenCategories(
                      nav: (categoryId) =>
                          context.go('/categories/$categoryId'),
                    ),
                routes: [
                  GoRoute(
                    path: ':categoryId',
                    builder: (context, state) => ScreenRecipes(
                      categoryId:
                          int.parse(state.pathParameters['categoryId']!),
                      nav: (recipeId) => context.push('/recipes/$recipeId'),
                    ),
                  ),
                ]),
          ]),
        ],
      ),
      //Routes outside the navigation shell.
      GoRoute(
          parentNavigatorKey: _rootNavigator,
          path: '/recipes/:recipeId',
          pageBuilder: (context, state) => ModalBottomSheetPage(
              (_) => SheetRecipe(
                    recipeId: int.parse(state.pathParameters['recipeId']!),
                    nav: (recipeId, factor) {
                      String query = "?factor=$factor";
                      context.push("/recipes/$recipeId/instructions$query");
                    },
                  ),
              SheetRecipe.bottomSheetRecipeOptions),
          routes: [
            GoRoute(
                path: 'instructions',
                builder: (context, state) {
                  final String? factorQuery =
                      state.uri.queryParameters['factor'];
                  final double? factor =
                      factorQuery != null ? double.parse(factorQuery) : null;
                  return ScreenInstructions(
                      recipeId: int.parse(state.pathParameters['recipeId']!),
                      factor: factor);
                })
          ])
    ],
  );
}
