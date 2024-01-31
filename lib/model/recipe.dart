import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// build_runnerを使うことで自動生成されるファイル
part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  factory Recipe({
    String? title,
    String? course,
    String? directions,
    String? photoUrl,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}