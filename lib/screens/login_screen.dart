import 'package:flutter/material.dart';
import 'package:login_page/widgets/login_card.dart';
import 'package:login_page/widgets/snackbar.dart';
import 'package:login_page/screens/home_scren.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      Future.delayed(const Duration(seconds: 1), () {
        if ((_usernameController.text == 'admin' &&
                _passwordController.text == '12345678') ||
            (_usernameController.text == 'user' &&
                _passwordController.text == '12345678')) {
          ScaffoldMessenger.of(context);
          General.showSnackBar(context, 'Berhasil Login');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          ScaffoldMessenger.of(context);
          General.showSnackBar(context, 'Username atau password salah');
        }
        setState(() => _isLoading = false);
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginCard(
        formKey: _formKey,
        usernameController: _usernameController,
        passwordController: _passwordController,
        isPasswordVisible: _isPasswordVisible,
        isLoading: _isLoading,
        onTogglePassword: () {
          setState(() => _isPasswordVisible = !_isPasswordVisible);
        },
        onLogin: _login,
      ),
    );
  }
}
