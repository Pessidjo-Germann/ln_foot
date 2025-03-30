import 'package:flutter/material.dart';
import 'package:ln_foot/model/product.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/product_details/loading_bottom_sheet.dart';
import 'package:ln_foot/widgets/product_details/product_details_loading.dart';
import 'package:ln_foot/widgets/product_details/product_image_section.dart';
import 'package:ln_foot/widgets/product_details/product_info_section.dart';
import 'package:ln_foot/widgets/product_details/product_description_section.dart';
import 'package:ln_foot/widgets/product_details/size_selector.dart';
import 'package:ln_foot/widgets/product_details/color_selector.dart';
import 'package:ln_foot/widgets/product_details/add_to_cart_section.dart';
import 'package:ln_foot/widgets/product_details/reviews_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedSize;
  Color? _selectedColor;
  bool _isFavorite = false;
  bool _isLoading = true;

  final product = Product(
    name: 'Maillot',
    category: 'Vêtements',
    price: 10000.0,
    imageUrl: 'images/maillot_asset.svg',
    rating: 4.3,
    reviewCount: 16,
    isFavorite: false,
  );

  final String productDescription =
      'Conçu pour le travail ou le week-end, ce t-shirt uni se porte aussi bien habillé que décontracté et confère à toutes vos tenues le look épuré souhaité. Chaque haut est confectionné en coton confortable, avec des manches courtes et un col ras du cou.\nFacile d\'entretien, ce t-shirt peut être lavé avec des couleurs similaires en cycle délicat.\nFabriqués à partir de matériaux issus de sources responsables et fidèles à l\'esprit Gap, nos essentiels du quotidien sont disponibles dans une large gamme de coupes, de tailles, de couleurs unies et d\'imprimés. Gap défend un style américain unique et optimiste qui comble les écarts entre les individus, les générations et les cultures.';
  final List<String> availableSizes = ['S', 'M', 'L', 'XL', 'XXI'];
  final Map<Color, String> availableColorsMap = {
    Colors.red: 'Rouge',
    Colors.purple: 'Violet',
    Colors.black: 'Noir',
    Colors.blue: 'Bleu',
    Colors.pink: 'Rose',
  };

  @override
  void initState() {
    super.initState();
    _isFavorite = product.isFavorite;
    // _selectedColor = availableColorsMap.keys.first;
    _loadProductDetails();
  }

  Future<void> _loadProductDetails() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleSizeSelected(String? size) {
    setState(() {
      _selectedSize = size;
    });
  }

  void _handleColorSelected(Color? color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _handleFavoriteToggle() {
    setState(() {
      _isFavorite = !_isFavorite;
      print('Favorite toggled: $_isFavorite');
    });
  }

  void _handleAddToCart() {
    if (_selectedSize == null || _selectedColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez sélectionner une taille et une couleur.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    // TODO: Implement actual add to cart logic
    print(
        'Added to cart: ${product.name}, Size: $_selectedSize, Color: ${availableColorsMap[_selectedColor] ?? _selectedColor}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ajouté au panier !'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool canAddToCart = _selectedSize != null && _selectedColor != null;
    final List<Color> availableColorValues = availableColorsMap.keys.toList();
    final String initialColorName = availableColorsMap[
            availableColorValues.firstWhere((c) => c == Colors.black,
                orElse: () => availableColorValues.first)] ??
        ''; // Example: Default to Black name

    return Scaffold(
      appBar: CustomAppBar(title: 'Product Details'),
      body: _isLoading
          ? ProductDetailsLoadingView()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  ProductImageSection(
                    imageUrl: product.imageUrl,
                    initialIsFavorite: _isFavorite,
                    onFavoriteToggle: _handleFavoriteToggle,
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductInfoSection(
                          name: product.name,
                          price: product.price,
                          rating: product.rating,
                          reviewCount: product.reviewCount,
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        ProductDescriptionSection(
                            description: productDescription),
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        SizeSelector(
                          availableSizes: availableSizes,
                          selectedSize: _selectedSize,
                          onSizeSelected: _handleSizeSelected,
                        ),
                        SizedBox(height: 24),
                        ColorSelector(
                          availableColors: availableColorValues,
                          selectedColor: _selectedColor,
                          onColorSelected: _handleColorSelected,
                          initialColorName:
                              initialColorName, // Pass default color name
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        ReviewsSection(),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomSheet: _isLoading
          ? LoadingBottomSheet()
          : AddToCartSection(
              onAddToCart: _handleAddToCart,
              canAddToCart: canAddToCart,
            ),
    );
  }
}
