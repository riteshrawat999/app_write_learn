import 'package:app_write_learn/app/view/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
   LoginView({super.key});

  final LoginController _controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login page',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Image.network(
                    'https://appwrite.io/assets/logomark/logo.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                    controller: _controller.emailController,
                    validator: (value) {
                      return _controller.validateEmail(value!);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.password)),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _controller.passwordController,
                    validator: (value) {
                      return _controller.validatePassword(value!);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _controller.validateAndLogin(email: _controller.emailController.text, password: _controller.passwordController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11))),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                    const SizedBox(height: 30,),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('I have no account ?',style: TextStyle(color: Colors.grey,fontSize: 12,)),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          _controller.moveToSignUp();
                        },
                          child: const Text("Sign Up",style: TextStyle(color: Colors.blue,fontSize: 13,),)
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
