import 'package:flutter/material.dart';
// class Sign extends StatefulWidget {
//   const Sign({super.key});
//
//   @override
//   State<Sign> createState() => _SignState();
//
// }
class Sign extends StatelessWidget {
  const Sign({super.key});
  @override

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 175,),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                'Welcome',
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Create Sign to continue..',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 15.0,
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
                            txt: 'Name',
                            icon: Icon(
                              Icons.person,
                              color: Colors.lightBlueAccent,
                            )),
                        SizedBox(height: 10.0,),
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
                        SizedBox(height: 10.0,),
                        buildTextFieldPass(
                            txt: 'Conf Password',
                            icon: Icon(Icons.lock_open_outlined, color: Colors.lightBlueAccent,
                            )),
                        SizedBox(height: 10.0,),

                        Container(
                          width: width,
                          child: ElevatedButton(
                            onPressed: (){},
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
                            child:Text('Sign Up'),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 15.0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap:()=>Navigator.of(context).pop(),
                            child: const Icon(
                              Icons.keyboard_backspace,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          Text(
                            'Back to login',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                        width: width,
                        height: 1.0,
                        color: Colors.blue.shade200,
                      )
                    ],
                  ),
                )
              ],
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

