import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:parl_cuision_coderefactor/models/menu.dart';

import '../app_conifg.dart';

class MenuApiClient {
  // static const baseUrl = 'https://my-json-server.typicode.com/Frank-CG/jsonServer';
  // final http.Client httpClient;
  String baseUrl = 'https://192.168.0.52/ParlCuisionApiServer/api';
  final HttpClient httpClient;
  

  MenuApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Menu> fetchMenu() async {
    //final menuUrl = '$baseUrl/menu';
    // baseUrl = 'http://franksliqvm.eastus.cloudapp.azure.com/ParlCuisionApiServer/api';
    baseUrl = 'https://192.168.0.52/UserManagementApi/api/UserApi/GetMenu';

    print("${AppConfig.instance.accessToken}");

    String menuUrl = '$baseUrl/menu';
    menuUrl = '$baseUrl';
    // menuUrl = "https://192.168.0.52/ParlCuisionApiServer/api/menu";
    // menuUrl = 'https://my-json-server.typicode.com/Frank-CG/jsonServer/menu';
    menuUrl = "https://192.168.0.52/SliqWebCommonApi/api/Customers/GetAllCustomers";

    httpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    // HttpClientRequest request = await httpClient.getUrl(Uri.parse(menuUrl));

    HttpClientRequest request = await httpClient.postUrl(Uri.parse(menuUrl));
    request.headers.set('content-type', 'application/json');
    request.headers.set(HttpHeaders.authorizationHeader, "Bearer ${AppConfig.instance.accessToken}");
    HttpClientResponse menuResponse = await request.close();
    String reply = await menuResponse.transform(utf8.decoder).join();

    // final menuResponse = await this.httpClient.get(menuUrl, headers: {HttpHeaders.authorizationHeader: "Bearer ${AppConfig.instance.accessToken}"},);

    if (menuResponse.statusCode != 200) {
      if(menuResponse.statusCode == 401){
        AppConfig.instance.accessToken = await AppConfig.instance.oauth.getAccessToken();
        request = await httpClient.getUrl(Uri.parse(menuUrl));
        request.headers.set('content-type', 'application/json');
        request.headers.set(HttpHeaders.authorizationHeader, "Bearer ${AppConfig.instance.accessToken}");
        menuResponse = await request.close();
        reply = await menuResponse.transform(utf8.decoder).join();
      }else
        throw Exception('error getting menu for location');
    }

    final menuJson = jsonDecode(reply);
    print(menuJson);
    return Menu.fromJson(menuJson);
  }
}
