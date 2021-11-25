// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_study01/constants.dart' as constants;
import 'package:flutter_study01/components/content_view.dart';
import 'package:flutter_study01/menu/menu.dart';
import 'package:flutter_study01/menu/menu_event.dart';

void main() {
  runApp(const MaterialApp(
    title: "Loan Management System",
    home: MaterialApp(
      title: 'Loan system',
      home: LoanSystem(),
    ),
  ));
}

class LoanSystem extends StatefulWidget {
  const LoanSystem({Key? key}) : super(key: key);

  @override
  _LoanSystemState createState() => _LoanSystemState();
}

class _LoanSystemState extends State<LoanSystem> {
  dynamic eventFn;
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    eventFn = eventBus.on<MenuItemTouchEvent>().listen((event) {
      if (event.menuItemObj.url == "/") {
        while (navigationKey.currentState!.canPop()) {
          navigationKey.currentState!.pop();
        }
      } else {
        navigationKey.currentState!.pushNamed(event.menuItemObj.url);
      }
    });
  }

  @override
  void dispose() {
    eventFn.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        LeftSideBar(),
        Expanded(
            child: ContentNavigator(
          navigationKey: navigationKey,
        ))
      ],
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopOfLeftSideBar(),
              MenuBar(menuData),
            ],
          ),
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
