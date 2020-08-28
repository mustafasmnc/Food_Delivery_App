import 'package:flutter/material.dart';
import 'package:food_app/src/scoped-model/food_model.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/bought_food.dart';
import 'package:food_app/src/widgets/food_card.dart';
import 'package:food_app/src/widgets/food_category.dart';
import 'package:food_app/src/widgets/home_dart_info.dart';
import 'package:food_app/src/widgets/search_field.dart';
import 'package:scoped_model/scoped_model.dart';
//data
import '../data/food_data.dart';
import '../models/food_model.dart';

class HomePage extends StatefulWidget {
  //final FoodModel foodModel=new FoodModel();

  //HomePage({this.foodModel});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Food> _foods = foods;
  @override
  void initState() {
    //widget.foodModel.fetchFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 30, left: 10, right: 10),
        children: [
          HomeTopInfo(),
          FoodCategory(),
          SizedBox(height: 10),
          SearchField(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Frequently Bought Food",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return Column(
              children: model.foods.map(_buildFoodItems).toList(),
            );
          })
        ],
      ),
    );
  }
}

Widget _buildFoodItems(Food food) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: BoughtFood(
      id: food.id,
      name: food.name,
      imagePath: food.imagePath,
      category: food.category,
      discount: food.discount,
      price: food.price,
      ratings: food.ratings,
    ),
  );
}
