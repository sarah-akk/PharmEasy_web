import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier{
  String?  token;
  DateTime? expireyDate;
  String? userId;
  Timer? authTimer = null ;

  bool get  isAuth{
    return token !=null;
  }
  String? get UserId{
    return userId;
  }
  String? get tokenn{
    if(expireyDate!=null && expireyDate!.isAfter(DateTime.now()) && token!=null){
      return token;
    }
    return null;
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  Future<void> logintoAdmin(String? PhoneNumber,String? passowrd,String? urlSegment )async{
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAHN6mVcn_YLp_j7dzeGr5SgqRtrdiFAIg');
    try {final response =  await http.post(url,body: jsonEncode({
      'email':PhoneNumber,
      'password':passowrd,
      'returnSecureToken' :true,})
    );
    final responseData = json.decode(response.body);

    token = responseData['idToken'];
    userId = responseData['localId'];
    expireyDate= DateTime.now().add(Duration(
      seconds:int.parse( responseData['expiresIn']),),);
    autoLogOut();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({'token':token,'userId':userId,'expirydate':expireyDate!.toIso8601String()});
    prefs.setString('userData', userData);
    }

    catch(error){
      throw error;

    }

  }

  // Future<void> logintoAdmin(String? PhoneNumber,String? passowrd,String? urlSegment )async{
  //
  //     var url = Uri.parse('http://192.168.137.184/api/login'); // Replace with your Laravel login endpoint1
  //
  //   try {
  //     final response = await http.post(url, headers: {
  //       'Content-Type': 'application/json',
  //     },
  //         body: jsonEncode({
  //       'phone': PhoneNumber,
  //       'password': passowrd,
  //     })
  //     );
  //     if (response.statusCode == 200) {
  //       // Successful login
  //
  //       final Map<String, dynamic> data = json.decode(response.body);
  //       print('Login successful: ${data['message']}');
  //     } else {
  //       // Handle login failure
  //       print('Login failed: ${response.reasonPhrase}');
  //     }
  //   }
  //   catch(error){
  //     throw error;
  //
  //   }
  // }


  Future<void> signUp( String PhoneNumber ,String passowrd)async{
    return logintoAdmin(PhoneNumber,passowrd,'signUp');
  }

  Future<void> login( String PhoneNumber ,String passowrd)async{
    return logintoAdmin(PhoneNumber,passowrd,'signInWithPassword');

  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  Future<bool> tryAutoLogin() async{
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData'))
    {
      return false;
    }
    final extactedUserdata = json.decode(prefs.getString('userData')!);
    final expiryDate = DateTime.parse(extactedUserdata['expirydate']);
    //print(expireyDate!.isBefore(DateTime.now()));
    // if(expireyDate!.isBefore(DateTime.now())){
    //   return false;
    // }
    token = extactedUserdata['token'];
    userId = extactedUserdata['userId'];
    expireyDate = expiryDate;
    notifyListeners();
    autoLogOut();
    return true;
  }

  Future<void> logOut() async {
    token=null;
    userId=null;
    expireyDate=null;
    if(authTimer!=null){
      {
        authTimer!.cancel();
        authTimer = null;
      }
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogOut(){
    if(authTimer!=null){
      authTimer!.cancel();
    }
    final timeToExpiry = expireyDate!.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
  }

}