import 'package:flutter/material.dart';
import 'package:noviindus_test/features/home/presentation/provider/add_feed_provider.dart';
import 'package:noviindus_test/features/home/presentation/provider/home_provider.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/cm_container.dart';
import 'package:provider/provider.dart';

class AddFeedCategoryWidget extends StatelessWidget {
  const AddFeedCategoryWidget({super.key, required this.provider});
  final AddFeedProvider provider;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories This Project',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFFD5D5D5),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFD5D5D5),
                  size: 12,
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),
        Consumer<HomeProvider>(
          builder: (context, homeProvider, _) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: homeProvider.categories.map((category) {
                final isSelected = provider.selectedCategories.contains(
                  category.id,
                );

                return GestureDetector(
                  onTap: () {
                    provider.toggleCategory(category.id);
                  },
                  child: CmContainer(
                    text:
                        category.title[0].toUpperCase() +
                        category.title.substring(1).toLowerCase(),
                    bgColor: isSelected
                        ? const Color(0xFFC70000).withOpacity(0.2)
                        : Colors.transparent,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
