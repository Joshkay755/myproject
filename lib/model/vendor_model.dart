import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor {
  Vendor({this.approved, this.businessName, this.city, this.state, this.country,
    this.email, this.landMark, this.logo, this.mobile, this.postalCode,
    this.taxRegistered, this.time, this.tpinNumber, this.uid});

  Vendor.fromJson(Map<String, Object?> json)
      : this(
    approved: json['approved'] as bool?,
    businessName: json['businessName'] as String?,
    city: json['city'] as String?,
    state: json['state'] as String?,
    country: json['country'] as String?,
    email: json['email'] as String?,
    landMark: json['landMark'] as String?,
    logo: json['logo'] as String?,
    mobile: json['mobile'] as String?,
    postalCode: json['postalCode'] as String?,
    taxRegistered: json['taxRegistered'] as String?,
    time: json['time'] as Timestamp?,
    tpinNumber: json['tpinNumber'] as String?,
    uid: json['uid'] as String?,


  );



  final bool? approved;
  final String? businessName;
  final String? city;
  final String? state;
  final String? country;
  final String? email;
  final String? landMark;
  final String? logo;
  final String? mobile;
  final String? postalCode;
  final String? taxRegistered;
  final Timestamp? time;
  final String? tpinNumber;
  final String? uid;

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'businessName': businessName,
      'city': city,
      'state': state,
      'country': country,
      'email': email,
      'landMark': landMark,
      'logo': logo,
      'mobile': mobile,
      'postalCode': postalCode,
      'taxRegistered': taxRegistered,
      'time': time,
      'tpinNumber': tpinNumber,
      'uid': uid,
    };
  }
}