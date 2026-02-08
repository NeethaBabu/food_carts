class AddonModel {
  final int id;
  final String name;
  final String price;

  AddonModel({required this.id, required this.name, required this.price});

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: json['id'],
      name: json['name'] ?? "",
      price: json['price'].toString(),
    );
  }
}

class FoodModel {
  final String id;
  final String name;
  final String description;
  final String price;
  final String calories;
  final String image;
  final String category;
  final bool isVeg;
  final bool customizationsAvailable;
  final List<AddonModel> addons;

  int quantity; // NEW FIELD

  FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.calories,
    required this.image,
    required this.category,
    required this.isVeg,
    required this.customizationsAvailable,
    required this.addons,
    this.quantity = 0, // default 0
  });

  factory FoodModel.fromJson(Map<String, dynamic> json, String category) {
    final List<dynamic> addonsList = json['addons'] ?? [];
    return FoodModel(
      id: json['id'].toString(),
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      price: json['price'].toString(),
      calories: json['calories'].toString(),
      image: json['image_url'] ?? "",
      category: category,
      isVeg: json['is_veg'] ?? false,
      customizationsAvailable: json['customizations_available'] ?? false,
      addons: addonsList.map((e) => AddonModel.fromJson(e)).toList(),
      quantity: 0,
    );
  }

  FoodModel copyWith({
    String? id,
    String? name,
    String? description,
    String? price,
    String? calories,
    String? image,
    String? category,
    bool? isVeg,
    bool? customizationsAvailable,
    List<AddonModel>? addons,
    int? quantity,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      calories: calories ?? this.calories,
      image: image ?? this.image,
      category: category ?? this.category,
      isVeg: isVeg ?? this.isVeg,
      customizationsAvailable:
          customizationsAvailable ?? this.customizationsAvailable,
      addons: addons ?? this.addons,
      quantity: quantity ?? this.quantity,
    );
  }
}
