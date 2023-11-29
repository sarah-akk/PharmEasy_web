import 'package:flutter/material.dart';
import '../pharmacistes_Screens/sign.dart';
import 'package:flutter/cupertino.dart';


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
        child: Stack(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 175,),
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
