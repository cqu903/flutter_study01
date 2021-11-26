import 'package:flutter/material.dart';
import 'package:flutter_study01/components/home.dart';
import 'package:flutter_study01/components/loan/loan.dart';
import 'package:flutter_study01/components/unknown.dart';
import 'package:flutter_study01/menu/menu.dart';

class ContentNavigator extends StatefulWidget {
  const ContentNavigator({Key? key}) : super(key: key);

  @override
  _ContentNavigatorState createState() => _ContentNavigatorState();
}

class _ContentNavigatorState extends State<ContentNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ContentRoutePath {
  String? moduleName;
  String? id;
  bool isUnknown;

  ContentRoutePath():moduleName=null,id=null,isUnknown=false;

  ContentRoutePath.home():id=null,moduleName=null,isUnknown=false ;
  ContentRoutePath.module({required this.moduleName,this.id}):isUnknown=false;
  ContentRoutePath.unKnown():moduleName=null,id=null,isUnknown=true;
}

class ContentRouterDelegte extends RouterDelegate<ContentRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigatorKey;
  MenuItemObj? _selectedMenuItem;
  bool show404 = false;

  ContentRouterDelegte() :navigatorKey = GlobalKey<NavigatorState>();

  @override
  ContentRoutePath get currentConfiguration {
    if (_selectedMenuItem == null) {
      return ContentRoutePath.home();
    }
    if(show404){
      return ContentRoutePath.unKnown();
    }else{
      return ContentRoutePath.module(moduleName: _selectedMenuItem!.moduleName);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('home'),
          child: HomePage()
        ),

      ],
    );
  }


  @override
  Future<void> setNewRoutePath(ContentRoutePath configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }

}

