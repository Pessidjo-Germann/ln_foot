import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';
import 'package:ln_foot/bloc/colored_product/colored_product_bloc.dart';
import 'package:ln_foot/bloc/review/review_bloc.dart';
import 'package:ln_foot/bloc/cart/cart_bloc.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/product_details/loading_bottom_sheet.dart';
import 'package:ln_foot/widgets/product_details/product_details_loading.dart';
import 'package:ln_foot/widgets/product_details/product_image_section.dart';
import 'package:ln_foot/widgets/product_details/product_info_section.dart';
import 'package:ln_foot/widgets/product_details/product_description_section.dart';
import 'package:ln_foot/widgets/product_details/size_selector.dart';
import 'package:ln_foot/widgets/product_details/color_selector.dart';
import 'package:ln_foot/widgets/product_details/add_to_cart_section.dart';
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

  // Replace static color map and color logic with dynamic colors from ColoredProductBloc
  late List<ColoredProductDto> _coloredProducts = [];
  late Map<Color, String> _availableColorsMap = {};
  List<ReviewDto> reviews = [];
  Color? _colorFromNameOrCode(String? name) {
    // TODO: Map backend color name/code to Flutter Color
    switch (name?.toLowerCase()) {
      case 'rouge':
      case 'red':
        return Colors.red;
      case 'noir':
      case 'black':
        return Colors.black;
      case 'bleu':
      case 'blue':
        return Colors.blue;
      case 'rose':
      case 'pink':
        return Colors.pink;
      case 'violet':
      case 'purple':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    _isFavorite = false;
    context.read<ProductBloc>().add(LoadProductById(widget.product.id!));
    // Charger dynamiquement les couleurs pour ce produit
    context.read<ColoredProductBloc>().add(LoadColoredProducts());
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
    });
  }

  void _handleAddToCart(ProductDto product) {
    if (_selectedSize == null || _selectedColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une taille et une couleur.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final colorName = _availableColorsMap[_selectedColor] ?? '';
    context.read<CartBloc>().add(
          AddToCart(
            product: product,
            size: _selectedSize!,
            color: colorName,
            quantity: 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final bool canAddToCart = _selectedSize != null && _selectedColor != null;
    final List<Color> availableColorValues = _availableColorsMap.keys.toList();
    final String initialColorName = _availableColorsMap[
            availableColorValues.isNotEmpty
                ? availableColorValues.first
                : Colors.grey] ??
        '';

    return Scaffold(
      appBar: CustomAppBar(
          title: 'Détails du produit',
          onBackButtonPressed: () => Navigator.pop(context)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.product.name} ajouté au panier !'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else if (state is CartError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erreur: ${state.message}'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          BlocListener<ColoredProductBloc, ColoredProductState>(
            listener: (context, state) {
              if (state is ColoredProductsLoaded) {
                setState(() {
                  _coloredProducts = state.coloredProducts
                      .where((c) => c.productId == widget.product.id)
                      .toList();
                  _availableColorsMap = {
                    for (var c in _coloredProducts)
                      if (_colorFromNameOrCode(c.name) != null)
                        _colorFromNameOrCode(c.name)!: c.name ?? ''
                  };
                });
              }
            },
          ),
          BlocListener<ReviewBloc, ReviewState>(
            listener: (context, state) {
              if (state is ReviewsLoaded) {
                setState(() {
                  // Handle loaded reviews if needed
                  reviews = state.reviews;
                });
              }
            },
          ),
        ],
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const ProductDetailsLoadingView();
            } else if (state is ProductLoaded) {
              final product = widget.product;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ProductImageSection(
                      imageUrl: product.imageUrl!,
                      product: product,
                      initialIsFavorite: _isFavorite,
                      onFavoriteToggle: _handleFavoriteToggle,
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductInfoSection(
                            name: product.name ?? '',
                            price: product.price.toDouble(),
                            rating: 0,
                            reviewCount: 0,
                            productId: product.id!,
                          ),
                          const SizedBox(height: 16),
                          // const Divider(thickness: 0.4),
                          const SizedBox(height: 16),
                          ProductDescriptionSection(
                              description: product.description ?? ''),
                          const SizedBox(height: 16),
                          const Divider(thickness: 0.15),
                          const SizedBox(height: 16),
                          SizeSelector(
                            availableSizes: product.sizes,
                            selectedSize: _selectedSize,
                            onSizeSelected: _handleSizeSelected,
                          ),
                          const SizedBox(height: 24),
                          ColorSelector(
                            availableColors: availableColorValues,
                            selectedColor: _selectedColor,
                            onColorSelected: _handleColorSelected,
                            initialColorName: initialColorName,
                          ),
                          const SizedBox(height: 16),
                          const Divider(thickness: 0.1),

                          // ReviewsSection(productId: product.id!),
                          const SizedBox(height: 100),
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
            return const ProductDetailsLoadingView();
          },
        ),
      ),
      bottomSheet: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const LoadingBottomSheet();
          } else if (state is ProductLoaded) {
            return AddToCartSection(
              onAddToCart: () => _handleAddToCart(state.product),
              canAddToCart: canAddToCart,
            );
          }
          return const LoadingBottomSheet();
        },
      ),
    );
  }
}
