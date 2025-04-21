// food.dart

enum FoodCatagory {
  bugers,
  pizza,
  salads,
  sides,
  desserts,
  drinks,
}

class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });

  factory Addon.fromMap(Map<String, dynamic> map) {
    return Addon(
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}

class Food {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCatagory catagory;
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.catagory,
    required this.availableAddons,
  });

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imagePath: map['imagePath'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      catagory: _getCategoryFromString(map['catagory'] ?? 'pizza'),
      availableAddons: map['availableAddons'] != null
          ? List<Addon>.from(
              (map['availableAddons'] as List)
                  .map((addonMap) => Addon.fromMap(addonMap)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'price': price,
      'catagory': catagory.name,
      'availableAddons': availableAddons.map((addon) => addon.toMap()).toList(),
    };
  }

  static FoodCatagory _getCategoryFromString(String category) {
    return FoodCatagory.values.firstWhere(
      (e) => e.name.toLowerCase() == category.toLowerCase(),
      orElse: () => FoodCatagory.pizza,
    );
  }
}
