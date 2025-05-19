import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_foot/bloc/auth/auth_bloc.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/custom_button.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedGender;
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _initUserData(Map<String, dynamic> user) {
    if (_initialized) return;
    _nameController.text = user['name'] ?? '';
    _emailController.text = user['email'] ?? '';
    _dobController.text = user['birthdate'] ?? '';
    _phoneController.text = user['phone_number'] ?? '';
    _selectedGender = user['gender'] ?? null;
    _initialized = true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Or parse from existing data
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // TODO: Format the date as needed (e.g., using intl package)
      setState(() {
        _dobController.text =
            "${picked.day}/${picked.month}/${picked.year}"; // Simple format
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Mon profile',
        showBackButton: true,
        onBackButtonPressed: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              // TODO: Navigate to Notification Screen
              print('Notification icon pressed');
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Authenticated) {
            _initUserData(state.user);
            debugPrint('User data initialized: ${state.user}');
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Nom et prénom',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Adresse email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    // _buildDateField(
                    //   label: 'Date de naissance',
                    //   controller: _dobController,
                    //   onTap: () => _selectDate(context),
                    // ),
                    // const SizedBox(height: 16),
                    // _buildGenderDropdown(
                    //   label: 'Genre',
                    //   value: _selectedGender,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       _selectedGender = newValue;
                    //     });
                    //   },
                    // ),
                    // const SizedBox(height: 16),
                    // _buildPhoneField(
                    //   label: 'Numéro de téléphone',
                    //   controller: _phoneController,
                    // ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          } else if (state is AuthError) {
            return Center(child: Text('Erreur: ${state.message}'));
          } else {
            return const Center(child: Text('Aucune information utilisateur.'));
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: 'Enregistré',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // TODO: Implement save logic
              print('Saving profile...');
              print('Name: ${_nameController.text}');
              print('Email: ${_emailController.text}');
              print('DOB: ${_dobController.text}');
              print('Gender: $_selectedGender');
              print('Phone: ${_phoneController.text}');
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  // Helper widget for standard text fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                const TextStyle(fontWeight: FontWeight.w500)), // Or use Theme
        const SizedBox(height: 8),
        TextFormField(
          // Using standard TextFormField, replace with CustomTextField if it fits
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            // hintText: 'Enter $label', // Optional hint
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }

  // Helper for Date Field (read-only text field with calendar icon)
  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return _buildTextField(
      label: label,
      controller: controller,
      readOnly: true,
      onTap: onTap,
      suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
    );
  }

  // Helper for Gender Dropdown
  Widget _buildGenderDropdown({
    required String label,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: ['Male', 'Female', 'Other'] // Example options
              .map((label) => DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          // validator: (value) => value == null ? 'Please select gender' : null, // Optional validation
        ),
      ],
    );
  }

  // Helper for Phone Field (basic implementation)
  Widget _buildPhoneField({
    required String label,
    required TextEditingController controller,
  }) {
    // TODO: Integrate a country code picker package (e.g., intl_phone_field) for better UX
    return _buildTextField(
      label: label,
      controller: controller,
      keyboardType: TextInputType.phone,
      // validator: ..., // Add phone validation
    );
  }
}
