import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/tasks/presentation/screens/home_screen.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            Container(
            height: 350,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(1, 0),
                colors: [
                  Color(0xffF4C465),
                  Color(0xffC63956),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.asset(
                  'assets/images/img_saly10.png',
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi Ivan 👋',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Your day looks like this:',
                          style: GoogleFonts.roboto(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                       ],
                    ),
                  ),
                ),
            
              ],
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          Text(
            'Welcome to Go Task',
            style: GoogleFonts.roboto(
              color: Colors.blueAccent,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
           const SizedBox(
            height: 20,
          ),
            Text(
                'A workplace of over 10 Million influncers \n around the global of the world',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HomeScreen() ));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text('Let\'s Start'),
                  ),
                ),
              )
          ],
        ),
      );
  
  }
}