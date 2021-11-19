///这里主要用于处理菜单项目的事件通知相关

import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();
/// 菜单项点击事件
class MenuItemTouchEvent {
  String touchedKey;

  MenuItemTouchEvent({required this.touchedKey});
}