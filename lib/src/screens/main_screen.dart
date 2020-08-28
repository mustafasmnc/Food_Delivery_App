import 'package:flutter/material.dart';
import 'package:food_app/src/pages/favorite_page.dart';
import 'package:food_app/src/pages/home_page.dart';
import 'package:food_app/src/pages/order_page.dart';
import 'package:food_app/src/pages/profile_page.dart';
import 'package:food_app/src/scoped-model/main_model.dart';

//Pages
import '../pages/home_page.dart';

class MainScreen extends StatefulWidget {
  final MainModel model;

  MainScreen({this.model});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;
  List<Widget> pages;
  Widget currentPage;

  //Pages
  HomePage homePage;
  OrderPage orderPage;
  FavoritePage favoritePage;
  ProfilePage profilePage;

  @override
  void initState() {
    //call the fetch method on food
    widget.model.fetchFoods();
    
    homePage = HomePage();
    orderPage = OrderPage();
    favoritePage = FavoritePage();
    profilePage = ProfilePage();
    pages = [homePage, orderPage, favoritePage, profilePage];

    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Orders")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text("Favorite")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profile"))
        ],
      ),
      body: currentPage,
    );
  }
}
