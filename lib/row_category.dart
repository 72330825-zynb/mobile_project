import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'category.dart';

class CategorySelector extends StatefulWidget {
  final Function(Category) onSelectCategory;

  const CategorySelector({required this.onSelectCategory, super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<Category> categories = [];
  int selectedIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final res = await http.get(
        Uri.parse('http://192.168.1.108:3000/categories'),
      );

      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body) as List;
        setState(() {
          categories = data.map((e) => Category.fromMap(e)).toList();
          loading = false;

          // اختياري: خلي أول كاتيجوري محددة
          if (categories.isNotEmpty) widget.onSelectCategory(categories.first);
        });
      } else {
        loading = false;
        debugPrint('Failed to load categories: ${res.statusCode}');
      }
    } catch (e) {
      loading = false;
      debugPrint('Error loading categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onSelectCategory(categories[index]);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    categories[index].name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: isSelected
                          ? const Color(0xFF373854)
                          : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF373854),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
