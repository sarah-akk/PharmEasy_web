import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Auth.dart';

enum AuthMode { Signup, Login }

class WebAuthScreen extends StatelessWidget {
  static const routeName = '/AuthScreen';

  @override
  Widget build(BuildContext context) {
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      
      // resizeToAvoidBottomInset: false,
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(height: 2),
          Text("Welcome Back! ",style: TextStyle(fontSize: 40,color: Colors.pinkAccent),),
          SizedBox(height: 30),
          Text("please inter your email and password",style: TextStyle(fontSize:20,color: Colors.deepPurple),),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            AuthCard(),
            Image.asset("assets/images/Screenshot 2023-11-18 163907.png",width: 300,height: 300,),
          ],
      ),
    ],
    ),)
    ;
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController? controller;
  Animation<Size>? heightAnimation;

  @override
  void initState()
  {
    super.initState();
    controller = AnimationController(vsync:this,duration: Duration(milliseconds: 300));
    heightAnimation =Tween<Size>(begin:Size(double.infinity,260),end: Size(double.infinity,320))
        .animate(CurvedAnimation(parent: controller!, curve: Curves.fastOutSlowIn)) ;
    heightAnimation!.addListener(() => setState((){}));

  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    // if (!_formKey.currentState!.validate()) {
    //   // Invalid!
    //   return;
    // }
    // _formKey.currentState?.save();
    // setState(() {
    //   _isLoading = true;
    // });
    // try {
    //   if (_authMode == AuthMode.Login) {
    //     // Log user in
    //     await Provider.of<Auth>(context, listen: false).login(
    //       _authData['email']!,
    //       _authData['password']!,
    //     );
    //   } else {
    //     // Sign user up
    //     await Provider.of<Auth>(context, listen: false).signUp(
    //       _authData['email']!,
    //       _authData['password']!,
    //     );
    //   }
    // } on HttpException catch (error) {
    //   var errorMessage = 'Authentication failed';
    //   if (error.toString().contains('EMAIL_EXISTS')) {
    //     errorMessage = 'This email address is already in use.';
    //   } else if (error.toString().contains('INVALID_EMAIL')) {
    //     errorMessage = 'This is not a valid email address';
    //   } else if (error.toString().contains('WEAK_PASSWORD')) {
    //     errorMessage = 'This password is too weak.';
    //   } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
    //     errorMessage = 'Could not find a user with that email.';
    //   } else if (error.toString().contains('INVALID_PASSWORD')) {
    //     errorMessage = 'Invalid password.';
    //   }
    // } catch (error) {
    //   const errorMessage =
    //       'Could not authenticate you. Please try again later.';
    //   print(error.toString());
    //   _showErrorDialog(errorMessage);
    // }
    //
    // setState(() {
    //   _isLoading = false;
    // });
    Navigator.of(context).pushReplacementNamed('/MedicinesOverviewScreen');
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      controller!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child:AnimatedContainer(
        height: heightAnimation?.value.height,
        constraints:
        BoxConstraints(minHeight: heightAnimation!.value.height),
        width: 500,
        padding: EdgeInsets.all(16.0),
        duration: Duration(milliseconds: 300),
        child:  Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match!';
                      }
                    }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryTextTheme.button?.color ?? Colors.black,
                      ),
                    ),
                    child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  )

                ,TextButton(
                  onPressed: _switchAuthMode,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    // You can customize other properties as needed.
                  ),

                  child: Text('${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                ),


              ],
            ),
          ),
        ),
      ),

    );

  }
}
