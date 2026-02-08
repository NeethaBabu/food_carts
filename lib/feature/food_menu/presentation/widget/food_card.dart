import 'package:dish_categories_app/feature/food_menu/presentation/widget/quality_button.dart';
import 'package:flutter/material.dart';

import '../../data/model/food_model.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onQuantityChanged;

  const FoodCard({
    super.key,
    required this.food,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 12,
                        color: food.isVeg ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          food.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "INR ${food.price}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    food.description,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      QuantityButton(
                        icon: Icons.remove,
                        onPressed: () {
                          if (food.quantity > 0) {
                            food.quantity--;
                            onQuantityChanged();
                          }
                        },
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${food.quantity}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 12),
                      QuantityButton(
                        icon: Icons.add,
                        onPressed: () {
                          food.quantity++;
                          onQuantityChanged();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if (food.addons.isNotEmpty || food.customizationsAvailable)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFF1F1F1),
                      ),
                      child: const Text(
                        "Customizations Available",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  food.calories,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    food.image,
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
