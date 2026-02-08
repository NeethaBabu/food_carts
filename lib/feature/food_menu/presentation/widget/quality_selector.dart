import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int qty;

  const QuantitySelector({super.key, required this.qty});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1B4D1B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Icon(Icons.remove, color: Colors.white, size: 18),
          const SizedBox(width: 12),
          Text('$qty', style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 12),
          const Icon(Icons.add, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}
