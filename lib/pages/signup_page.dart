import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/custom_button.dart';
import '../helper/custom_textfiled.dart';
import '../helper/dropdown.dart';
import '../helper/show_snack_bar.dart';
import '../helper/text_button.dart';
import '../helper/database_helper.dart';

const List<String> list = <String>[];

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conPasswordController = TextEditingController();

  String? _selectedLevel;
  String? _selectedGender;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isEmailValid(String email) {
    RegExp regex = RegExp(r'^\d+@stud\.fci-cu\.edu\.eg$');
    return regex.hasMatch(email);
  }


  bool signup() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        !isEmailValid(_emailController.text) ||
        _idController.text.isEmpty ||
        _passwordController.text.length < 8 ||
        _conPasswordController.text != _passwordController.text) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Signup',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfiled(
                obscureText: false,
                controller: _nameController,
                text: 'Name',
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextfiled(
                  obscureText: false,
                  controller: _emailController,
                  text: 'Email'),
              SizedBox(
                height: 15,
              ),
              CustomTextfiled(
                obscureText: false,
                controller: _idController,
                text: 'Student ID',
              ),
              SizedBox(
                height: 15,
              ),
              DropdownMenuExample(
                text: 'Level',
                list: ['level 1', 'level 2', 'level 3', 'level 4'],
                color: Colors.white,
                onSelected: (value) {
                  setState(() {
                    _selectedLevel = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              DropdownMenuExample(
                text: 'Gender',
                list: ['Male', 'Female'],
                color: Colors.white,
                onSelected: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextfiled(
                  obscureText: true,
                  controller: _passwordController,
                  text: 'Password'),
              SizedBox(
                height: 15,
              ),
              CustomTextfiled(
                 
                  obscureText: true,
                  controller: _conPasswordController,
                  text: 'Confirm password'),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(
                      () {},
                    );
                    try {
                      if(signup()){
                        await registerSqlite();
                        // await registerFirebase();
                        showSnackBar(context, 'Successfull');
                      }
                      else {
                        showSnackBar(context, 'failed');
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(context, 'weak password');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context, 'email already exists');
                      }
                    } catch (e) {
                      print(e);
                      showSnackBar(context, 'There was an error');
                    }
                    isLoading = false;
                    setState(
                      () {},
                    );
                  }
                },
                text: 'Signup',
              ),
              const SizedBox(
                height: 5,
              ),
              Text_Button(
                text1: 'Already have an account?',
                text2: ' Login',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerFirebase() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

    addUserDetails(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _idController.text.trim(),
      _passwordController.text.trim(),
      _conPasswordController.text.trim(),
      _selectedLevel!,
      _selectedGender!
    );
  }

  Future addUserDetails(String name, String email, String id, String password,
      String conPassword , String level , String gender) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'email': email,
      'id': id,
      'password': password,
      'conPassword': conPassword,
      'level' : level,
      'gender' : gender
    });
  }

  Future<void> registerSqlite() async {
    Map<String, dynamic> userData = {
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'studentId': _idController.text.trim(),
      'password': _passwordController.text.trim(),
      'level' : _selectedLevel,
      'gender' : _selectedGender
    };
    int userId = await DatabaseHelper.instance.insertUser(userData);
    print("===========USER, $userId===========");
  }
}