import 'package:flutter/material.dart';
import 'package:siswa_flutter/helpers/button.dart';
import 'package:siswa_flutter/helpers/loading_button.dart';
import 'package:siswa_flutter/helpers/textfield.dart';
import 'package:siswa_flutter/models/register_model.dart';

import 'navigation_bar_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  RegisterModel? registerModel;
  bool isSuffix = true;
  bool isSuffix2 = true;
  bool isLoading = false;

  void visibilityButton() {
    setState(() {
      isSuffix = !isSuffix;
    });
  }

  void visibilityButton2() {
    setState(() {
      isSuffix2 = !isSuffix2;
    });
  }

  Future<void> register() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String cPassword = passwordConfirmController.text;

    RegisterModel.toJson(
      name,
      email,
      password,
      cPassword,
    ).then((value) {
      setState(() {
        registerModel = value;
      });
    });

    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (registerModel?.status == 200) {
        setState(() {
          isLoading = false;
        });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const NavbarPage()),
            (Route<dynamic> route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Gagal mendaftar.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const FlutterLogo(
                  size: 150,
                ),
                const SizedBox(
                  height: 30,
                ),
                GenTextfield(
                  controller: nameController,
                  hintName: 'Nama lengkap kamu',
                  suffixIcon: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                GenTextfield(
                  controller: emailController,
                  hintName: 'Email kamu',
                  suffixIcon: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                GenTextfield(
                  isObscure: isSuffix,
                  controller: passwordController,
                  hintName: 'Kata sandi kamu',
                  suffixIcon: GestureDetector(
                    onTap: visibilityButton,
                    child: Icon(
                      isSuffix ? Icons.visibility_off : Icons.visibility,
                      color: isSuffix ? Colors.black : Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GenTextfield(
                  isObscure: isSuffix2,
                  controller: passwordConfirmController,
                  hintName: 'Konfirmasi kata sandi kamu',
                  suffixIcon: GestureDetector(
                    onTap: visibilityButton2,
                    child: Icon(
                      isSuffix2 ? Icons.visibility_off : Icons.visibility,
                      color: isSuffix2 ? Colors.black : Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                isLoading == false
                    ? DefaultButton(
                        color: Colors.blueAccent,
                        text: 'Daftar',
                        onPressed: register,
                        width: double.infinity,
                      )
                    : LoadingButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
