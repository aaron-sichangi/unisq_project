import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unisq_project/pages/home_screen.dart';
import 'package:unisq_project/pages/signup_screen.dart';
import 'dart:async';
import '../components/components.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.NONE);
  late String _email;
  late String _password;
  bool showSpinner = false;
  bool passPassword = true;
  bool passConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text('Log In',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white,),textAlign: TextAlign.center, ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value){
                  _email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email'
                ),
              ),
              const SizedBox(height: 10.0,),
              TextField(
                obscureText: passPassword,
                textAlign: TextAlign.center,
                onChanged: (value){
                  _password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                    suffix: IconButton(
                        onPressed: (){
                          setState(() {
                            if(passPassword)
                            {
                              passPassword = false;
                            }
                            else
                            {
                              passPassword = true;
                            }
                          });
                        },
                        icon: Icon(passPassword==true?Icons.remove_red_eye:Icons.password)
                    )
                ),
              ),
              const SizedBox(height: 10.0,),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    elevation: 2.0,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    backgroundColor: Colors.indigoAccent,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),
                  ),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try
                    {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
                      //UserCredential userCredential = await _auth.signInAnonymously();
                      if(context.mounted)
                        {
                          setState(() {
                            showSpinner = false;
                            Navigator.pop(context,
                                MaterialPageRoute(builder: (context)=>const LoginScreen())
                            );
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>const MyHomeScreen(title: 'UniSQ Bus Booking Services'))
                          );
                        }
                    }
                    on FirebaseAuthException catch(e)
                    {
                      if(e.code=='user-not-found')
                        {
                          showAlert(
                            context: context,
                            onPressed: (){
                              setState(() {
                                showSpinner = false;
                                Navigator.pop(context);
                              });
                            },
                            title: 'Could not login!',
                            description: 'Email not found',
                          ).show();
                        }
                      else if(e.code == 'wrong-password')
                        {
                          showAlert(
                            context: context,
                            onPressed: (){
                              setState(() {
                                showSpinner = false;
                                Navigator.pop(context);
                              });
                            },
                            title: 'Could not login!',
                            description: 'Wrong credentials',
                          ).show();
                        }
                      else
                      {
                        showAlert(
                          context: context,
                          onPressed: (){
                            setState(() {
                              showSpinner = false;
                              Navigator.pop(context);
                            });
                          },
                          title: 'Could not login!',
                          description: '$e.message',
                        ).show();
                      }
                    }
                  },
                  child: const Text('Log In', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}