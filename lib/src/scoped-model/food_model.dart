import 'dart:convert';
import 'package:food_app/src/models/food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class FoodModel extends Model {
  List<Food> _foods = [];

  List<Food> get foods {
    return List.from(_foods);
  }

  void addFood(Food food) {
    _foods.add(food);
  }

  void fetchFoods() {
    http
        .get("http://192.168.1.107/flutter_food_app/api/foods/getFoods.php")
        .then((http.Response response) {
      //print("Fetching data: ${response.body}");
      final List fetchedData = json.decode(response.body);
      final List<Food> fetchedFoodItems = [];
      //print(fetchedData);
      fetchedData.forEach((data) {
        Food food = Food(
          id: data["id"],
          name: data["title"],
          price: double.parse(data["price"]),
          discount: double.parse(data["discount"]),
          category: data["category_id"],
          imagePath: data["image_path"],
        );
        fetchedFoodItems.add(food);
      });
      _foods = fetchedFoodItems;
    });
  }
}