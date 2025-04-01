import 'package:flutter/material.dart';
import 'package:ln_foot/widgets/custom_button.dart'; 

class AddToCartSection extends StatelessWidget {
  final VoidCallback onAddToCart;
  final bool canAddToCart; 
  final String title;

  const AddToCartSection({
    super.key,
    required this.onAddToCart,
    this.canAddToCart = true, 
    this.title = 'Ajouter au panier',
  }) ;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0 + MediaQuery.of(context).padding.bottom), // Add padding for safe area (Removed const)
      decoration: BoxDecoration(
        color: Colors.white, // Or theme.bottomSheetTheme.backgroundColor
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2), // Shadow above the container
          ),
        ],
        // Optional: Add rounded corners if desired
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(16.0),
        //   topRight: Radius.circular(16.0),
        // ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: CustomButton(
          text: title, 
          onPressed: canAddToCart ? onAddToCart : () {},
          buttonColor: canAddToCart ? theme.primaryColor : Colors.grey, 
          textColor: Colors.white,
        ),
      ),
    );
  }
}
