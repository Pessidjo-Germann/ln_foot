import 'package:flutter/material.dart';

class AddressSection extends StatefulWidget {
  final VoidCallback onChangePressed;
  final String? email, name, address;
  final Function(String name, String email, String address)? onAddressUpdated;

  const AddressSection({
    super.key,
    this.name,
    this.email,
    this.address,
    required this.onChangePressed,
    this.onAddressUpdated,
  });

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  String? name;
  String? email;
  String? address;

  void _showAddressModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddressFormModal(
        initialName: name,
        initialEmail: email,
        initialAddress: address,
        onSave: (newName, newEmail, newAddress) {
          if (newName.isEmpty || newEmail.isEmpty || newAddress.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Veuillez remplir tous les champs'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          setState(() {
            name = newName;
            email = newEmail;
            address = newAddress;
          });
          widget.onAddressUpdated?.call(newName, newEmail, newAddress);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Informations de livraison',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => _showAddressModal(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text('Modifier'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (name != null || email != null || address != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (name != null)
                _buildInfoRow(Icons.person_outline, name!),
              if (email != null)
                _buildInfoRow(Icons.email_outlined, email!),
              if (address != null)
                _buildInfoRow(Icons.location_on_outlined, address!),
            ],
          )
        else
          Center(
            child: TextButton(
              onPressed: () => _showAddressModal(context),
              child: const Text('Ajouter vos informations de livraison'),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.grey.shade600,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressFormModal extends StatefulWidget {
  final String? initialName;
  final String? initialEmail;
  final String? initialAddress;
  final Function(String name, String email, String address) onSave;

  const AddressFormModal({
    super.key,
    this.initialName,
    this.initialEmail,
    this.initialAddress,
    required this.onSave,
  });

  @override
  State<AddressFormModal> createState() => _AddressFormModalState();
}

class _AddressFormModalState extends State<AddressFormModal> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _addressController = TextEditingController(text: widget.initialAddress);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Informations de livraison',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom complet',
                border: OutlineInputBorder(),
              ),
              validator: _validateField,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: _validateField,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Adresse de livraison',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              validator: _validateField,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSave(
                    _nameController.text,
                    _emailController.text,
                    _addressController.text,
                  );
                }
              },
              child: const Text('Valider'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
