import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:unisq_project/components/components.dart';
import 'dart:async';

import 'home_screen.dart';
import 'login_screen.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  late String _confirmPass;
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
                child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white), ),
              ),
              const SizedBox(height: 8.0,),
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
              const SizedBox(height: 8.0,),
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
              const SizedBox(height: 8.0,),
              TextField(
                obscureText: passConfirm,
                textAlign: TextAlign.center,
                onChanged: (value){
                  _confirmPass = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Confirm password',
                    suffix: IconButton(
                        onPressed: (){
                          setState(() {
                            if(passConfirm)
                            {
                              passConfirm = false;
                            }
                            else
                            {
                              passConfirm = true;
                            }
                          });
                        },
                        icon: Icon(passConfirm==true?Icons.remove_red_eye:Icons.password)
                    )
                ),
              ),
              const SizedBox(height: 8.0,),
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
                    if(_password == _confirmPass)
                      {
                        try{
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
                          if(context.mounted)
                            {
                              setState(() {
                                showSpinner = false;
                                Navigator.pop(context,
                                    MaterialPageRoute(builder: (context)=>const SignupScreen())
                                );
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>const MyHomeScreen(title: 'UniSQ Bus Booking Services'))
                              );
                            }
                        }
                        on FirebaseAuthException catch(e){
                          if(e.code=="weak-password")
                            {
                              showAlert(
                                context: context,
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>const SignupScreen())
                                  );
                                },
                                title: 'Password Error!',
                                description: 'Weak Password',
                              ).show();
                            }
                          else if(e.code == "email exists")
                            {
                              showAlert(
                                context: context,
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>const SignupScreen())
                                  );
                                },
                                title: 'Account already Exists',
                                description: 'Use another account',
                              ).show();
                            }
                        }
                      }
                    else
                      {
                        showAlert(
                            context: context,
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>const SignupScreen())
                              );
                            },
                            title: 'Confirm Password',
                            description: 'Please confirm you password to proceed'
                        ).show();
                      }
                  },
                  child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
