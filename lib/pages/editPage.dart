import 'package:app/helper/user.dart';
import 'package:flutter/material.dart';

import '../helper/database_helper.dart';
import '../helper/dropdown.dart';
import '../helper/show_snack_bar.dart';

class EditProfilePage extends StatefulWidget {
  Users user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _studentIdController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _levelController; // New controller for level
  late TextEditingController _genderController; // New controller for gender

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _studentIdController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _levelController = TextEditingController(); // Initialize level controller
    _genderController = TextEditingController(); // Initialize gender controller

    // Initialize text field values with existing user data
    _nameController.text = widget.user.name!;
    _emailController.text = widget.user.email!;
    _studentIdController.text = widget.user.studentId!;
    _passwordController.text = widget.user.password!;
    _confirmPasswordController.text = '';
    _levelController.text = widget.user.level ?? ''; // Initialize level field
    _genderController.text = widget.user.gender ?? ''; // Initialize gender field
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    _nameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _levelController.dispose(); // Dispose level controller
    _genderController.dispose(); // Dispose gender controller
    super.dispose();
  }

  bool isEmailValid(String email) {
    RegExp regex = RegExp(r'^\d+@stud\.fci-cu\.edu\.eg$');
    return regex.hasMatch(email);
  }

  bool isValid() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        !isEmailValid(_emailController.text) ||
        _studentIdController.text.isEmpty ||
        _passwordController.text.length < 8 ||
        _confirmPasswordController.text.isNotEmpty && _confirmPasswordController.text != _passwordController.text) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _studentIdController,
              decoration: InputDecoration(labelText: 'Student ID'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            DropdownMenuExample(
              text: 'Level',
              list: ['Level 1', 'Level 2', 'Level 3', 'Level 4'],
              color: Colors.black,
              onSelected: (String? value) {
                setState(() {
                  _levelController.text = value ?? '';
                });
              },
            ),
            DropdownMenuExample(
              text: 'Gender',
              list: ['Male', 'Female'],
              color: Colors.black,
              onSelected: (String? value) {
                setState(() {
                  _genderController.text = value ?? '';
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if(!isValid()){
                  print("Error in validation..");
                  return;
                }
                // Get the updates
                String newName = _nameController.text;
                String newEmail = _emailController.text;
                String newStudentId = _studentIdController.text;
                String newPassword = _passwordController.text;
                String cPassword = _confirmPasswordController.text;
                String newLevel = _levelController.text;
                String newGender = _genderController.text;

                try {
                  Map<String, dynamic> updatedUserData = {
                    'name': newName,
                    'studentId': newStudentId,
                    'level': newLevel,
                    'gender': newGender,
                  };
                  // Only add the password to the update if it's not empty
                  if (cPassword.isNotEmpty) {
                    updatedUserData['password'] = newPassword;
                  }

                  int rowsAffected = await DatabaseHelper.instance.updateUser(widget.user.email!, updatedUserData);
                  if (rowsAffected > 0) {
                    Navigator.pop(context, newEmail);
                  } else {
                    showSnackBar(context, 'Error updating profile data..');
                  }
                } catch (e) {
                  print('Error updating profile data: $e');
                  showSnackBar(context, 'Error updating profile data..');
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
