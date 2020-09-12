import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/src/admin/pages/add_food_item.dart';
import 'package:food_app/src/models/food_model.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/food_card_item.dart';
import 'package:food_app/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatefulWidget {
  final MainModel model;
  const FavoritePage({this.model});
  //firebase ile otomatik güncelleme için

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isDeleteFood = false;
  //the scaffold global key
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.model.fetchFoods();
  }
  //firebase ile otomatik güncelleme için

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _explorePageScaffoldKey,
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext sctx, Widget child, MainModel model) {
            //model.fetchFoods(); //this will fetch and notifylistener() | firebase ile otomatik güncelleme için
            //List<Food> foods = model.foods;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: model.fetchFoods,
                child: ListView.builder(
                  itemCount: model.foodLenght,
                  itemBuilder: (BuildContext lctx, int index) {
                    return GestureDetector(
                      onTap: () async {
                        final bool response =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext mctx) => AddFoodItem(
                                      food: model.foods[index],
                                    )));
                        if (response) {
                          SnackBar snackBar = SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Theme.of(context).primaryColor,
                            content: Text(
                              "Food Succesfully Updated",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          );
                          _explorePageScaffoldKey.currentState
                              .showSnackBar(snackBar);
                        }
                      },
                      onDoubleTap: () {
                        //delete food
                        showLoadingIndicator(context, "Deleting Food");
                        model
                            .deleteFood(model.foods[index].id)
                            .then((bool response) {
                          Navigator.of(context).pop();
                        });

                        /*_showDialog(context);
                        if (isDeleteFood) {
                          print(isDeleteFood);
                          showLoadingIndicator(context, "Deleting Food");
                          model
                              .deleteFood(model.foods[index].id)
                              .then((bool response) {
                            Navigator.of(context).pop();
                          });

                        setState(() {
                          isDeleteFood = false;
                        });
                        }*/
                      },
                      child: FoodItemCard(
                        model.foods[index].name,
                        model.foods[index].description,
                        model.foods[index].price.toString(),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ));
  }

// user defined function
/*  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //title:  Text("Alert Dialog title"),
          content: Text("Are You Sure"),
          actions: [
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                setState(() {
                  isDeleteFood = true;
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/
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
