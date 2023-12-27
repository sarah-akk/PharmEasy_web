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

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  // Future<void> logintoAdmin(String? PhoneNumber,String? passowrd,String? urlSegment )async{
  //   var url = Uri.parse(
  //       'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAHN6mVcn_YLp_j7dzeGr5SgqRtrdiFAIg');
  //   try {final response =  await http.post(url,body: jsonEncode({
  //     'email':PhoneNumber,
  //     'password':passowrd,
  //     'returnSecureToken' :true,})
  //   );
  //   final responseData = json.decode(response.body);
  //
  //   token = responseData['idToken'];
  //   userId = responseData['localId'];
  //   expireyDate= DateTime.now().add(Duration(
  //     seconds:int.parse( responseData['expiresIn']),),);
  //   autoLogOut();
  //   notifyListeners();
  //   final prefs = await SharedPreferences.getInstance();
  //   final userData = json.encode({'token':token,'userId':userId,'expirydate':expireyDate!.toIso8601String()});
  //   prefs.setString('userData', userData);
  //   }
  //
  //   catch(error){
  //     throw error;
  //
  //   }
  //
  // }

  Future<String> logintoAdmin(String? phone,String? password )async{

      var url = Uri.parse('http://127.0.0.1:8000/api/login/admin');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'phone': phone, 'password': password}),
        headers: {'Content-Type': 'application/json'},
    );
      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200 && data['message']=='welcome.' ) {
        // Successful login
        final Map<String, dynamic> data = json.decode(response.body);
        token = data['data'];
        print(token);
        return 'success: ${data['message']}';
      } else {
        // Handle login failure
        return 'error: ${data['message']}';
      }
    }
    catch(error){
      throw error;
    }
  }


  Future<String> signUp( String PhoneNumber ,String passowrd)async{
    return logintoAdmin(PhoneNumber,passowrd);
  }

  Future<String> login( String PhoneNumber ,String passowrd)async{
    return logintoAdmin(PhoneNumber,passowrd);

  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  Future<String> logoutUser() async {
    var url = Uri.parse('http://10.0.2.2:8000/logout');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200 && data['message'] == 'user log out successfully') {
        return 'success: ${data['message']}';
      } else {
        // Handle logout failure
        return 'error: ${data['message']}';
      }
    } catch (error) {
      throw error;
    }
  }


}