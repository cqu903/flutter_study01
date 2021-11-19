class MenuItemObj {
  String title;
  String url;
  bool selected = false;

  MenuItemObj({required this.title, required this.url});
  String getKey(){
    return title;
  }
}

class Menu {
  List<MenuCategory> categories;
  List<MenuItemObj> menuItemObjs = [];

  Menu(this.categories) {
    for (var element in categories) {
      menuItemObjs.addAll(element.items);
    }
  }

  MenuItemObj findByKey(String key) {
    return menuItemObjs.firstWhere((element) => element.title == key);
  }
}

class MenuCategory {
  late String title;
  late List<MenuItemObj> items;

  MenuCategory(this.title, {required this.items});
}

var _m1 = MenuItemObj(title: 'menu1', url: "menu1");
var _m2 = MenuItemObj(title: 'menu2', url: "menu1");
var _m3 = MenuItemObj(title: 'menu3', url: "menu1");
var _m4 = MenuItemObj(title: 'menu4', url: "menu1");
var _m5 = MenuItemObj(title: 'menu5', url: "menu1");
var _mc1 = MenuCategory("Settings", items: [_m1, _m2]);
var _mc2 = MenuCategory("System", items: [_m3, _m4, _m5]);
var menuData = Menu([_mc1, _mc2]);
