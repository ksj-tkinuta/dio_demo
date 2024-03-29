import 'package:dio/dio.dart';

import '../model/coffee.dart';

class CoffeeApiClient {
  Future<List<Coffee>?> fetchList() async {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    const url = 'https://api.sampleapis.com/coffee/hot';

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      try {
        final datas = response.data as List<dynamic>;
        final list = datas.map((e) => Coffee.fromJson(e)).toList();
        print('Response: ${response.data}');

        return list;
      } catch (e) {
        throw e;
      }
    }
  }
}