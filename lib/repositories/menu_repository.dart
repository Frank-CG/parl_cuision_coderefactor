import 'package:http/http.dart' as http;
import 'package:parl_cuision_coderefactor/models/menu.dart';
import 'package:parl_cuision_coderefactor/repositories/menu_api_client.dart';

class MenuRepository {
  final MenuApiClient menuApiClient = MenuApiClient(
    httpClient: http.Client(),
  );
  Menu _data;
  DateTime _expiredTime;

  Menu get data => _data;
  DateTime get updateTime => _expiredTime;

  MenuRepository();

  Future<void> initial() async {
    await menuApiClient.fetchMenu().then((onValue){ _data = onValue; });
    _expiredTime = DateTime.now().add(Duration(seconds: 120,));
  }

  Future<Menu> fetchMenu({forceRefresh: false}) async {
    if(forceRefresh){
      await initial();
    }
    DateTime _current = DateTime.now();
    if(_data == null || _current.isAfter(this._expiredTime)){
      await initial();
    }
    return _data;
  }
}
