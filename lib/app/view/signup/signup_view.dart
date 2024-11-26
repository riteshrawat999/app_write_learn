import 'package:app_write_learn/app/view/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupView extends StatelessWidget {
   SignupView({super.key});

  final SignUpController _controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SignUp View',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://appwrite.io/assets/logomark/logo.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 20,),
                  const Text('Welcome Back',style: TextStyle(fontSize: 20,color: Colors.black),),
                  const SizedBox(height: 20,),
                  /// email filed
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email)
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _controller.emailController,
                    validator: (value){
                      return _controller.validateEmail(value!);
                    },
                  ),
                  const SizedBox(height: 16,),
                  /// named field
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person)
                    ),
                    keyboardType: TextInputType.text,
                    controller: _controller.namedController,
                    validator: (value){
                      return _controller.validateName(value!);
                    },
                  ),
                  const SizedBox(height: 16,),
                  /// password field
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.password)
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _controller.passwordController,
                    validator: (value){
                      return _controller.validatePassword(value!);
                    },
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(onPressed: (){
                    _controller.validateAndSignUp(email: _controller.emailController.text,
                        password: _controller.passwordController.text,
                        name: _controller.namedController.text);
                  },
                  style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11)
                    )
                  ),
                      child: const Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 16),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
