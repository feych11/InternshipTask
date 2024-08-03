import 'dart:io';



import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'package:image_picker/image_picker.dart';
import 'package:internshiptask/Screen/StudentLoginScreen.dart';

enum UserRole{Student,Admin}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserRole? _selectedRole = UserRole.Student;
  TextEditingController reaemailcont = TextEditingController();
  TextEditingController reanamecon = TextEditingController();
  TextEditingController reapasscount = TextEditingController();
  TextEditingController reaconpasscount = TextEditingController();
  final bool _passwordsMatch = true;
  bool isSignup=false;
  File? _imageFile;
  final picker = ImagePicker();
  final List<String> _selectedCategories = [];
  final List<String> _selectedCategories1 = [];
  final List<String> _categories = [
    'English',
    'Mathematics',
    'Biology',
    'Computer',
    'Chemistry',
    'PhySics',
    'History',
  ];

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });

    // Call fetchWriters when categories are toggled
    // Pass selected categories as comma-separated string
  }


  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Center(
              child: Text(
                'SIGNUP SCREEN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white,fontFamily: 'BigshotONe'),
              )),
          backgroundColor: Colors.black,
        ),
        body:


        Stack(children: [


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

                Center(
                  child: GestureDetector(
                    onTap: getImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('Image/emp2.jpeg'),
                      child: _imageFile == null ? const Icon(Icons.person, size: 50,color: Colors.black,) : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  height: 440,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 6,
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: reaemailcont,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                            hintText: 'Email',
                            hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                            labelText: 'Email',
                            labelStyle: const TextStyle(fontFamily: 'BigshotOne'),
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: reanamecon,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                              hintText: 'Username',
                              hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                              labelText: 'Username',
                              prefixIcon: const Icon(Icons.person),
                              labelStyle: const TextStyle(fontFamily: 'BigshotOne')
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: reapasscount,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                            hintText: 'Password',
                            hintStyle: const TextStyle(fontFamily: 'BigshotOne'),
                            labelText: 'Password',
                            labelStyle: const TextStyle(fontFamily: 'BigshotOne'),
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Subjects',
                          labelStyle:const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                          hintStyle: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.category),
                            onPressed: () {
                              _showCategoryDialog(context);
                            },
                          ),
                        ),
                        controller: TextEditingController(
                          text: _selectedCategories.isNotEmpty
                              ? _selectedCategories.join(', ')
                              : null,
                        ),style: const TextStyle(fontFamily: 'BigshotOne',color: Colors.black),
                        readOnly: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Role:',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(children: [
                            Radio(
                                value: UserRole.Student,
                                groupValue: _selectedRole,
                                onChanged: ( UserRole? value) {
                                  setState(() {
                                    _selectedRole = value!;
                                  });
                                }),
                            //SizedBox(width: 10,),
                            const Text('Student',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'BigshotOne'),)
                          ],),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(children: [
                            Radio(

                                value: UserRole.Admin,

                                groupValue: _selectedRole,
                                onChanged: ( UserRole? value) {
                                  setState(() {
                                    _selectedRole = value!;
                                  });
                                }),
                            //SizedBox(width: 5,),
                            const Text('Admin',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'BigshotOne'),)
                          ],)
                        ],
                      ),
                    ],),),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: InkWell(
                      onTap: ()async{

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SLogin()));
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(child: Text('SIGNUP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,fontFamily: 'Jaro'))),
                      ),
                    )
                ),
                const SizedBox(height: 10,),
                Row(children: [
                  const Text('Have an account?'),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SLogin()));
                      },
                      child: const Text('Login',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),))
                ],)
              ],
            ),
          ),
        ],)
    );
  }

  @override
  void dispose() {
    reapasscount.dispose();
    reaconpasscount.dispose();
    super.dispose();
  }


  void _showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Categories'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = _categories[index];
                return CheckboxListTile(
                  title: Text(category),
                  value: _selectedCategories.contains(category),
                  onChanged: (bool? value) {
                    _toggleCategory(category);
                  },
                );
              },
            ),
          ),


          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
