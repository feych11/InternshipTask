import 'package:flutter/material.dart';
import 'package:internshiptask/Screen/FrontPageDesigning.dart';
import 'package:internshiptask/Screen/StudentSignupScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SLogin extends StatefulWidget {
  const SLogin({super.key});

  @override
  State<SLogin> createState() => _SLoginState();
}

class _SLoginState extends State<SLogin> {
  TextEditingController reaemailcon = TextEditingController();
  TextEditingController reapasscon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          'STUDENT LOGIN SCREEN',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'BigshotOne',
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Image/SplashScreen45.png'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 6,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: reaemailcon,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                          hintText: 'Enter Your Name Here',
                          hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          labelText: 'Your Name Please!!',
                          labelStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: reapasscon,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                          hintText: 'Student Password',
                          hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          labelText: 'Student Password',
                          labelStyle: const TextStyle(fontFamily: 'BigshotOne'),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        'Sign up',style: TextStyle(fontFamily: 'Jaro',fontSize: 15,color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () async {
                          // Save username to shared preferences
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('username', reaemailcon.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FrontPageDesigning()));

                          // Print values to console
                          print(reaemailcon.text);
                          print(reapasscon.text);
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'BigshotOne',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
