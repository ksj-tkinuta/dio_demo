import 'package:flutter/cupertino.dart';
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/wine_image.png', // ワイン画像のパス
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            const Positioned(
              bottom: 200, // 下から200dp配置
              child: Text(
                '準備中',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
