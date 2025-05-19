import 'package:flutter/material.dart';
import 'package:ln_foot/bloc/cart/cart_bloc.dart';
import 'package:ln_foot/widgets/cart/remove_item.dart';

class CartItemData {
  final String id;
  final String image;
  final String name;
  final String size;
  final double price;
  final int quantity;

  const CartItemData({
    required this.id,
    required this.image,
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
  });
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;
  final VoidCallback onRemoveItem;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priceStyle =
        theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final detailStyle =
        theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]);

    return Dismissible(
      key: Key(item.product.id!),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onRemoveItem();
      },
      confirmDismiss: (direction) async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) {
            return RemoveCartItemDialog(
                item: item,
                onConfirm: () => Navigator.of(context).pop(true),
                onCancel: () => Navigator.of(context).pop(false));
          },
        );

        return result;
      },
      background: Container(
        color: Colors.red[100],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(Icons.delete_outline, color: Colors.red),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item.product.imageUrl!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey[200],
                  child:
                      Icon(Icons.image_not_supported, color: Colors.grey[400]),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.name!, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4.0),
                  Text('Taille: ${item.size}', style: detailStyle),
                  const SizedBox(height: 8.0),
                  Text('${item.product.price.toStringAsFixed(0)}FCFA',
                      style: priceStyle), // Format as needed
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            // Quantity Controls
            _buildQuantityControls(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControls(BuildContext context) {
    return Row(
      children: [
        _buildQuantityButton(
          context: context,
          icon: Icons.remove,
          onPressed: item.quantity > 0 ? onDecreaseQuantity : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            item.quantity.toString(),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        _buildQuantityButton(
          context: context,
          icon: Icons.add,
          onPressed: onIncreaseQuantity,
          isAddButton: true,
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
    bool isAddButton = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: onPressed == null
              ? Colors.grey[300]
              : isAddButton
                  ? colorScheme.primary
                  : Colors.grey[200],
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Icon(
          icon,
          size: 18.0,
          color: onPressed == null
              ? Colors.grey[500]
              : isAddButton
                  ? colorScheme.onPrimary
                  : Colors.black,
        ),
      ),
    );
  }
}
