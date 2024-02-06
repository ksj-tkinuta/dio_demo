import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WineScreen extends StatefulWidget {
  const WineScreen({Key? key}) : super(key: key);

  @override
  _WineScreenState createState() => _WineScreenState();
}

class _WineScreenState extends State<WineScreen> {
  late bool _showDialog; // ダイアログを表示するかどうかを管理

  var logger = Logger();


  @override
  void initState() {
    super.initState();
    _showDialog = false; // チェックボックスの初期値をfalseに設定
    _checkAndShowAlertDialog();
    logger.d("Logger is working!");
  }

  // ダイアログの表示状態を保存
  Future<void> _saveDialogStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showDialog', value);
    logger.d("Logger save $value");

  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        bool showDialog = _showDialog; // ウィジェットの状態をローカル変数に保存

        return AlertDialog(
          title: Text('現在準備中です',style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8), // 上部の余白を追加
                  CheckboxListTile(
                    title: Text('再度表示しない'),
                    value: showDialog,
                    onChanged: (value) {
                      setState(() {
                        showDialog = value ?? false; // チェックボックスの状態を更新
                      });
                    },
                  ),
                ],
              );
            },
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12), // コンテンツの余白を調整
          actions: [
            TextButton(
              onPressed: () {
                _saveDialogStatus(showDialog); // ダイアログを閉じるときに状態を保存
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  // ダイアログの表示状態を取得し、必要に応じてダイアログを表示するメソッド
  void _checkAndShowAlertDialog() async {
    final prefs = await SharedPreferences.getInstance();
    bool showDialog = prefs.getBool('showDialog') ?? false;
    logger.d("Logger check $showDialog");

    if (!showDialog) {
      _showAlertDialog();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAndShowAlertDialog();
    }
  }

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
