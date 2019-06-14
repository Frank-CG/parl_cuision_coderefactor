import 'dart:convert';
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:parl_cuision_coderefactor/models/menu.dart';

class MenuApiClient {
  static const baseUrl = 'https://my-json-server.typicode.com/Frank-CG/jsonServer';
  final http.Client httpClient;

  MenuApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Menu> fetchMenu() async {
    final menuUrl = '$baseUrl/menu';
    final menuResponse = await this.httpClient.get(menuUrl);

    if (menuResponse.statusCode != 200) {
      throw Exception('error getting menu for location');
    }

    final menuJson = jsonDecode(menuResponse.body);
    return Menu.fromJson(menuJson);
  }
}
