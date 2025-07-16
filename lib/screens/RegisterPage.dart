// package
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  bool _isObsured = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Register"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(HugeIcons.strokeRoundedArrowLeft01))),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _nameController,
                validator: (value) {
                  if (value == '') return "Name can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(HugeIcons.strokeRoundedUser02),
                    hintText: "Name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == '') return "Email can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(HugeIcons.strokeRoundedMail01),
                    hintText: "Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                obscureText: _isObsured,
                keyboardType: TextInputType.emailAddress,
                controller: _passwordController,
                validator: (value) {
                  if (value == '') return "Password can't be empty";
                  if (value!.length < 6 || value.length > 18) return "Password length should be between 6 and 18";
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(HugeIcons.strokeRoundedCirclePassword),
                    suffixIcon: IconButton(
                        icon: Icon(_isObsured ? HugeIcons.strokeRoundedView : HugeIcons.strokeRoundedViewOffSlash),
                        onPressed: () {
                          setState(() {
                            _isObsured = !_isObsured;
                          });
                        }),
                    hintText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                obscureText: _isObsured,
                keyboardType: TextInputType.emailAddress,
                controller: _repeatPasswordController,
                validator: (value) {
                  if (value == '') return "Password can't be empty";
                  if (value!.length < 6 || value.length > 18) return "Password length should be between 6 and 18";
                  if (_passwordController.text != _repeatPasswordController.text) return "Passwords should match";
                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(_isObsured ? HugeIcons.strokeRoundedView : HugeIcons.strokeRoundedViewOffSlash),
                        onPressed: () {
                          setState(() {
                            _isObsured = !_isObsured;
                          });
                        }),
                    prefixIcon: const Icon(HugeIcons.strokeRoundedCirclePassword),
                    hintText: "Repeat Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text("Already have an Account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text("Login"))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 48,
                width: width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  onPressed: () async {
                    // TODO: Sign Up
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
