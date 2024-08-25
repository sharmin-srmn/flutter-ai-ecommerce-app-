// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class UserModel {
  //keeping those values final which we dont want to update
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;
  String dateOfBirth;
  String gender;
  String address;
  String role;

  ///Constructor for usemodel
  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture,
      this.role = 'user',
      this.dateOfBirth = 'N/A',
      this.gender = 'N/A',
      this.address = 'N/A'});

  //HELPER FUNCTION TO GET THE FULL NAME
  String get fullName {
    // Capitalize the first letter of the first name
    String capitalizedFirstName = firstName.isNotEmpty
        ? '${firstName[0].toUpperCase()}${firstName.substring(1)}'
        : '';

    // Capitalize the first letter of the last name
    String capitalizedLastName = lastName.isNotEmpty
        ? '${lastName[0].toUpperCase()}${lastName.substring(1)}'
        : '';

    // Combine the capitalized first and last names with a space in between
    return '$capitalizedFirstName $capitalizedLastName';
  }

  // String get fullName => '$firstName $lastName';
  // '${firstName[0].toUpperCase()}${firstName.substring(1)} ${lastName[0].toUpperCase()}${lastName.substring(1)}';

  //HELPER FUNCTION TO FORMAT PHONE NUMBER
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  ///static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  ///static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername";

    return usernameWithPrefix;
  }

  ///STATIC FUNCTION TO CREATE EMPTY USER MODEL
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        userName: '',
        email: '',
        role: '',
        phoneNumber: '',
        profilePicture: '',
        dateOfBirth: '',
        gender: '',
        address: '',
      );

  /// CONVERT MODEL TO JSON STRUCTURE FOR STORING DATA IN FIREBASE
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Role': role,
      'ProfilePicture': profilePicture,
      'DoB': dateOfBirth,
      'Gender': gender,
      'Address': address,
    };
  }

  // /FACTORY METHOD TO CREATE A USERMODEL FROM A FIREBASE DOCUMENT SNAPSHOT
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data['FirstName'] ?? '',
          lastName: data['LastName'] ?? '',
          userName: data['Username'] ?? '',
          role: data['Role'] ?? '',
          email: data['Email'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '',
          dateOfBirth: data['DoB'] ?? 'N/A',
          gender: data['Gender'] ?? 'N/A',
          address: data['Address'] ?? 'N/A');
    } else {
      return UserModel.empty();
    }
  }
}
