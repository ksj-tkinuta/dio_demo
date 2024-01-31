import 'package:dio_demo/view/wine_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/provider.dart';
import '../model/coffee.dart'; // Coffeeモデルのimportが必要です

int _selectedIndex = 0; // BottomNavigationBarの選択インデックス

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(listProvider); //取得したAPIデータの監視
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee List'),
      ),
      body: Center(
        child: asyncValue.when(
          data: (List<Coffee> data) {
            // asyncValueの型をList<Coffee>に指定
            return data.isNotEmpty
                ? ListView(
                    children: data
                        .map(
                          (Coffee coffee) => Card(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      // SimpleDialogからAlertDialogに変更
                                      title: Text(
                                        coffee.title ?? '',
                                        style: const TextStyle(fontSize: 36),
                                      ),
                                      content: Text(coffee.description ?? ''),
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
                                title: Text(coffee.title ?? ''),
                                subtitle: Text(coffee.description ?? ''),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Coffee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: 'Wine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Recipe',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          // BottomNavigationBarアイテムがタップされたときの処理
          switch (index) {
            case 0:
            // Coffeeアイテムがタップされたときの処理
              Navigator.pushNamed(context, '/coffee_screen');
              break;
            case 1:
            // Wineアイテムがタップされたときの処理
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WinePage()),
              );
              break;
            case 2:
            // Recipeアイテムがタップされたときの処理
              Navigator.pushNamed(context, '/recipe_screen');
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
