// import 'package:flutter/material.dart';
//
// void main() => runApp(App());
//
// class App extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nested Routing Demo',
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<HomePage> {
//   final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Root App Bar'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             height: 72,
//             color: Colors.cyanAccent,
//             padding: EdgeInsets.all(18),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text('Change Inner Route: '),
//                 RaisedButton(
//                   onPressed: () {
//                     while (navigationKey.currentState.canPop())
//                       navigationKey.currentState.pop();
//                   },
//                   child: Text('to Root'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: NestedNavigator(
//               navigationKey: navigationKey,
//               initialRoute: '/',
//               routes: {
//                 // default rout as '/' is necessary!
//                 '/': (context) => PageOne(),
//                 '/two': (context) => PageTwo(),
//                 '/three': (context) => PageThree(),
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class NestedNavigator extends StatelessWidget {
//   final GlobalKey<NavigatorState> navigationKey;
//   final String initialRoute;
//   final Map<String, WidgetBuilder> routes;
//
//   NestedNavigator({
//     @required this.navigationKey,
//     @required this.initialRoute,
//     @required this.routes,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       child: Navigator(
//         key: navigationKey,
//         initialRoute: initialRoute,
//         onGenerateRoute: (RouteSettings routeSettings) {
//           WidgetBuilder builder = routes[routeSettings.name];
//           if (routeSettings.isInitialRoute) {
//             return PageRouteBuilder(
//               pageBuilder: (context, __, ___) => builder(context),
//               settings: routeSettings,
//             );
//           } else {
//             return MaterialPageRoute(
//               builder: builder,
//               settings: routeSettings,
//             );
//           }
//         },
//       ),
//       onWillPop: () {
//         if (navigationKey.currentState.canPop()) {
//           navigationKey.currentState.pop();
//           return Future<bool>.value(false);
//         }
//         return Future<bool>.value(true);
//       },
//     );
//   }
// }
//
// class PageOne extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Page One'),
//             RaisedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/two');
//               },
//               child: Text('to Page Two'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PageTwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Page Two'),
//             RaisedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/three');
//               },
//               child: Text('go to next'),
//             ),
//             RaisedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('go to back'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PageThree extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Page Three'),
//             RaisedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('go to back'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
