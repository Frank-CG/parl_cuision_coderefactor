import 'package:parl_cuision_coderefactor/models/models.dart';

class Order {
  int itemCount = 0;
  double totalPrice = 0.0;
  List<OrderItem> orderItems = new List<OrderItem>();

  OrderItem fetch(OrderItem orderItem){
    for(int i=0; i<orderItems.length; i++){
      if(orderItems[i].item.itemId == orderItem.item.itemId){
        return orderItems[i];
      }
    }
    return null;
  }
  
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
      itemCount++;
    }
    totalPrice += orderItem.item.unitPrice;
  }

  void remove(OrderItem orderItem){
    for(int i=0; i<orderItems.length; i++){
      if(orderItems[i].item.itemId == orderItem.item.itemId){
        orderItems[i].itemCount--;
        if(orderItems[i].itemCount <= 0){
          orderItems.removeAt(i);
          this.itemCount--;
        }
        totalPrice -= orderItem.item.unitPrice;
        if(totalPrice < 0){
          totalPrice = 0.0;
        }
        break;
      }
    }
  }

  void clean(){
    orderItems = new List<OrderItem>();
    itemCount = 0;
    totalPrice = 0.0;
  }
  
}
