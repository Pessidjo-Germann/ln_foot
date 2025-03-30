import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool isSearching;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap, onSubmit;
  final bool isClickable;

  const SearchBarWidget({
    super.key,
    this.controller,
    this.isSearching = false,
    this.onClear,
    this.onFilterTap,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isClickable) {
      // Version cliquable (pour HomeScreen)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey.shade800),
                const SizedBox(width: 12),
                Text(
                  'Trouvez vos articles préférés',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'images/elements.svg',
                  height: 24,
                  colorFilter: ColorFilter.mode(Colors.grey.shade800, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Version interactive (pour SearchScreen)
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.3),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Trouvez vos articles préférés',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Colors.grey.shade800),
            suffixIcon: isSearching
                ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey.shade800),
                    onPressed: onClear,
                  )
                : IconButton(
                    icon: SvgPicture.asset(
                      'images/elements.svg',
                      height: 24,
                      colorFilter: ColorFilter.mode(Colors.grey.shade800, BlendMode.srcIn),
                    ),
                    onPressed: onFilterTap,
                  ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onChanged: onChanged,
          onSubmitted: (_)=>onSubmit?.call(),

        ),
      ),
    );
  }
}