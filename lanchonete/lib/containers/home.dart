import 'package:flutter/material.dart';
import 'package:lanchonete/containers/widgets/main.dart';
import 'package:lanchonete/core/model/main.dart';

class Home extends StatelessWidget {
  final List<CardImageItem> categories;
  final List<BottomNavigatorItem> menus;
  final List<CardImageItem> banners;

  const Home({
    required this.categories,
    required this.menus,
    required this.banners,
  });

  List<BottomNavigationBarItem> _buildBottomIcon() => menus
      .map((menu) => BottomNavigationBarItem(
            icon: Icon(menu.icon, color: Colors.black),
            label: Text(menu.text, style: TextStyle(color: Colors.black)).toString(),
          ))
      .toList();

  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      title: 'Ifood Flutter',
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: ListView(
          children: <Widget>[
            Location(),
            Search(),
            BannerSlide(items: banners),
            Categories(items: categories),
            GourmetRestaurants(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 4,
          items: _buildBottomIcon(),
        ),
      ),
    );
  }
}
