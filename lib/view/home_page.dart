import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/provider.dart';
import '../model/coffee.dart'; // Coffeeモデルのimportが必要です

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
          data: (List<Coffee> data) { // asyncValueの型をList<Coffee>に指定
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
                          return AlertDialog( // SimpleDialogからAlertDialogに変更
                            title: Text(coffee.title ?? ''),
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
                      trailing: const Icon(Icons.more_vert),
                    ),
                  ),
                ),
              )
                  .toList(),
            )
                : const Text('Data is empty.');
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text(error.toString()),
        ),
      ),
    );
  }
}
