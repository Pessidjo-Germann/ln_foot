import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/product/product_bloc.dart';
import 'package:ln_foot/bloc/review/review_bloc.dart';
import 'package:ln_foot/bloc/cart/cart_bloc.dart';
import 'package:ln_foot/bloc/saved_items/saved_items_bloc.dart';
import 'package:ln_foot/model/saved_product_dto.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
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
  final String? selectedVariantId;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.selectedVariantId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedSize;
  List<ProductVariantDto> _productVariants = [];
  ProductVariantDto? _selectedVariant;
  List<ReviewDto> reviews = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductVariantById(widget.product.id!));
  }

  void _handleSizeSelected(String? size) {
    setState(() {
      _selectedSize = size;
    });
  }

  void _handleFavoriteToggle() {
    final savedItemsState = context.read<SavedItemsBloc>().state;
    if (savedItemsState is SavedItemsLoaded) {
      final isCurrentlyFavorite = savedItemsState.items
          .any((item) => item.product.id == widget.product.id);

      if (isCurrentlyFavorite) {
        // Remove from favorites
        context.read<SavedItemsBloc>().add(RemoveSavedItem(widget.product.id!));
      } else {
        // Add to favorites with selected variant information
        final savedProduct = SavedProductDto(
          product: widget.product,
          selectedVariantId: _selectedVariant?.id,
          variantImageUrl: _selectedVariant?.imageUrl,
        );
        context.read<SavedItemsBloc>().add(AddSavedItem(savedProduct));
      }
    }

    // Pas besoin de setState ici car le BlocBuilder se met à jour automatiquement
  }

  void _handleVariantSelected(ProductVariantDto variant) {
    setState(() {
      _selectedVariant = variant;
      if (variant.sizes.isNotEmpty &&
          (_selectedSize == null || !variant.sizes.contains(_selectedSize))) {
        _selectedSize = null;
      } else if (variant.sizes.isEmpty) {
        _selectedSize = null;
      }
    });
  }

  void _handleAddToCart(ProductDto product) {
    // if (_selectedSize == null || _selectedColor == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Veuillez sélectionner une taille et une couleur.'),
    //       duration: Duration(seconds: 2),
    //     ),
    //   );
    //   return;
    // }

    debugPrint(product.toString());
    final String colorName = _selectedVariant?.colorCode ?? '';
    context.read<CartBloc>().add(
          AddToCart(
            product: product,
            size:
                _selectedSize!, 
            color: colorName,
            quantity: 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // final bool canAddToCart = _selectedSize != null || _selectedColor != null; // Updated canAddToCart logic
    final bool canAddToCart = _selectedSize != null && _selectedVariant != null;

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
          // BlocListener<ColoredProductBloc, ColoredProductState>(
          //   listener: (context, state) {
          //     if (state is ColoredProductsLoaded) {
          //       setState(() {
          //         _coloredProducts = state.coloredProducts
          //             .where((c) => c.productId == widget.product.id)
          //             .toList();
          //         _availableColorsMap = {
          //           for (var c in _coloredProducts)
          //             if (_colorFromNameOrCode(c.name) != null)
          //               _colorFromNameOrCode(c.name)!: c.name ?? ''
          //         };
          //       });
          //     }
          //   },
          // ),
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
            } else if (state is ProductVariantsLoaded) {
              if (_productVariants != state.variants) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _productVariants = state.variants;
                      if (_productVariants.isNotEmpty) {
                        // If we have a selectedVariantId from favorites, try to find it
                        if (widget.selectedVariantId != null) {
                          final targetVariant = _productVariants
                              .cast<ProductVariantDto?>()
                              .firstWhere(
                                  (v) => v?.id == widget.selectedVariantId,
                                  orElse: () => null);
                          _selectedVariant =
                              targetVariant ?? _productVariants.first;
                        } else {
                          final currentSelectedId = _selectedVariant?.id;
                          _selectedVariant = _productVariants.first;
                          if (currentSelectedId != null) {
                            final previouslySelected = _productVariants
                                .cast<ProductVariantDto?>()
                                .firstWhere((v) => v?.id == currentSelectedId,
                                    orElse: () => null);
                            if (previouslySelected != null) {
                              _selectedVariant = previouslySelected;
                            }
                          }
                        }
                      } else {
                        _selectedVariant = null;
                      }
                    });
                  }
                });
              }

              if (_selectedVariant == null) {
                // This covers initial load before post-frame callback, or if variants become empty.
                if (state.variants.isEmpty) {
                  // If API returns no variants initially or after an update
                  return const Center(
                      child: Text("No product variants available."));
                }
                // If variants are loading / _selectedVariant not yet set by post-frame callback
                return const ProductDetailsLoadingView();
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ProductImageSection(
                      imageUrl: _selectedVariant!.imageUrl!,
                      mainProductId: widget.product.id!,
                      product: ProductDto(
                          price: _selectedVariant!.price,
                          name: widget.product.name,
                          id: _selectedVariant!.id),
                       
                      onFavoriteToggle: _handleFavoriteToggle,
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductInfoSection(
                            name: widget.product.name ?? '',
                            price: _selectedVariant!.price.toDouble(),
                            rating: 0,
                            reviewCount: 0,
                            productId: _selectedVariant!.id!,
                          ),
                          const SizedBox(height: 16),
                          // const Divider(thickness: 0.4),
                          const SizedBox(height: 10),
                          ProductDescriptionSection(
                              description: widget.product.description ?? ''),
                          const SizedBox(height: 16),
                          const Divider(thickness: 0.15),
                          const SizedBox(height: 10),
                          SizeSelector(
                            availableSizes: _selectedVariant!.sizes,
                            selectedSize: _selectedSize,
                            onSizeSelected: _handleSizeSelected,
                          ),
                          const SizedBox(height: 12),
                          ColorSelector(
                            variants: _productVariants,
                            selectedVariant: _selectedVariant,
                            onVariantSelected: _handleVariantSelected,
                          ),
                          const SizedBox(height: 12),
                          const Divider(thickness: 0.1),

                          // ReviewsSection(productId: product.id!),
                          const SizedBox(height: 10),
                          // Ajouter un padding en bas pour éviter que le contenu soit masqué par le bouton
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
      persistentFooterButtons: [
        SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 8.0,
              bottom: MediaQuery.of(context).padding.bottom > 0 ? 4.0 : 8.0,
            ),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (_selectedVariant == null) {
                  return const SizedBox(
                    height: 56,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return AddToCartSection(
                  onAddToCart: () {
                    _handleAddToCart(ProductDto(
                        price: _selectedVariant!.price,
                        name: widget.product.name,
                        stockQuantity: _selectedVariant!.stockQuantity,
                        description: widget.product.description,
                        categoryNames: widget.product.categoryNames,
                        sizes: _selectedVariant!.sizes,
                        imageUrl: _selectedVariant!.imageUrl,
                        id: _selectedVariant!.id));
                  },
                  canAddToCart: canAddToCart,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
