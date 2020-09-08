import 'package:flutter/material.dart';
import 'package:food_app/src/models/food_model.dart';
import 'package:food_app/src/scoped-model/main_model.dart';
import 'package:food_app/src/widgets/button.dart';
import 'package:food_app/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFoodItem extends StatefulWidget {
  final Food food;

  const AddFoodItem({this.food});

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
    return SafeArea(
      child: WillPopScope(
        onWillPop: (){
          Navigator.of(context).pop(false);
          return Future.value(true);
        },
        child: Scaffold(
          key: _scaffoldStateKey,
          appBar: AppBar(
            elevation: 0,
            title: Text(widget.food != null ? "Update Food" : "Add Food",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                }),
          ),
          //bottomNavigationBar: Button(btnText: "Add Food Item"),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
                          onSubmit(model.addFood, model.updateFood);
                          if (model.isLoading) {
                            //show loading progress indicator
                            showLoadingIndicator(
                                context,
                                widget.food != null
                                    ? "Updating Food.."
                                    : "Adding Food..");
                          }
                        },
                        child: Button(
                            btnText: widget.food != null
                                ? "Update Food"
                                : "Add Food"),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function addFood, Function updateFood) async {
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      if (widget.food != null) {
        //update food
        Map<String, dynamic> updatedFoodItem = {
          "title": title,
          "category": category,
          "description": description,
          "price": double.parse(price),
          "discount": discount != null ? double.parse(discount) : 0.0,
        };
        final bool response = await updateFood(updatedFoodItem, widget.food.id);
        if (response) {
          Navigator.of(context).pop(); //remove the alert dialog
          Navigator.of(context).pop(response); //to the previous page
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
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        } else if (!response) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text(
              "Failed to Update Food",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      } else if (widget.food == null) {
        //add new food
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
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      initialValue: widget.food != null && hint == "Food Title"
          ? widget.food.name
          : widget.food != null && hint == "Description"
              ? widget.food.description
              : widget.food != null && hint == "Category"
                  ? widget.food.category
                  : widget.food != null && hint == "Price"
                      ? widget.food.price.toString()
                      : widget.food != null && hint == "Discount"
                          ? widget.food.discount.toString()
                          : "",
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
      onSaved: (String value) {
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

  Widget _buildCategoryTextFormField() {
    return TextFormField();
  }
}
