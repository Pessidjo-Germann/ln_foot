import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
       child: Material(
        elevation: 2.0, 
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white, 
        shadowColor: Colors.grey.withOpacity(0.3),  
        child: TextField(
          decoration: InputDecoration(
            hintText:
                'Trouvez vos articles préférés',  
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            prefixIcon:
                Icon(Icons.search, color: Colors.grey.shade800), // Darker icon
            suffixIcon: IconButton(
               
              icon: SvgPicture.asset(
                'images/elements.svg',
                height: 24,
                colorFilter: ColorFilter.mode(
                    Colors.grey.shade800, BlendMode.srcIn), // Darker icon
              ),
              // Corrected onPressed block
              onPressed: () {
                // TODO: Implement filter/scan action
                print('Filter/Scan icon pressed');
              },
            ),
             
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
             
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          // Moved onChanged inside TextField
          onChanged: (value) {
            // TODO: Implement search logic
          },
        ),
      ),
    );
  }
}
