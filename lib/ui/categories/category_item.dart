import 'package:flutter/material.dart';

import 'category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final int index;
  const CategoryItem(this.category, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(24),
            topLeft: const Radius.circular(24),
            bottomRight: Radius.circular(index.isOdd ? 24 : 0),
            bottomLeft: Radius.circular(index.isEven ? 24 : 0),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            category.imageName,
            height: 120,
            fit: BoxFit.fitWidth,
          ),
          // const SizedBox(height: 11),
          Text(
            category.title,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
