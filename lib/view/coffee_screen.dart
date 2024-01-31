import 'package:flutter/material.dart';
import '../model/coffee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/provider.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final asyncValue = ref.watch(listProvider); //取得したAPIデータの監視

      return Center(
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
                                      content: Text(
                                        coffee.description ?? '',
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
                                title: Text(coffee.title ?? ''),
                                subtitle: Text(
                                  coffee.description ?? '',
                                  maxLines: 3, // 最大3行に制限
                                ),
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
