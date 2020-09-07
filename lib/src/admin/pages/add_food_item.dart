import 'package:flutter/material.dart';
import 'package:food_app/src/models/food_model.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/button.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFoodItem extends StatefulWidget {
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  String title;
  String category;
  String description;
  String price;
  String discount;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      //bottomNavigationBar: Button(btnText: "Add Food Item"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 60, horizontal: 16),
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height,
          child: Form(
            key: _foodItemFormKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/images/noimage.png"))),
                ),
                _buildTextFormField("Food Title"),
                _buildTextFormField("Category"),
                _buildTextFormField("Description", maxLine: 3),
                _buildTextFormField("Price"),
                _buildTextFormField("Discount"),
                SizedBox(height: 20),
                ScopedModelDescendant(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return GestureDetector(
                    onTap: () {
                      onSubmit(model.addFood);
                      if (model.isLoading) {
                        //show loading progress indicator
                        showLoadingIndicator();
                      }
                    },
                    child: Button(btnText: "Add Food Item"),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function addFood) async {
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      final Food food = Food(
        name: title,
        category: category,
        description: description,
        price: double.parse(price),
        discount: double.parse(discount),
      );
      bool value = await addFood(food);
      if (value) {
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
          content: Text("Food Succesfully Added"),
        );
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      } else if (!value) {
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
          content: Text("Failed to Add Food"),
        );
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  Future<void> showLoadingIndicator() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10),
                Text("Adding Food Item..."),
              ],
            ),
          );
        });
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(), labelText: hint,
        //hintText: "$hint",
      ),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        if (value.isEmpty && hint == "Food Title") {
          return "The Food Title is Required";
        }
        if (value.isEmpty && hint == "Category") {
          return "The Category is Required";
        }
        if (value.isEmpty && hint == "Description") {
          return "The Description is Required";
        }
        if (value.isEmpty && hint == "Price") {
          return "The Price is Required";
        }
        if (value.isEmpty && hint == "Discount") {
          return "The Discount is Required";
        }
      },
      onChanged: (String value) {
        if (hint == "Food Title") {
          title = value;
        }
        if (hint == "Category") {
          category = value;
        }
        if (hint == "Description") {
          description = value;
        }
        if (hint == "Price") {
          price = value;
        }
        if (hint == "Discount") {
          discount = value;
        }
      },
    );
  }
}
