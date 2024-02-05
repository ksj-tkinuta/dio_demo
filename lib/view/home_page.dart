import 'package:dio_demo/view/recipe_screen.dart';
import 'package:dio_demo/view/wine_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/provider.dart';
import '../model/coffee.dart';
import 'coffee_screen.dart'; // Coffeeモデルのimportが必要です

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // BottomNavigationBarの選択インデックス

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    CoffeeScreen(),
    WineScreen(), // Calendar Screen Widget
    RecipeScreen(), // Graph Screen Widget
  ];

  //Iconクリック時の処理
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final asyncValue = ref.watch(listProvider); //取得したAPIデータの監視
      return Scaffold(
        appBar: AppBar(
          title: const Text('Gourmet Tips'),
        ),
        body: _widgetOptions.elementAt(_selectedIndex), // CoffeeScreenウィジェットを表示
        bottomNavigationBar: BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.local_cafe, size: 50.0),
              label: 'Coffee',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.wine_bar, size: 50.0),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2), // バッジ内の余白
                      constraints: const BoxConstraints(
                        minWidth: 22, // バッジの最小幅
                        minHeight: 22, // バッジの最小高さ
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '20', // 20と表示
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              label: 'Wine',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.receipt, size: 50.0),
              label: 'Recipe',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped, //Iconタップ時のイベント
        ),
      );
    });
  }}
