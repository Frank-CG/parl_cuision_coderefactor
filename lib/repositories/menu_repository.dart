import 'package:http/http.dart' as http;
import 'package:parl_cuision_coderefactor/models/menu.dart';
import 'package:parl_cuision_coderefactor/repositories/menu_api_client.dart';

class MenuRepository {
  final MenuApiClient menuApiClient = MenuApiClient(
    httpClient: http.Client(),
  );
  Menu _data;

  Menu get data => _data;

  MenuRepository();

  Future<void> initial() async {
    await menuApiClient.fetchMenu().then((onValue){ _data = onValue; });
  }
}
