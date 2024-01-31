import 'package:dio/dio.dart';

import '../model/recipe.dart';

class RecipeApiClient {
  Future<List<Recipe>?> fetchRecipeList() async {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      responseHeader: true,
      requestHeader: true,
      error: true,
      logPrint: (object) => print(object),
    ));
    const url = 'https://api.sampleapis.com/recipes/recipes';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final datas = response.data as List<dynamic>;
        final list = datas.map((e) => Recipe.fromJson(e)).toList();
        return list;
      } else {
        // Handle non-200 status codes
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle Dio errors
      print('Error fetching recipe list: $e');
      return null;
    }
  }
}
