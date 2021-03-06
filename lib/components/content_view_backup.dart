// import 'package:flutter/material.dart';
// import 'package:flutter_study01/components/home.dart';
// import 'package:flutter_study01/components/loan/loan.dart';
// import 'package:flutter_study01/components/unknown.dart';
//
// class ContentNavigator extends StatelessWidget {
//   final GlobalKey<NavigatorState> navigationKey;
//   final String initialRoute = '/';
//   final Map<String, WidgetBuilder> routes = {
//     "/": (context) => const HomePage(),
//     "/loan": (context) => const LoanList(),
//   };
//
//   ContentNavigator({
//     Key? key,
//     required this.navigationKey,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Navigator(
//       key: navigationKey,
//       initialRoute: initialRoute,
//       onGenerateRoute: (routeSettings) {
//         WidgetBuilder? builder = routes[routeSettings.name];
//         if (builder == null) {
//           return MaterialPageRoute(
//               builder: (context) => UnknownPage(url: routeSettings.name!));
//         } else {
//           return MaterialPageRoute(
//             builder: builder,
//             settings: routeSettings,
//           );
//         }
//       },
//       onUnknownRoute: (routeSettings) {
//         return MaterialPageRoute(
//             builder: (context) => UnknownPage(url: routeSettings.name!));
//       },
//     );
//   }
// }
//
