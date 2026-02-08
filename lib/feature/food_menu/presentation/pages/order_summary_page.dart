import 'package:flutter/material.dart';
import '../../data/model/food_model.dart';
import '../widget/order_item.dart';
import '../widget/place_order.dart';

class OrderSummaryScreen extends StatefulWidget {
  final List<FoodModel> selectedItems;

  const OrderSummaryScreen({super.key, required this.selectedItems});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  List<FoodModel> items = [];

  @override
  void initState() {
    super.initState();
    items = widget.selectedItems.map((e) => e.copyWith()).toList();
  }

  double getTotalAmount() {
    double total = 0;
    for (var item in items) {
      total += (double.tryParse(item.price) ?? 0) * item.quantity;
    }
    return total;
  }

  int getTotalItems() {
    return items.fold(0, (total, item) => total + item.quantity);
  }

  void updateQuantity(FoodModel item, int change) {
    setState(() {
      item.quantity = (item.quantity + change).clamp(0, 999);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>
              Navigator.pop(context, items), // pass back updated items
        ),
        title: const Text(
          'Order Summary',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1B4D1B),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${items.length} Dishes - ${getTotalItems()} Items',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  ...items.map(
                    (food) => Column(
                      children: [
                        OrderItem(
                          food: food,
                          onQuantityChanged: () {
                            setState(() {});
                          },
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'INR ${getTotalAmount().toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          PlaceOrderWidget(),
        ],
      ),
    );
  }
}
