import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/coffee.dart';
import '../model/recipe.dart';
import '../repository/repository.dart';

// Repository(APIの取得)の状態を管理する
final repositoryProvider = Provider((ref) => Repository());

// 上記を非同期で管理する
final listProvider = FutureProvider<List<Coffee>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.fetchList();
});

final listRecipeProvider = FutureProvider<List<Recipe>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.fetchRecipeList();
});