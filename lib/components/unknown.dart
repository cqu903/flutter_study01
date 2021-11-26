import 'package:flutter/material.dart';
class UnknownPage extends StatelessWidget {
  final String url;

  const UnknownPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('未知的URL：$url'));
  }
}
