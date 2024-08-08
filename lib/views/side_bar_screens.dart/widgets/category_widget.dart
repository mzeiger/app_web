import 'package:app_web/controllers/category_controller.dart';
import 'package:app_web/models/category.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  // A future that will hold list of categories
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategiories();
  }

  @override
  Widget build(BuildContext context) {
    // snapshot is the data
    return FutureBuilder(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.red));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Categories'),
            );
          } else {
            final categories = snapshot.data!;
            return dataDisplay(categories);
          }
        });
  }

  Widget dataDisplay(List<Category> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GridView.builder(
        itemCount: categories.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: <Widget>[
              Image.network(category.image, height: 100, width: 100),
              Text(category.name),
            ],
          );
        }, // itembuilder
      ),
    );
  }
}
