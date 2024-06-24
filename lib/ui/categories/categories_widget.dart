import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/search_provider.dart';
import 'category.dart';
import 'category_item.dart';

typedef OnCategoryClicked = Function(Category category);

class CategoriesWidget extends StatelessWidget {
  final OnCategoryClicked onCategoryClicked;
  CategoriesWidget(this.onCategoryClicked, {super.key});
  final List<Category> categoryList = Category.getAllCategories();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Pick your category".tr(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 35),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 24, crossAxisSpacing: 20),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      onCategoryClicked(categoryList[index]);
                      provider.viewSearchIcon();
                    },
                    child: CategoryItem(categoryList[index], index));
              },
              itemCount: categoryList.length,
            ),
          ),
        ],
      ),
    );
  }
}
