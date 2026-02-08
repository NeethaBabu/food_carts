import 'package:dish_categories_app/feature/food_menu/presentation/widget/quality_button.dart';
import 'package:flutter/material.dart';

import '../../data/model/food_model.dart';
import '../pages/food_menu.dart';

class OrderItem extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onQuantityChanged;

  const OrderItem({
    super.key,
    required this.food,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                    const SizedBox(width: 8),
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
                Text("INR ${food.price}"),
                const SizedBox(height: 4),
                Text(
                  "${food.calories} calories",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                  const SizedBox(width: 8),
                  Text("${food.quantity}"),
                  const SizedBox(width: 8),
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
              Text(
                "INR ${(double.tryParse(food.price) ?? 0 * food.quantity).toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
