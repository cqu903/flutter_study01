import 'package:flutter/material.dart';
import 'package:flutter_study01/menu/menu_event.dart';
import 'package:flutter_study01/constants.dart' as constants;

class MenuItemObj {
  String title;
  String url;
  bool selected = false;
  String moduleName;

  MenuItemObj({required this.title, required this.url,required this.moduleName});

  String getKey() {
    return title;
  }
}

class MenuObj {
  List<MenuCategoryObj> categories;
  List<MenuItemObj> menuItemObjs = [];

  MenuObj(this.categories) {
    for (var element in categories) {
      menuItemObjs.addAll(element.items);
    }
  }

  MenuItemObj findByKey(String key) {
    return menuItemObjs.firstWhere((element) => element.title == key);
  }
}

class MenuCategoryObj {
  late String title;
  late List<MenuItemObj> items;

  MenuCategoryObj(this.title, {required this.items});

  String getKey() {
    return title;
  }
}

var _m2 = MenuItemObj(title: '贷款单', url: "/loan",moduleName: 'Loan');
var _m3 = MenuItemObj(title: 'menu3', url: "/menu1",moduleName: 'Loan');
var _m4 = MenuItemObj(title: 'menu4', url: "/menu1",moduleName: 'Loan');
var _m5 = MenuItemObj(title: 'menu5', url: "/menu1",moduleName: 'Loan');
var _mc1 = MenuCategoryObj("系统管理", items: [ _m2]);
var _mc2 = MenuCategoryObj("用户设置", items: [_m3, _m4, _m5]);
var menuData = MenuObj([_mc1, _mc2]);


class MenuBar extends StatelessWidget {
  final MenuObj menu;

  const MenuBar(this.menu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
          menu.categories.map((category) => MenuCategory(category)).toList(),
    );
  }
}

class MenuCategory extends StatelessWidget {
  final MenuCategoryObj category;

  const MenuCategory(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      MenuCategoryTitlePanel(
        category: category,
      ),
      MenuCategoryBodyPanel(
        menuCategory: category,
      )
    ]);
  }
}

/// 菜单栏的body，用于显示具体的子目录

class MenuCategoryBodyPanel extends StatefulWidget {
  const MenuCategoryBodyPanel({
    Key? key,
    required this.menuCategory,
  }) : super(key: key);
  final MenuCategoryObj menuCategory;

  @override
  _MenuCategoryBodyPanelState createState() => _MenuCategoryBodyPanelState();
}

class _MenuCategoryBodyPanelState extends State<MenuCategoryBodyPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late dynamic eventBusFn;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: constants.menuAnimationDurationInMillSeconds));
    eventBusFn = eventBus.on<MenuItemCategoryTouchEvent>().listen((event) {
      if (event.touchKey == widget.menuCategory.getKey()) {
        expanded ? controller.reverse() : controller.forward();
        expanded = !expanded;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    eventBusFn.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 0.0,
        sizeFactor: controller,
        child: Column(
          children: widget.menuCategory.items
              .map((menuItem) => MenuItem(menuItemObj: menuItem))
              .toList(),
        ));
  }
}

///菜单目录集合的显示panel
class MenuCategoryTitlePanel extends StatefulWidget {
  const MenuCategoryTitlePanel({
    Key? key,
    required this.category,
  }) : super(key: key);

  final MenuCategoryObj category;

  @override
  _MenuCategoryTitlePanelState createState() => _MenuCategoryTitlePanelState();
}

class _MenuCategoryTitlePanelState extends State<MenuCategoryTitlePanel>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool _isExpanded = false;
  bool _isHover = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: constants.menuAnimationDurationInMillSeconds),
        upperBound: 1.0 / 4);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => setState(() {
        _isHover = true;
      }),
      onExit: (e) => setState(() {
        _isHover = false;
      }),
      child: GestureDetector(
        onTap: () {
          if (_isExpanded) {
            controller.reverse();
          } else {
            controller.forward();
          }
          _isExpanded = !_isExpanded;
          eventBus.fire(
              MenuItemCategoryTouchEvent(touchKey: widget.category.getKey()));
        },
        child: Container(
          color: _isHover
              ? constants.menuCategoryBackgourndColorHover
              : constants.menuBackgroundColor,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Icon(
              Icons.ac_unit,
              color: constants.menuFontColor,
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              widget.category.title,
              style: TextStyle(color: constants.menuFontColor, fontSize: 15),
            ),
            const Spacer(
              flex: 20,
            ),
            RotationTransition(
              turns: controller,
              child: Icon(
                Icons.keyboard_arrow_right,
                color: constants.menuFontColor,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final MenuItemObj menuItemObj;

  const MenuItem({
    required this.menuItemObj,
    Key? key,
  }) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _isSelected = false;
  bool _isHover = false;
  dynamic eventBusFn;

  @override
  void initState() {
    super.initState();
    eventBusFn = eventBus.on<MenuItemTouchEvent>().listen((event) {
      if (event.menuItemObj.getKey() == widget.menuItemObj.getKey()) {
        setState(() {
          _isSelected = true;
        });
      } else {
        setState(() {
          _isSelected = false;
        });
      }
    });
  }

  @override
  void dispose() {
    eventBusFn.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        setState(() {
          _isHover = true;
        });
      },
      onExit: (e) {
        setState(() {
          _isHover = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          eventBus.fire(MenuItemTouchEvent(menuItemObj: widget.menuItemObj));
        },
        child: Container(
          height: 30,
          color: _isSelected
              ? constants.menuItemSelectedColor
              : (_isHover
                  ? constants.menuItemHoverColor
                  : constants.menuBackgroundColor),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 40),
          child: Text(widget.menuItemObj.title,
              style: TextStyle(fontSize: 14, color: constants.menuFontColor)),
        ),
      ),
    );
  }
}
