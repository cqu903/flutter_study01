///这里主要用于处理菜单项目的事件通知相关

import 'package:event_bus/event_bus.dart';
import 'package:flutter_study01/menu/menu.dart';

EventBus eventBus = EventBus();
/// 菜单项点击事件
class MenuItemTouchEvent {
  MenuItemObj menuItemObj;

  MenuItemTouchEvent({required this.menuItemObj});
}

/// 菜单目录点击事件
class MenuItemCategoryTouchEvent{
  String touchKey;
  MenuItemCategoryTouchEvent({required this.touchKey});
}