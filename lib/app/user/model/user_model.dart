import 'package:kulfii_app/app_resources/app_strings.dart';


class UserModel{
  final String userName;
  final String userContact;
  final String userAddress;
  final String userAge;
   final String userEmail;
  final String userProfileImage;
  final String userUid;
  
  
  UserModel({
    required this.userName,
    required this.userContact,
    required this.userAddress,
    required this.userAge,
   required this.userEmail,
    required this.userProfileImage,
    required this.userUid
  });

  Map<String, dynamic> toJson()=>{
  AppConstant.USER_NAME:userName,
  AppConstant.USER_CONTACT: userContact,
  AppConstant.USER_ADDRESS: userAddress,
  };
  static UserModel fromJson(Map<String,dynamic> userData){
    return UserModel(
      userName: userData[AppConstant.USER_NAME]??"",
      userContact: userData[AppConstant.USER_CONTACT]??"", 
      userAddress: userData[AppConstant.USER_ADDRESS]??"", 
      userAge: '', userEmail: '', 
      userProfileImage: '', 
      userUid: '',
      );
  }
}