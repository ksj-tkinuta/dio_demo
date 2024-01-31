import 'package:flutter/material.dart';

class WineScreen extends StatelessWidget {
  const WineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wine Page'),
      ),
      body: Center(
        child: Image.asset('assets/images/wine_image.png'), // ワイン画像のパス
      ),
    );
  }
}
