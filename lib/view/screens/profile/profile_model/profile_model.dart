import 'dart:convert';

class ProfileModel {
  int? code;
  String? message;
  Data? data;

  ProfileModel({
    this.code,
    this.message,
    this.data,
  });

  factory ProfileModel.fromRawJson(String str) =>
      ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Attributes? attributes;

  Data({
    this.attributes,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attributes: json["attributes"] == null
            ? null
            : Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes?.toJson(),
      };
}

class Attributes {
  User? user;
  String? mySubscription;

  Attributes({
    this.user,
    this.mySubscription,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        mySubscription: json["mySubscription"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "mySubscription": mySubscription,
      };
}

class User {
  String? name;
  String? email;
  List<Photo>? photo;
  String? phoneNumber;
  bool? isPhoneNumberVerified;
  String? role;
  dynamic oneTimeCode;
  bool? isEmailVerified;
  bool? isDeleted;
  bool? isSuspended;
  String? status;
  bool? payment;
  String? gender;
  String? profileFor;
  String? dataOfBirth;
  double? height;
  String? country;
  String? state;
  String? city;
  String? residentialStatus;
  String? education;
  String? workExperience;
  String? occupation;
  String? income;
  String? annualIncome;
  String? maritalStatus;
  String? motherTongue;
  String? religion;
  String? caste;
  String? sect;
  String? familyStatus;
  String? familyType;
  String? familyValues;
  String? familyIncome;
  String? fathersOccupation;
  String? mothersOccupation;
  String? brothers;
  String? sisters;
  String? habits;
  String? hobbies;
  String? favouriteMusic;
  String? favouriteMovies;
  String? sports;
  String? tvShows;
  String? partnerMinAge;
  String? partnerMixAge;
  String? partnerMinHeight;
  String? partnerMixHeight;
  String? partnerMaritalStatus;
  String? partnerCountry;
  String? partnerCity;
  String? partnerReligion;
  String? partnerResidentialStatus;
  String? partnerEducation;
  String? partnerSect;
  String? partnerCaste;
  String? partnerMotherTongue;
  String? partnerMaxIncome;
  String? partnerMinIncome;
  String? partnerOccupation;
  String? aboutMe;
  bool? isResetPassword;
  int? age;
  String? id;

  User({
    this.name,
    this.email,
    this.photo,
    this.phoneNumber,
    this.isPhoneNumberVerified,
    this.role,
    this.oneTimeCode,
    this.isEmailVerified,
    this.isDeleted,
    this.isSuspended,
    this.status,
    this.payment,
    this.gender,
    this.profileFor,
    this.dataOfBirth,
    this.height,
    this.country,
    this.state,
    this.city,
    this.residentialStatus,
    this.education,
    this.workExperience,
    this.occupation,
    this.income,
    this.annualIncome,
    this.maritalStatus,
    this.motherTongue,
    this.religion,
    this.caste,
    this.sect,
    this.familyStatus,
    this.familyType,
    this.familyValues,
    this.familyIncome,
    this.fathersOccupation,
    this.mothersOccupation,
    this.brothers,
    this.sisters,
    this.habits,
    this.hobbies,
    this.favouriteMusic,
    this.favouriteMovies,
    this.sports,
    this.tvShows,
    this.partnerMinAge,
    this.partnerMixAge,
    this.partnerMinHeight,
    this.partnerMixHeight,
    this.partnerMaritalStatus,
    this.partnerCountry,
    this.partnerCity,
    this.partnerReligion,
    this.partnerResidentialStatus,
    this.partnerEducation,
    this.partnerSect,
    this.partnerCaste,
    this.partnerMotherTongue,
    this.partnerMaxIncome,
    this.partnerMinIncome,
    this.partnerOccupation,
    this.aboutMe,
    this.isResetPassword,
    this.age,
    this.id,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] ?? "Loading",
        email: json["email"] ?? "Loading",
        photo: json["photo"] == null
            ? []
            : List<Photo>.from(json["photo"]!.map((x) => Photo.fromJson(x))),
        phoneNumber: json["phoneNumber"] ?? "Loading",
        isPhoneNumberVerified: json["isPhoneNumberVerified"] ?? true,
        role: json["role"] ?? "Loading",
        oneTimeCode: json["oneTimeCode"] ?? "Loading",
        isEmailVerified: json["isEmailVerified"] ?? true,
        isDeleted: json["isDeleted"] ?? false,
        isSuspended: json["isSuspended"] ?? false,
        status: json["status"] ?? "Loading",
        payment: json["payment"] ?? true,
        gender: json["gender"] ?? "Loading",
        profileFor: json["profileFor"] ?? "Loading",
        dataOfBirth: json["dataOfBirth"] ?? "Loading",
        height: json["height"]?.toDouble() ?? 0.0,
        country: json["country"] ?? "Loading",
        state: json["state"] ?? "Loading",
        city: json["city"] ?? "Loading",
        residentialStatus: json["residentialStatus"] ?? "Loading",
        education: json["education"] ?? "Loading",
        workExperience: json["workExperience"] ?? "Loading",
        occupation: json["occupation"] ?? "Loading",
        income: json["income"] ?? "Loading",
        annualIncome: json["annualIncome"] ?? "Loading",
        maritalStatus: json["maritalStatus"] ?? "Loading",
        motherTongue: json["motherTongue"] ?? "Loading",
        religion: json["religion"] ?? "Loading",
        caste: json["caste"] ?? "Loading",
        sect: json["sect"] ?? "Loading",
        familyStatus: json["familyStatus"] ?? "Loading",
        familyType: json["familyType"] ?? "Loading",
        familyValues: json["familyValues"] ?? "Loading",
        familyIncome: json["familyIncome"] ?? "Loading",
        fathersOccupation: json["fathersOccupation"] ?? "Loading",
        mothersOccupation: json["mothersOccupation"] ?? "Loading",
        brothers: json["brothers"] ?? "Loading",
        sisters: json["sisters"] ?? "Loading",
        habits: json["habits"] ?? "Loading",
        hobbies: json["hobbies"] ?? "Loading",
        favouriteMusic: json["favouriteMusic"] ?? "Loading",
        favouriteMovies: json["favouriteMovies"] ?? "Loading",
        sports: json["sports"] ?? "Loading",
        tvShows: json["tvShows"] ?? "Loading",
        partnerMinAge: json["partnerMinAge"] ?? "Loading",
        partnerMixAge: json["partnerMixAge"] ?? "Loading",
        partnerMinHeight: json["partnerMinHeight"] ?? "Loading",
        partnerMixHeight: json["partnerMixHeight"] ?? "Loading",
        partnerMaritalStatus: json["partnerMaritalStatus"] ?? "Loading",
        partnerCountry: json["partnerCountry"] ?? "Loading",
        partnerCity: json["partnerCity"] ?? "Loading",
        partnerReligion: json["partnerReligion"] ?? "Loading",
        partnerResidentialStatus: json["partnerResidentialStatus"] ?? "Loading",
        partnerEducation: json["partnerEducation"] ?? "Loading",
        partnerSect: json["partnerSect"] ?? "Loading",
        partnerCaste: json["partnerCaste"] ?? "Loading",
        partnerMotherTongue: json["partnerMotherTongue"] ?? "Loading",
        partnerMaxIncome: json["partnerMaxIncome"] ?? "Loading",
        partnerMinIncome: json["partnerMinIncome"] ?? "Loading",
        partnerOccupation: json["partnerOccupation"] ?? "Loading",
        aboutMe: json["aboutMe"] ?? "Loading",
        isResetPassword: json["isResetPassword"] ?? false,
        age: json["age"] ?? 0,
        id: json["id"] ?? "00",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "photo": photo == null
            ? []
            : List<dynamic>.from(photo!.map((x) => x.toJson())),
        "phoneNumber": phoneNumber,
        "isPhoneNumberVerified": isPhoneNumberVerified,
        "role": role,
        "oneTimeCode": oneTimeCode,
        "isEmailVerified": isEmailVerified,
        "isDeleted": isDeleted,
        "isSuspended": isSuspended,
        "status": status,
        "payment": payment,
        "gender": gender,
        "profileFor": profileFor,
        "dataOfBirth": dataOfBirth,
        "height": height,
        "country": country,
        "state": state,
        "city": city,
        "residentialStatus": residentialStatus,
        "education": education,
        "workExperience": workExperience,
        "occupation": occupation,
        "income": income,
        "annualIncome": annualIncome,
        "maritalStatus": maritalStatus,
        "motherTongue": motherTongue,
        "religion": religion,
        "caste": caste,
        "sect": sect,
        "familyStatus": familyStatus,
        "familyType": familyType,
        "familyValues": familyValues,
        "familyIncome": familyIncome,
        "fathersOccupation": fathersOccupation,
        "mothersOccupation": mothersOccupation,
        "brothers": brothers,
        "sisters": sisters,
        "habits": habits,
        "hobbies": hobbies,
        "favouriteMusic": favouriteMusic,
        "favouriteMovies": favouriteMovies,
        "sports": sports,
        "tvShows": tvShows,
        "partnerMinAge": partnerMinAge,
        "partnerMixAge": partnerMixAge,
        "partnerMinHeight": partnerMinHeight,
        "partnerMixHeight": partnerMixHeight,
        "partnerMaritalStatus": partnerMaritalStatus,
        "partnerCountry": partnerCountry,
        "partnerCity": partnerCity,
        "partnerReligion": partnerReligion,
        "partnerResidentialStatus": partnerResidentialStatus,
        "partnerEducation": partnerEducation,
        "partnerSect": partnerSect,
        "partnerCaste": partnerCaste,
        "partnerMotherTongue": partnerMotherTongue,
        "partnerMaxIncome": partnerMaxIncome,
        "partnerMinIncome": partnerMinIncome,
        "partnerOccupation": partnerOccupation,
        "aboutMe": aboutMe,
        "isResetPassword": isResetPassword,
        "age": age,
        "id": id,
      };
}

class Photo {
  String? publicFileUrl;
  String? path;

  Photo({
    this.publicFileUrl,
    this.path,
  });

  factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        publicFileUrl: json["publicFileUrl"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "publicFileUrl": publicFileUrl,
        "path": path,
      };
}
