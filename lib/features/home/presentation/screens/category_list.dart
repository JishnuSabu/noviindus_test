import 'package:flutter/material.dart';
import 'package:noviindus_test/features/home/presentation/provider/home_provider.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/cm_container.dart';

class CategoryList extends StatelessWidget {
  final HomeProvider provider;
  const CategoryList({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              children: [
                CmContainer(
                  text: "Explore",
                  bgColor: const Color(0xFFC70000).withOpacity(0.2),
                ),
                VerticalDivider(color: Color(0xFFEDEDED), thickness: 0.5),
              ],
            );
          }
          final category = provider.categories[index - 1];

          return Container(
            margin: const EdgeInsets.only(right: 8, left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFFFFFFF), width: 0.7),
            ),
            child: Text(
              category.title[0].toUpperCase() +
                  category.title.substring(1).toLowerCase(),
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}
