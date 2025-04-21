import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/food.dart'; 

class FirebaseUploader {
  static Future<void> uploadMenu(List<Food> menu) async {
    final firestore = FirebaseFirestore.instance;

    for (var food in menu) {
      await firestore.collection('foods').add({
        'name': food.name,
        'description': food.description,
        'imagePath': food.imagePath,
        'price': food.price,
        'category': food.catagory.toString().split('.').last,
        'availableAddons': food.availableAddons.map((addon) => {
              'name': addon.name,
              'price': addon.price,
            }).toList(),
      });
    }
  }
}
