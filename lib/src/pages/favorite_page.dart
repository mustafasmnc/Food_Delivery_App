import 'package:flutter/material.dart';
import 'package:food_app/src/models/food_model.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/food_card_item.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            model.fetchFoods();
            List<Food> foods = model.foods;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: foods.map((Food food) {
                  return FoodItemCard(
                    food.name,
                    food.description,
                    food.price.toString(),
                  );
                }).toList(),
              ),
            );
          },
        ));
  }
}

/*Container(  
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            model.fetchFoods();
            List<Food> foods = model.foods;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: foods.map((Food food) {
                return FoodItemCard(
                  food.name,
                  food.description,
                  food.price.toString(),
                );
              }).toList(),
            );
          },
        ),
      ),*/
