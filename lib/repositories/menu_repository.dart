import 'package:http/http.dart' as http;
import 'package:parl_cuision_coderefactor/models/menu.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';
import 'package:parl_cuision_coderefactor/repositories/menu_api_client.dart';

class MenuRepository {
  final MenuApiClient menuApiClient = MenuApiClient(
    httpClient: http.Client(),
  );
  Menu _data;
  Menu _filteredData;
  DateTime _expiredTime;

  Menu get data => _data;
  DateTime get updateTime => _expiredTime;

  MenuRepository();

  Future<void> initial() async {
    await menuApiClient.fetchMenu().then((onValue){ _data = onValue; });
    _expiredTime = DateTime.now().add(Duration(seconds: 120,));
  }

  Future<Menu> fetchMenu({forceRefresh: false, isHealthy: true, isVegetarian: true, isVegan: true}) async {
    if(forceRefresh){
      await initial();
    }
    DateTime _current = DateTime.now();
    if(_data == null || _current.isAfter(this._expiredTime)){
      await initial();
    }
    _filteredData = filter(isHealthy: isHealthy, isVegetarian: isVegetarian, isVegan: isVegan);
    return _filteredData;
  }

  Menu filter({isHealthy: true, isVegetarian: true, isVegan: true}){
    Menu result = _data.copy();
    List<MenuItem> itemList = result.menuItems;
    for(int i=0; i<itemList.length; i++){
      MenuItem item = itemList[i];
      switch (item.itemType) {
        case "healthy":
          if(!isHealthy){
            itemList.removeAt(i);
          }
          break;
        case "vegetarian":
          if(!isVegetarian){
            itemList.removeAt(i);
          }
          break;
        case "vegan":
          if(!isVegan){
            itemList.removeAt(i);
          }
          break;
        default:
          break;
      }
    }
    return result;
  }
}
