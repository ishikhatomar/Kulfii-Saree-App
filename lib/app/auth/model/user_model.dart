
class UserModel {
  final String username;
  final String uid;
  final String profileImageUrl;
  final String email;
  final List<String> address;
  final String phoneNumber;
  final String age;
  final List<Map<String,dynamic>> cart;
  final List<Map<String, dynamic>> wishList;

  UserModel({
    required this.cart,
    required this.email,
    required this.username,
    required this.uid,
    required this.profileImageUrl,
    required this.phoneNumber,
    required this.address,
    required this.age,
    required this.wishList,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profileImageUrl": profileImageUrl,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "age": age,
        "cart": cart,
        "wish_list": wishList,
      };

  static UserModel fromSnap(Map<String, dynamic> data) {
    return UserModel(
      wishList: ((data["wish_list"] ?? []) as List).cast<Map<String, dynamic>>(),  
      cart:((data["cart"] ?? []) as List).cast<Map<String, dynamic>>(),  
      username: data['user_name'] ?? "",
      uid: data['user_uid'] ?? "",
      profileImageUrl: data['profile_image_rrl'] ?? "",
      phoneNumber: data['phone_number'] ?? "",
      email: data['email'] ?? "",
      address:  ((data['address'] ?? []) as List).cast<String>(), 
      age: data['age'] ?? "" ,
    );
  }
}
