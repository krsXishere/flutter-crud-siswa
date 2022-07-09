import 'package:flutter/material.dart';
import 'package:siswa_flutter/helpers/button.dart';
import 'package:siswa_flutter/helpers/loading_button.dart';
import 'package:siswa_flutter/models/signin_model.dart';
import 'package:siswa_flutter/pages/navigation_bar_page.dart';
import 'package:siswa_flutter/pages/register_page.dart';
import '../helpers/textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSuffix = true;
  SignInModel? signInModel;
  bool isLoading = false;

  void visibilityButton() {
    setState(() {
      isSuffix = !isSuffix;
    });
  }

  Future<void> signIn() async {
    String email = emailController.text;
    String password = passwordController.text;
    SignInModel.toJson(email, password).then((value) {
      setState(() {
        signInModel = value;
      });
    });

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Isi Semua Field',
          ),
        ),
      );
    }

    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (signInModel?.status == 200) {
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
            content: Text('Gagal masuk.'),
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
        title: const Text('Sign In'),
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
                  controller: emailController,
                  hintName: 'Email',
                  suffixIcon: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                GenTextfield(
                  isObscure: isSuffix,
                  controller: passwordController,
                  hintName: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: visibilityButton,
                    child: Icon(
                      isSuffix ? Icons.visibility_off : Icons.visibility,
                      color: isSuffix ? Colors.black : Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                isLoading == false
                    ? DefaultButton(
                        color: Colors.blueAccent,
                        text: 'Masuk',
                        onPressed: signIn,
                        width: double.infinity,
                      )
                    : LoadingButton(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun?'),
                    TextButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => const RegisterPage());
                        Navigator.of(context).push(route);
                      },
                      child: const Text('Buat akun'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
