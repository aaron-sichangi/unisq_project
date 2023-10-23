import 'package:flutter/material.dart';
import 'package:unisq_project/pages/login_screen.dart';
import 'package:unisq_project/pages/signup_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.fromLTRB(40, 100, 40, 0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [Colors.orange, Colors.deepOrangeAccent, Colors.red, Colors.redAccent]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text('Get Started By Creating an Account', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 20.0), ),
            ),
            const Center(
              child: Text('Create an account get an amazing experience of customer-centric services', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.0, color: Colors.white),textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 150,),
            Row(
              children: <Widget>[
                Expanded(child: TextButton(
                  style: TextButton.styleFrom(
                    elevation: 2.0,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    backgroundColor: Colors.blueGrey[900],
                  ),
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>const SignupScreen())
                      );
                    },
                    child: const Text('CREATE AN ACCOUNT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)
                )
                )
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Expanded(child: TextButton(
                    style: TextButton.styleFrom(
                      elevation: 2.0,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      backgroundColor: Colors.blue[300],
                    ),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>const LoginScreen())
                      );
                    },
                    child: const Text('SIGN IN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)
                )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
