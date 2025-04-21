import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/food.dart';

class FoodService {
  final CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('foods');

  Future<List<Food>> fetchFoodItems() async {
    final snapshot = await foodCollection.get();
    return snapshot.docs
        .map((doc) => Food.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
