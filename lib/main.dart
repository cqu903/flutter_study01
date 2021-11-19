// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_study01/Constants.dart' as constants;
import 'package:flutter_study01/menu.dart';
import 'package:flutter_study01/menu_event.dart';

void main() {
  runApp(const MaterialApp(
    title: "Loan Management System",
    home: LoanSystem(),
  ));
}

class LoanSystem extends StatelessWidget {
  const LoanSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: const [LeftSideBar(), Expanded(child: ContentView())],
    ));
  }
}

class LeftSideBar extends StatelessWidget {
  const LeftSideBar({Key? key}) : super(key: key);

  double _calculateMenuWidth(BuildContext context) {
    return constants.leftSideBarWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _calculateMenuWidth(context),
        height: double.infinity,
        decoration: const BoxDecoration(color: Color.fromRGBO(4, 21, 39, 1)),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Column(
          children: [
            const TopOfLeftSideBar(),
            SingleChildScrollView(child: MenuBar(menuData)),
          ],
        ));
  }
}

class TopOfLeftSideBar extends StatelessWidget {
  const TopOfLeftSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: const Image(
          height: 100,
          image: AssetImage("assets/banner.jpeg"),
        ));
  }
}

class MenuBar extends StatefulWidget {
  final Menu menu;

  const MenuBar(this.menu, {Key? key}) : super(key: key);

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  String _expandedKey = "";

  _handleExpansion(int index, bool isExpanded) {
    setState(() {
      if (isExpanded) {
        _expandedKey = "";
      } else {
        _expandedKey = widget.menu.categories[index].title;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expansionCallback: (index, isExpanded) {
          _handleExpansion(index, isExpanded);
        },
        children: widget.menu.categories
            .map((e) {

              return ExpansionPanel(
                  isExpanded: e.title == _expandedKey,
                  backgroundColor: constants.MenuBackgourndColor,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(e.title,style: TextStyle(color: Colors.white70),),
                    );
                  },
                  body: Column(
                    children: e.items
                        .map((menuItemObj) => MenuItem(
                              menuItemObj: menuItemObj,
                            ))
                        .toList(),
                  ),
                );
            })
            .toList());
    // widget.menu.categories.map((e) => MenuItemCategory(e)).toList());
  }
}

class ContentView extends StatelessWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white70),
      child: const Center(child: Text('body')),
    );
  }
}

class MenuItemCategory extends StatelessWidget {
  final MenuCategory category;

  const MenuItemCategory(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.ac_unit),
      collapsedTextColor: Colors.white60,
      collapsedIconColor: Colors.white60,
      textColor: Colors.white70,
      iconColor: Colors.white70,
      title: Text(
        category.title,
        style: const TextStyle(fontSize: 14),
      ),
      children: category.items
          .map((menuItemObj) => MenuItem(menuItemObj: menuItemObj))
          .toList(),
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
  var eventBusFn;
  @override
  void initState(){
    super.initState();
    eventBusFn = eventBus.on<MenuItemTouchEvent>().listen((event) {
      if (event.touchedKey == widget.menuItemObj.getKey()) {
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
    super.dispose();
    //取消订阅
    eventBusFn.cancel();
  }

  _handleTap() {
    eventBus.fire(MenuItemTouchEvent(touchedKey: widget.menuItemObj.getKey()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        trailing: const Icon(Icons.keyboard_arrow_right),
        tileColor: _isSelected
            ? const Color.fromRGBO(49, 105, 233, 1)
            : constants.MenuBackgourndColor,
        onTap: (){
          _handleTap();
        },
        title: Text(widget.menuItemObj.title,
            style: const TextStyle(fontSize: 14, color: Colors.white70)),
      ),
    );
  }
}
