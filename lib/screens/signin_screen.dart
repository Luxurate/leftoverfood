import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooddonation/reusable_widgets/reusable_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'reset_password.dart';
import 'signup_screen.dart';
import 'opening_screen.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 39, bottom: 1),
            color: Colors.black,
            child: Text(
              'DONATISTIC',
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontFamily: 'Schyler',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),


          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/login_bg.png', // replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    reusableTextField(
                      "Enter E-mail",
                      Icons.person_outline,
                      false,
                      _emailTextController,
                    ),
                    const SizedBox(height: 20),
                    reusableTextField(
                      "Enter Password",
                      Icons.lock_outline,
                      true,
                      _passwordTextController,
                    ),
                    const SizedBox(height: 5),
                    forgetPassword(context),
                    firebaseUIButton(context, "Sign In", () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>OpeningScreen()));
                      }).onError((error, stackTrace) {
                        // TODO: Handle error here
                        //print(error);
                      });
                    }),
                    signUpOption(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No Account?',
          style: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.white60, letterSpacing: .5),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          'Forgot Password?',
          style: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.white70, letterSpacing: .5),
          ),

          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ResetPassword()),
        ),
      ),

    );
  }
}
