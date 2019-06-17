import 'package:parl_cuision_coderefactor/models/models.dart';

class Order {
  int itemCount = 0;
  final List<OrderItem> orderItems = new List<OrderItem>();
  
  void add(OrderItem orderItem){
    bool isNewItem = true;
    for(int i=0; i<orderItems.length; i++){
      if(orderItems[i].item.itemId == orderItem.item.itemId){
        isNewItem = false;
        orderItems[i].itemCount++;
        break;
      }
    }
    if(isNewItem){
      orderItem.itemCount=1;
      orderItems.add(orderItem);
    }
  }

  void remove(OrderItem orderItem){
    for(int i=0; i<orderItems.length; i++){
      if(orderItems[i].item.itemId == orderItem.item.itemId){
        orderItems[i].itemCount--;
        if(orderItems[i].itemCount <= 0){
          orderItems.removeAt(i);
          this.itemCount--;
        }
        break;
      }
    }
  }
  
}
