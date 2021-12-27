import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  final String username;
  final String name;
  final String category;

  User({
    required this.username,
    required this.name,
    required this.category,
  });

  // int username;
  // String email;
  // String password;
  // String firstName;
  // String lastName;
  // String timeCreated;
  // int mobile;
  // String imageUrl;
  // bool isOnline;
  // String category;
  // String college;
  // String location;
  // String descirption;
  // int studentClass;
  // String topics;
  // String profession;
  // String professionalskill;
  // String languages;
  // String school;
  // String subject;
  // String qualification;
  // int experience;
  // int othermobile;
  // String state;
  // String city;
  // String area;
  // int contactNo;
  // String aboutyou;
  // String nickname;
  // String favquote;
  // String lastLogin;
  // String lastActivity;
  //
  // User(
  //     {required this.username,
  //     required this.email,
  //     required this.password,
  //     required this.firstName,
  //     required this.lastName,
  //     required this.timeCreated,
  //     required this.mobile,
  //     required this.imageUrl,
  //     required this.isOnline,
  //     required this.category,
  //     required this.college,
  //     required this.location,
  //     required this.descirption,
  //     required this.studentClass,
  //     required this.topics,
  //     required this.profession,
  //     required this.professionalskill,
  //     required this.languages,
  //     required this.school,
  //     required this.subject,
  //     required this.qualification,
  //     required this.experience,
  //     required this.othermobile,
  //     required this.state,
  //     required this.city,
  //     required this.area,
  //     required this.contactNo,
  //     required this.aboutyou,
  //     required this.nickname,
  //     required this.favquote,
  //     required this.lastLogin,
  //     required this.lastActivity});
  //
  // static User fromJson(Map<String, dynamic> json) {
  //   return User(
  //     username: json['username'],
  //     email: json['email'],
  //     password: json['password'],
  //     firstName: json['first_name'],
  //     lastName: json['last_name'],
  //     timeCreated: json['time_created'],
  //     mobile: json['mobile'],
  //     imageUrl: json['image_url'],
  //     isOnline: json['is_online'],
  //     category: json['category'],
  //     college: json['college'],
  //     location: json['location'],
  //     descirption: json['descirption'],
  //     studentClass: json['student_class'],
  //     topics: json['topics'],
  //     profession: json['profession'],
  //     professionalskill: json['professionalskill'],
  //     languages: json['languages'],
  //     school: json['school'],
  //     subject: json['subject'],
  //     qualification: json['qualification'],
  //     experience: json['experience'],
  //     othermobile: json['othermobile'],
  //     state: json['state'],
  //     city: json['city'],
  //     area: json['area'],
  //     contactNo: json['contact_no'],
  //     aboutyou: json['aboutyou'],
  //     nickname: json['nickname'],
  //     favquote: json['favquote'],
  //     lastLogin: json['last_login'],
  //     lastActivity: json['last_activity'],
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['username'] = this.username;
  //   data['email'] = this.email;
  //   data['password'] = this.password;
  //   data['first_name'] = this.firstName;
  //   data['last_name'] = this.lastName;
  //   data['time_created'] = this.timeCreated;
  //   data['mobile'] = this.mobile;
  //   data['image_url'] = this.imageUrl;
  //   data['is_online'] = this.isOnline;
  //   data['category'] = this.category;
  //   data['college'] = this.college;
  //   data['location'] = this.location;
  //   data['descirption'] = this.descirption;
  //   data['student_class'] = this.studentClass;
  //   data['topics'] = this.topics;
  //   data['profession'] = this.profession;
  //   data['professionalskill'] = this.professionalskill;
  //   data['languages'] = this.languages;
  //   data['school'] = this.school;
  //   data['subject'] = this.subject;
  //   data['qualification'] = this.qualification;
  //   data['experience'] = this.experience;
  //   data['othermobile'] = this.othermobile;
  //   data['state'] = this.state;
  //   data['city'] = this.city;
  //   data['area'] = this.area;
  //   data['contact_no'] = this.contactNo;
  //   data['aboutyou'] = this.aboutyou;
  //   data['nickname'] = this.nickname;
  //   data['favquote'] = this.favquote;
  //   data['last_login'] = this.lastLogin;
  //   data['last_activity'] = this.lastActivity;
  //   return data;
  // }
}

// {
// "username": 123,
// "email": "abc",
// "password": "dsadsadsdsaas",
// "first_name": "adsa",
// "last_name": "adsa",
// "time_created": "dassa",
// "mobile": 12313212,
// "image_url": "dasdsad",
// "is_online": true,
// "category": "student",
// "college": "asd",
// "location": "dasdas",
// "descirption": "hi",
// "student_class": 5,
// "topics": "ddsasads",
// "profession": "abc",
// "professionalskill": "ahsd",
// "languages": "dsadas",
// "school": "dsahjdshadja",
// "subject": "dashdasd",
// "qualification": "asddsa",
// "experience": 4,
// "othermobile": 454321,
// "state": "dsad",
// "city": "adas",
// "area": "dasdsa",
// "contact_no": 12321321,
// "aboutyou": "dashdsaj",
// "nickname": "dashd",
// "favquote": "dasjhsjad",
// "last_login": "dasdsd",
// "last_activity": "asdhajksdhak"
// }
