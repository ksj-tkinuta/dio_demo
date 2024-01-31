import '../service/coffee_api_client.dart';
import '../service/recipe_api_client.dart';

class Repository {
  final api = CoffeeApiClient();
  dynamic fetchList() async {
    return await api.fetchList();
  }

  final apiRecipe = RecipeApiClient();
  dynamic fetchRecipeList() async {
    return await apiRecipe.fetchRecipeList();
  }
}