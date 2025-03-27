  import 'package:flutter/material.dart';
import 'package:ln_foot/widgets/custom_button.dart';

void showSuccessBottomSheet(BuildContext context, String message,String message2) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          minChildSize: 0.32,
          maxChildSize: 0.7,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        'images/checkmark-circle-02.png',
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                       Text(
                        message2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButton(
                          text: message,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }