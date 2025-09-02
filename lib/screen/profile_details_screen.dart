import 'package:flutter/material.dart';
import 'package:ln_foot/user_session_manager.dart';
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
  Map<String, dynamic>? _userInfo;
  String? _selectedGender;
  bool _initialized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final data = await UserSessionManager.getUserInfo();
    setState(() {
      _userInfo = data;
    });
  }

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
    _selectedGender = user['gender'];
    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    if (_userInfo != null) {
      _initUserData(_userInfo!); // Initialise les champs à remplir
    }
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
      body: SingleChildScrollView(
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

              // Ajoute d'autres champs si besoin

              const SizedBox(height: 32),
              // Padding supplémentaire pour éviter que le contenu soit masqué par le bouton fixe
              const SizedBox(height: 100),
            ],
          ),
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
            child: CustomButton(
              text: 'Enregistrer',
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
        ),
      ],
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
}
