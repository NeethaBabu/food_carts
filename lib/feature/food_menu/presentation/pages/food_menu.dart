import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/food_bloc.dart';
import '../widget/app_drawer.dart';
import '../widget/category_tab.dart';
import '../widget/food_card.dart';
import 'order_summary_page.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  int selectedIndex = 0;

  int getCartCount(FoodState state) {
    if (state is FoodLoaded) {
      return state.items.where((item) => item.quantity > 0).length;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    context.read<FoodBloc>().add(FetchFoodMenu());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        final selectedItems =
                            (context.read<FoodBloc>().state as FoodLoaded).items
                                .where((item) => item.quantity > 0)
                                .toList();

                        if (selectedItems.isEmpty) return;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderSummaryScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        "${getCartCount(state)}",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FoodError) {
            return Center(child: Text(state.message));
          }

          if (state is FoodLoaded) {
            print("All items from API nee 1st:${state.items}");
            final items = state.items;
            if (items.isEmpty) {
              return const Center(child: Text("No items available"));
            }

            final categories = items.map((e) => e.category).toSet().toList();

            final filteredItems = items
                .where((e) => e.category == categories[selectedIndex])
                .toList();

            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: List.generate(categories.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedIndex = index);
                          },
                          child: CategoryTab(
                            title: categories[index],
                            isSelected: selectedIndex == index,
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: filteredItems.isEmpty
                      ? const Center(child: Text("No items in this category"))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: filteredItems.length,
                          itemBuilder: (_, i) {
                            final food = filteredItems[i];
                            return FoodCard(
                              food: food,
                              onQuantityChanged: () {
                                setState(() {});
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
