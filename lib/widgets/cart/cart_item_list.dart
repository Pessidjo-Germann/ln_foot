import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'cart_item_widget.dart';

class CartItemList extends StatelessWidget {
  final List<CartItem> items;
  final Function(String itemId) onIncreaseQuantity;
  final Function(String itemId) onDecreaseQuantity;
  final Function(String itemId) onRemoveItem;

  const CartItemList({
    super.key,
    required this.items,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              SvgPicture.asset(
                'images/empty_cart.svg',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 16),
              Text(
                'Votre panier est vide.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'Lorsque vous ajoutez des produits, ils apparaîtront ici.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return CartItemWidget(
          item: item,
          onIncreaseQuantity: () => onIncreaseQuantity(item.id),
          onDecreaseQuantity: () => onDecreaseQuantity(item.id),
          onRemoveItem: () => onRemoveItem(item.id),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 0.4,
      ),
    );
  }
}
