import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';
 
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
import 'package:lnFoot_api/api.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDto product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedSize;
  Color? _selectedColor;
  bool _isFavorite = false;
  ProductDto? _loadedProduct;

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
    // _isFavorite = widget.product.isFavorite ?? false; // isFavorite n'est pas dans ProductDto
    _isFavorite = false; // Initialiser à false par défaut
    context.read<ProductBloc>().add(LoadProductById(widget.product.id!));
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
        'Added to cart: ${_loadedProduct!.name}, Size: $_selectedSize, Color: ${availableColorsMap[_selectedColor] ?? _selectedColor}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_loadedProduct!.name} ajouté au panier !'),
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
        '';

    return Scaffold(
      appBar: CustomAppBar(
          title: 'Détails du produit',
          onBackButtonPressed: () => Navigator.pop(context)),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return ProductDetailsLoadingView();
          } else if (state is ProductLoaded) {
            final product = state.product;
            setState(() {
              _loadedProduct = product;
            });
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  ProductImageSection(
                    imageUrl: product.imageUrl ?? '',
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
                          name: product.name ?? '',
                          price: (product.price ?? 0).toDouble(),
                         rating:  0, // rating n'est pas dans ProductDto
                           reviewCount:  0, // reviewCount n'est pas dans ProductDto
                        ),
                        SizedBox(height: 16),
                        Divider(thickness: 0.4),
                        SizedBox(height: 16),
                        ProductDescriptionSection(
                            description: product.description ?? ''),
                        SizedBox(height: 16),
                        Divider(thickness: 0.4),
                        SizedBox(height: 16),
                        SizeSelector(
                          availableSizes: product.sizes ?? [],
                          selectedSize: _selectedSize,
                          onSizeSelected: _handleSizeSelected,
                        ),
                        SizedBox(height: 24),
                        ColorSelector(
                          availableColors: availableColorValues,
                          selectedColor: _selectedColor,
                          onColorSelected: _handleColorSelected,
                          initialColorName: initialColorName,
                        ),
                        SizedBox(height: 16),
                        Divider(thickness: 0.4),
                        SizedBox(height: 16),
                        ReviewsSection(),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProductError) {
            return Center(
              child: Text('Erreur: ${state.message}'),
            );
          }
          return ProductDetailsLoadingView();
        },
      ),
      bottomSheet: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return LoadingBottomSheet();
          }
          return AddToCartSection(
            onAddToCart: _handleAddToCart,
            canAddToCart: canAddToCart,
          );
        },
      ),
    );
  }
}
