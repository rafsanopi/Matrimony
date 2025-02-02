import 'dart:convert';

class AuthModel {
  int? code;
  String? message;
  Data? data;

  AuthModel({
    this.code,
    this.message,
    this.data,
  });

  factory AuthModel.fromRawJson(String str) =>
      AuthModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
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
  Tokens? tokens;

  Attributes({
    this.user,
    this.tokens,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "tokens": tokens?.toJson(),
      };
}

class Tokens {
  Access? access;

  Tokens({
    this.access,
  });

  factory Tokens.fromRawJson(String str) => Tokens.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: json["access"] == null ? null : Access.fromJson(json["access"]),
      );

  Map<String, dynamic> toJson() => {
        "access": access?.toJson(),
      };
}

class Access {
  String? token;
  DateTime? expires;

  Access({
    this.token,
    this.expires,
  });

  factory Access.fromRawJson(String str) => Access.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        token: json["token"],
        expires:
            json["expires"] == null ? null : DateTime.parse(json["expires"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expires": expires?.toIso8601String(),
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
  bool? isProfilePictureCompleted;
  bool? isAboutMeCompleted;
  bool? isFamilyInformationCompleted;
  bool? isLifestyleInformationCompleted;
  bool? isPartnerPreferencesCompleted;
  dynamic phoneNumberOtp;
  bool? freeSubscription;
  String? subscription;
  String? fcmToken;
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
    this.isProfilePictureCompleted,
    this.isAboutMeCompleted,
    this.isFamilyInformationCompleted,
    this.isLifestyleInformationCompleted,
    this.isPartnerPreferencesCompleted,
    this.phoneNumberOtp,
    this.freeSubscription,
    this.subscription,
    this.fcmToken,
    this.id,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        photo: json["photo"] == null
            ? []
            : List<Photo>.from(json["photo"]!.map((x) => Photo.fromJson(x))),
        phoneNumber: json["phoneNumber"],
        isPhoneNumberVerified: json["isPhoneNumberVerified"],
        role: json["role"],
        oneTimeCode: json["oneTimeCode"],
        isEmailVerified: json["isEmailVerified"],
        isDeleted: json["isDeleted"],
        isSuspended: json["isSuspended"],
        status: json["status"],
        payment: json["payment"],
        gender: json["gender"],
        profileFor: json["profileFor"],
        dataOfBirth: json["dataOfBirth"],
        height: json["height"]?.toDouble(),
        country: json["country"],
        state: json["state"],
        city: json["city"],
        residentialStatus: json["residentialStatus"],
        education: json["education"],
        workExperience: json["workExperience"],
        occupation: json["occupation"],
        income: json["income"],
        annualIncome: json["annualIncome"],
        maritalStatus: json["maritalStatus"],
        motherTongue: json["motherTongue"],
        religion: json["religion"],
        caste: json["caste"],
        sect: json["sect"],
        familyStatus: json["familyStatus"],
        familyType: json["familyType"],
        familyValues: json["familyValues"],
        familyIncome: json["familyIncome"],
        fathersOccupation: json["fathersOccupation"],
        mothersOccupation: json["mothersOccupation"],
        brothers: json["brothers"],
        sisters: json["sisters"],
        habits: json["habits"],
        hobbies: json["hobbies"],
        favouriteMusic: json["favouriteMusic"],
        favouriteMovies: json["favouriteMovies"],
        sports: json["sports"],
        tvShows: json["tvShows"],
        partnerMinAge: json["partnerMinAge"],
        partnerMixAge: json["partnerMixAge"],
        partnerMinHeight: json["partnerMinHeight"],
        partnerMixHeight: json["partnerMixHeight"],
        partnerMaritalStatus: json["partnerMaritalStatus"],
        partnerCountry: json["partnerCountry"],
        partnerCity: json["partnerCity"],
        partnerReligion: json["partnerReligion"],
        partnerResidentialStatus: json["partnerResidentialStatus"],
        partnerEducation: json["partnerEducation"],
        partnerSect: json["partnerSect"],
        partnerCaste: json["partnerCaste"],
        partnerMotherTongue: json["partnerMotherTongue"],
        partnerMaxIncome: json["partnerMaxIncome"],
        partnerMinIncome: json["partnerMinIncome"],
        partnerOccupation: json["partnerOccupation"],
        aboutMe: json["aboutMe"],
        isResetPassword: json["isResetPassword"],
        age: json["age"],
        isProfilePictureCompleted: json["isProfilePictureCompleted"],
        isAboutMeCompleted: json["isAboutMeCompleted"],
        isFamilyInformationCompleted: json["isFamilyInformationCompleted"],
        isLifestyleInformationCompleted:
            json["isLifestyleInformationCompleted"],
        isPartnerPreferencesCompleted: json["isPartnerPreferencesCompleted"],
        phoneNumberOtp: json["phoneNumberOTP"],
        freeSubscription: json["freeSubscription"],
        subscription: json["subscription"],
        fcmToken: json["fcmToken"],
        id: json["id"],
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
        "isProfilePictureCompleted": isProfilePictureCompleted,
        "isAboutMeCompleted": isAboutMeCompleted,
        "isFamilyInformationCompleted": isFamilyInformationCompleted,
        "isLifestyleInformationCompleted": isLifestyleInformationCompleted,
        "isPartnerPreferencesCompleted": isPartnerPreferencesCompleted,
        "phoneNumberOTP": phoneNumberOtp,
        "freeSubscription": freeSubscription,
        "subscription": subscription,
        "fcmToken": fcmToken,
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
