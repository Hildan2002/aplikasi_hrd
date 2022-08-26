import 'package:aplikasi_hrd/constant/constant_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    var _usernameController = TextEditingController();
    var _passwordController = TextEditingController();
    final FocusNode _usernameFocus = FocusNode();
    final FocusNode _passwordFocus = FocusNode();

    Future signIn() async{
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
        );
      }
      on FirebaseAuthException catch (e) {
        print(e);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: Text(e.message.toString()),
              );
            });
      }
    }


    return Form(
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              // onFieldSubmitted: (value){
              //   _usernameFocus.unfocus();
              // },
              focusNode: _usernameFocus,
              cursorColor: kPrimaryColor,
              // onSaved: (email) {},
              decoration: InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                controller: _passwordController,
                autofocus: true,
                textInputAction: TextInputAction.done,
                focusNode: _passwordFocus,
                onFieldSubmitted: (value){
                  _passwordFocus.unfocus();
                  signIn();
                },
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Your password",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: signIn,
                child: Text(
                  "Login".toUpperCase(),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),

          ],
        ),
      );
  }
}
