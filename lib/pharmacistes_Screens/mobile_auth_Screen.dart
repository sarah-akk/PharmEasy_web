// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import './mobile_overview_screen.dart';
// import '../warehouse_owner_screens/web_auth_screen.dart';
//
// class MobileAuthScreen extends StatelessWidget{
//   static const routeName = '/MobileAuthScreen';
//
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
//     // transformConfig.translate(-10.0);
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.blueAccent,
//                   Colors.greenAccent,
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 stops: [0, 1],
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Container(
//               height: deviceSize.height,
//               width: deviceSize.width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Flexible(
//                     flex: deviceSize.width > 600 ? 2 : 1,
//                     child: AuthCard(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class AuthCard extends StatefulWidget {
//   const AuthCard({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _AuthCardState createState() => _AuthCardState();
// }
//
// class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   AuthMode _authMode = AuthMode.Login;
//   Map<String, String> _authData = {
//     'email': '',
//     'password': '',
//   };
//   var _isLoading = false;
//   final _passwordController = TextEditingController();
//   AnimationController? controller;
//   Animation<Size>? heightAnimation;
//
//   @override
//   void initState()
//   {
//     super.initState();
//     controller = AnimationController(vsync:this,duration: Duration(milliseconds: 300));
//     heightAnimation =Tween<Size>(begin:Size(double.infinity,260),end: Size(double.infinity,320))
//         .animate(CurvedAnimation(parent: controller!, curve: Curves.fastOutSlowIn)) ;
//     heightAnimation!.addListener(() => setState((){}));
//
//   }
//
//
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('An Error Occurred!'),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Okay'),
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//           )
//         ],
//       ),
//     );
//   }
//
//   Future<void> _submit() async {
//     // if (!_formKey.currentState!.validate()) {
//     //   // Invalid!
//     //   return;
//     // }
//     // _formKey.currentState?.save();
//     // setState(() {
//     //   _isLoading = true;
//     // });
//     // try {
//     //   if (_authMode == AuthMode.Login) {
//     //     // Log user in
//     //     await Provider.of<Auth>(context, listen: false).login(
//     //       _authData['email']!,
//     //       _authData['password']!,
//     //     );
//     //   } else {
//     //     // Sign user up
//     //     await Provider.of<Auth>(context, listen: false).signUp(
//     //       _authData['email']!,
//     //       _authData['password']!,
//     //     );
//     //   }
//     // } on HttpException catch (error) {
//     //   var errorMessage = 'Authentication failed';
//     //   if (error.toString().contains('EMAIL_EXISTS')) {
//     //     errorMessage = 'This email address is already in use.';
//     //   } else if (error.toString().contains('INVALID_EMAIL')) {
//     //     errorMessage = 'This is not a valid email address';
//     //   } else if (error.toString().contains('WEAK_PASSWORD')) {
//     //     errorMessage = 'This password is too weak.';
//     //   } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
//     //     errorMessage = 'Could not find a user with that email.';
//     //   } else if (error.toString().contains('INVALID_PASSWORD')) {
//     //     errorMessage = 'Invalid password.';
//     //   }
//     // } catch (error) {
//     //   const errorMessage =
//     //       'Could not authenticate you. Please try again later.';
//     //   print(error.toString());
//     //   _showErrorDialog(errorMessage);
//     // }
//
//     setState(() {
//       _isLoading = false;
//     });
//     Navigator.of(context).pushReplacementNamed(MobileOverviewScreen.routeName);
//   }
//
//
//   void _switchAuthMode() {
//     if (_authMode == AuthMode.Login) {
//       setState(() {
//         _authMode = AuthMode.Signup;
//       });
//       controller!.forward();
//     } else {
//       setState(() {
//         _authMode = AuthMode.Login;
//       });
//       controller!.reverse();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       elevation: 8.0,
//       child:AnimatedContainer(
//         height: heightAnimation?.value.height,
//         constraints:
//         BoxConstraints(minHeight: heightAnimation!.value.height),
//         width: deviceSize.width * 100,
//         padding: EdgeInsets.all(16.0),
//         duration: Duration(milliseconds: 300),
//         child:  Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'E-Mail'),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value!.isEmpty || !value.contains('@')) {
//                       return 'Invalid email!';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _authData['email'] = value!;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   controller: _passwordController,
//                   validator: (value) {
//                     if (value!.isEmpty || value.length < 5) {
//                       return 'Password is too short!';
//                     }
//                   },
//                   onSaved: (value) {
//                     _authData['password'] = value!;
//                   },
//                 ),
//                 if (_authMode == AuthMode.Signup)
//                   TextFormField(
//                     enabled: _authMode == AuthMode.Signup,
//                     decoration: InputDecoration(labelText: 'Confirm Password'),
//                     obscureText: true,
//                     validator: _authMode == AuthMode.Signup
//                         ? (value) {
//                       if (value != _passwordController.text) {
//                         return 'Passwords do not match!';
//                       }
//                     }
//                         : null,
//                   ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 if (_isLoading)
//                   CircularProgressIndicator()
//                 else
//                   ElevatedButton(
//                     onPressed: _submit,
//                     style: ButtonStyle(
//                       shape: MaterialStateProperty.all<OutlinedBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                         EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//                       ),
//                       backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
//                       foregroundColor: MaterialStateProperty.all<Color>(
//                         Theme.of(context).primaryTextTheme.button?.color ?? Colors.black,
//                       ),
//                     ),
//                     child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
//                   )
//
//                 ,TextButton(
//                   onPressed: _switchAuthMode,
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                       EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
//                     ),
//                     textStyle: MaterialStateProperty.all<TextStyle>(
//                       TextStyle(color: Theme.of(context).primaryColor),
//                     ),
//                     // You can customize other properties as needed.
//                   ),
//                   child: Text('${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
//                 )
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled/pharmacists_Screens/sign.dart';
import 'package:flutter/cupertino.dart';


// class MobileAuthScreen extends StatefulWidget {
//   static const routeName = '/MobileAuthScreen';
//
//   const MobileAuthScreen({super.key});
//   @override
//   State<MobileAuthScreen> createState() => _MobileAuthScreen();
// }
class MobileAuthScreen extends StatelessWidget {
  static const routeName = '/MobileAuthScreen';
  const MobileAuthScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: height,
        width: width,
        child: Stack(
            children: [
              Container(
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                            // SizedBox(height: 150),
                          Text(
                            'Welcome',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Please Login to continue..',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildTextFieldTxt(
                        txt: 'Email Adress',
                        icon: Icon(
                          Icons.email_outlined,
                          color: Colors.lightBlueAccent,
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildTextFieldPass(
                        txt: 'Password',
                        icon: Icon(Icons.lock_open_outlined, color: Colors.lightBlueAccent,
                        )),
                    SizedBox(height: 20.0,),

                    Container(
                      width: width,
                      child: ElevatedButton(
                        onPressed: (){

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40.0)
                            )
                          )
                        ),
                          child:Text('Login'),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(child: Divider(indent: 1.0,color: Colors.black38,)),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text('OR')),
                          Expanded(child: Divider(indent: 1.0,color: Colors.black38,)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text('Do create your account ?'),
                        SizedBox(width: 5.0,),
                        InkWell(
                          onTap: ()=>Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Sign())
                          ),
                          child: Text('Register',style: TextStyle(
                            color: Colors.lightBlueAccent,
                          ),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 15.0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      width: width,
                      height: 2.0,
                      color: Colors.lightBlueAccent,
                    )
                  ],
                ),
              )
            ],
        ),
      ),
          )),
    );
  }

  TextField buildTextFieldPass({txt, icon}) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: txt,
          suffixIcon: Icon(Icons.remove_red_eye_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: Colors.blue.shade300))),
    );
  }

  TextField buildTextFieldTxt({txt, icon}) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: txt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: Colors.blue.shade300))),
    );
  }
}
