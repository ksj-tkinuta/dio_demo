import 'package:dio_demo/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/provider.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final asyncValue = ref.watch(listRecipeProvider); //取得したAPIデータの監視

      return Center(
        child: asyncValue.when(
          data: (List<Recipe> data) {
            // asyncValueの型をList<Coffee>に指定
            return data.isNotEmpty
                ? ListView(
              children: data
                  .map(
                    (Recipe recipe) => Card(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              recipe.title ?? '',
                              style: const TextStyle(fontSize: 18),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min, // Columnの高さを最小限に設定
                                children: [
                                  Text(recipe.course ?? ''),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity, // 画像を横いっぱいに広げる
                                    height: 200.0, // 画像の高さを200dpに固定
                                    child: Image.network(
                                      recipe.photoUrl ?? '',
                                      fit: BoxFit.cover, // 画像のフィット方法をカバーに設定
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/wine_image.png', // 代替の画像ファイルパス
                                          fit: BoxFit.cover,
                                        );
                                        ;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(recipe.directions ?? ''),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      title: Text(recipe.title ?? ''),
                      subtitle: Text(recipe.course ?? ''),
                      trailing:
                      const Icon(Icons.navigate_next_rounded),
                    ),
                  ),
                ),
              )
                  .toList(),
            )
                : const Text('Data is empty.');
          },
          loading: () => const SizedBox(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(strokeWidth: 10.0),
          ),
          error: (error, _) => Text(error.toString()),
        ),
      );
    });
  }
}
