import 'package:flutter/material.dart';
 
enum PaymentMethod { card, cash, other }

class PaymentMethodSection extends StatefulWidget {

  final String? initialPhone;
  final Function(String phone)? onPhoneUpdated;


  const PaymentMethodSection({
    super.key,
    this.initialPhone,
    this.onPhoneUpdated,
  });

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  
 

   String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le numéro de téléphone est obligatoire';
    }
    if (!RegExp(r'^\+?[0-9]{9,}$').hasMatch(value)) {
      return 'Numéro de téléphone invalide';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
   
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        
        const SizedBox(height: 12),
        // Payment Method Selector Row
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Numéro de téléphone',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          '+237',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      validator: _validatePhone,
                      onChanged: (value) {
                        if (widget.onPhoneUpdated != null) {
                          widget.onPhoneUpdated!(value);
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (widget.onPhoneUpdated!= null) {
                          widget.onPhoneUpdated!(value);
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: '69/67 XXXXXXX',
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Selected Card Details (only shown if card is selected)
        // if (_selectedMethod == PaymentMethod.card) _buildSelectedCardDetails(context),
      ],
    );
  }
 
 
  
}
