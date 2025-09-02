import 'package:flutter/material.dart';

class OrderStatusTabs extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const OrderStatusTabs({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = Theme.of(context).colorScheme.primary;
    final Color unselectedColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
   // Example background

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:  selectedColor.withOpacity(0.4),
      ),
     // color: selectedColor.withOpacity(0.4),
      child: TabBar(
        controller: tabController,
     
        labelColor: Colors.black,
        unselectedLabelColor: unselectedColor,
        indicator: BoxDecoration(

          borderRadius: BorderRadius.circular(15),
          color: Colors.white,

        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: 'En cours'),
          Tab(text: 'Terminées'),
          Tab(text: 'Annulées'),
        ],
        dividerColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kTextTabBarHeight + 16.0); // Standard height + padding
}
