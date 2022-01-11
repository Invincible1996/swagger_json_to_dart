// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// GenerateService
// **************************************************************************
///@desc Result
class Result {
  String code;
  dynamic data;
  String message;

  Result({
    this.code,
    this.data,
    this.message,
  });

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = this.code;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}

///
/// @desc LoginResVO
///
class LoginResVO {
  int age;
  int id;
  List<Person> personList;
  UserAddress userAddress;
  String username;

  LoginResVO({
    this.age,
    this.id,
    this.personList,
    this.userAddress,
    this.username,
  });

  LoginResVO.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    id = json['id'];
    if (json['personList'] != null) {
      personList = <Person>[];
      json['personList'].forEach((v) {
        personList.add(Person.fromJson(v));
      });
    }
    userAddress = json['userAddress'] != null
        ? UserAddress.fromJson(json['userAddress'])
        : null;
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['age'] = this.age;
    data['id'] = this.id;
    if (this.personList != null) {
      data['personList'] = this.personList.map((v) => v.toJson()).toList();
    }
    if (this.userAddress != null) {
      data['userAddress'] = this.userAddress.toJson();
    }
    data['username'] = this.username;
    return data;
  }
}

///
/// @desc Person
///
class Person {
  int age;
  int id;
  String username;

  Person({
    this.age,
    this.id,
    this.username,
  });

  Person.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['age'] = this.age;
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}

///
/// @desc UserAddress
///
class UserAddress {
  String city;
  String province;
  String religion;

  UserAddress({
    this.city,
    this.province,
    this.religion,
  });

  UserAddress.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    province = json['province'];
    religion = json['religion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['city'] = this.city;
    data['province'] = this.province;
    data['religion'] = this.religion;
    return data;
  }
}
