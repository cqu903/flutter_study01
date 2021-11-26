// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const BooksApp());
// }
//
// class Book {
//   final String title;
//   final String author;
//
//   Book(this.title, this.author);
// }
//
// class BooksApp extends StatefulWidget {
//   const BooksApp({Key? key}) : super(key: key);
//
//   @override
//   _BooksAppState createState() => _BooksAppState();
// }
//
// class _BooksAppState extends State<BooksApp> {
//   BookRouterDelegate _routerDelegate = BookRouterDelegate();
//   BookRouteInformationParser _routeInformationParser =
//   BookRouteInformationParser();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//         title: 'Books App',
//         routeInformationParser: _routeInformationParser,
//         routerDelegate: _routerDelegate);
//   }
// }
//
// class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
//   @override
//   Future<BookRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location!);
//     if (uri.pathSegments.length == 0) {
//       return BookRoutePath.home();
//     }
//     //handle '/book/:id'
//     if (uri.pathSegments.length == 2) {
//       if (uri.pathSegments[0] != 'book') {
//         return BookRoutePath.unknown();
//       }
//       var remaining = uri.pathSegments[1];
//       var id = int.tryParse(remaining);
//       if (id == null) return BookRoutePath.unknown();
//       return BookRoutePath.details(id);
//     }
//     return BookRoutePath.unknown();
//   }
//
//   @override
//   RouteInformation? restoreRouteInformation(BookRoutePath path) {
//     if (path.isUnknown) {
//       return RouteInformation(location: '/404');
//     }
//     if (path.isHomePage) {
//       return RouteInformation(location: "/");
//     }
//     if (path.isDetailPage) {
//       return RouteInformation(location: '/book/${path.id}');
//     }
//   }
// }
//
// class BookRouterDelegate extends RouterDelegate<BookRoutePath>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
//   final GlobalKey<NavigatorState> navigatorKey;
//   Book? _selectedBook;
//   bool show404 = false;
//   List<Book> books = [
//     Book('Left Hand of Darkness', 'Ursula K. Le Guin'),
//     Book('Too Like the Lightning', 'Ada Palmer'),
//     Book('Kindred', 'Octavia E. Butler'),
//   ];
//
//   BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   BookRoutePath get currentConfiguration {
//     if (show404) {
//       return BookRoutePath.unknown();
//     }
//
//     return _selectedBook == null
//         ? BookRoutePath.home()
//         : BookRoutePath.details(books.indexOf(_selectedBook!));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       pages: [
//         MaterialPage(
//             key: ValueKey("BooksListPage"),
//             child: BookListScreen(
//               books: books,
//               onTapped: _handleBookTapped,
//             )),
//         if (show404)
//           MaterialPage(
//             key: ValueKey('unKnownPage'),
//             child: UnknownScreen(),
//           )
//         else if (_selectedBook != null)
//           BookDetailPage(_selectedBook!)
//       ],
//       onPopPage: (route, result) {
//         if (!route.didPop(result)) {
//           return false;
//         }
//         _selectedBook = null;
//         show404 = false;
//         notifyListeners();
//         return true;
//       },
//     );
//   }
//
//   @override
//   Future<void> setNewRoutePath(BookRoutePath path) async {
//     if (path.isUnknown) {
//       _selectedBook = null;
//       show404 = true;
//       return;
//     }
//     if (path.isDetailPage) {
//       var realiId = path.id!;
//       if (realiId < 0 || realiId > books.length - 1) {
//         show404 = true;
//         return;
//       }
//       _selectedBook = books[realiId];
//     } else {
//       _selectedBook = null;
//     }
//     show404 = false;
//   }
//
//   void _handleBookTapped(Book book) {
//     _selectedBook = book;
//     notifyListeners();
//   }
// }
//
// class BookDetailPage extends Page {
//   final Book book;
//
//   BookDetailPage(
//       this.book,
//       ) : super(key: ValueKey(book));
//
//   @override
//   Route createRoute(BuildContext context) {
//     return MaterialPageRoute(
//         settings: this,
//         builder: (context) {
//           return BookDetailScreen(book: book);
//         });
//   }
// }
//
// class BookListScreen extends StatelessWidget {
//   final List<Book> books;
//   final dynamic onTapped;
//
//   const BookListScreen({required this.books, required this.onTapped, Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(
//           children: books
//               .map((book) => ListTile(
//             title: Text(book.title),
//             subtitle: Text(book.author),
//             onTap: () => onTapped(book),
//           ))
//               .toList()),
//     );
//   }
// }
//
// class UnknownScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Text('404!'),
//       ),
//     );
//   }
// }
//
// class BookDetailScreen extends StatelessWidget {
//   final Book book;
//
//   const BookDetailScreen({Key? key, required this.book}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(book.title, style: Theme.of(context).textTheme.headline6),
//             Text(book.author, style: Theme.of(context).textTheme.subtitle1),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class BookRoutePath {
//   final int? id;
//   final bool isUnknown;
//
//   BookRoutePath.home()
//       : id = null,
//         isUnknown = false;
//
//   BookRoutePath.details(this.id) : isUnknown = false;
//
//   BookRoutePath.unknown()
//       : id = null,
//         isUnknown = true;
//
//   bool get isHomePage => id == null;
//
//   bool get isDetailPage => id != null;
// }
//
