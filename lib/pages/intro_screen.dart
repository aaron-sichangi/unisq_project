import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:unisq_project/pages/home_screen.dart';
import 'package:unisq_project/pages/landing_screen.dart';
class IntroPage extends StatefulWidget
{
  const IntroPage({super.key});
  @override
  State<IntroPage> createState()=>_IntroPage();
}

class _IntroPage extends State<IntroPage>
{
  @override
  Widget build(BuildContext context)
  {
    PageDecoration pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.white),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [Colors.orange, Colors.deepOrangeAccent, Colors.red, Colors.redAccent]
        )
      ),
      imagePadding: EdgeInsets.all(20),
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.red,
      pages: [
        PageViewModel(
          title: "Reserve Bus Seats",
          body: "Book your favorite spot on the bus",
          image: introImage("assets/images/seat_reserve_.png"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Real-time tracking",
          body: "Don't miss catching your bus from the pickup point",
          image: introImage("assets/images/bus_tracking.jpg"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bus Schedule information",
          body: "Receive all bus schedule information",
          image: introImage("assets/images/schedule_information.jpg"),
          decoration: pageDecoration,
        ),
      ],
      onDone: ()=>goHomePage(context),
      onSkip: ()=>goHomePage(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: const Text('skip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700,),),
      next: const Icon(Icons.arrow_forward, color: Colors.white,),
      done: const Text('Getting Started', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),),
      dotsDecorator: const DotsDecorator(
        size: Size(10, 10),
        color: Colors.white,
        activeSize: Size(22, 22),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );
  }
  void goHomePage(context)
  {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context){
          //return const LandingScreen();
          return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              //if user is already signed-in, use it as initial data
              initialData: FirebaseAuth.instance.currentUser,
              builder: (context, snapshot){
                //if User is not signed in
                if(!snapshot.hasData)
                  {
                    return const MyHomeScreen(title: 'UniSQ Bus Services');
                  }
                //if user is already authenticated
                return const MyHomeScreen(title: 'UniSQ Bus Services');
              }
          );
        }
        ),
            (Route<dynamic>route) => false);
  }
  Widget introImage(String imageName)
  {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(imageName, width: 150.0, height: 150.0, fit: BoxFit.fill,),
    );
  }
}