import 'dart:convert';

import 'package:fastcheque_admin/model/store_model.dart';

class StaffModel {
  String id;
  String uid;
  String name;
  String email;
  String signatureUrl;
  bool isProfileActive;
  bool isPasswordTemporary;
  bool hasManagerApproved;
  String firebaseFCMToken;
  String userType;
  StoreModel taggedStore;
  StaffModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.signatureUrl,
    required this.isProfileActive,
    required this.isPasswordTemporary,
    required this.hasManagerApproved,
    required this.firebaseFCMToken,
    required this.userType,
    required this.taggedStore,
  });

  StaffModel copyWith({
    String? id,
    String? uid,
    String? name,
    String? email,
    String? signatureUrl,
    bool? isProfileActive,
    bool? isPasswordTemporary,
    bool? hasManagerApproved,
    String? firebaseFCMToken,
    String? userType,
    StoreModel? taggedStore,
  }) {
    return StaffModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      signatureUrl: signatureUrl ?? this.signatureUrl,
      isProfileActive: isProfileActive ?? this.isProfileActive,
      isPasswordTemporary: isPasswordTemporary ?? this.isPasswordTemporary,
      hasManagerApproved: hasManagerApproved ?? this.hasManagerApproved,
      firebaseFCMToken: firebaseFCMToken ?? this.firebaseFCMToken,
      userType: userType ?? this.userType,
      taggedStore: taggedStore ?? this.taggedStore,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'email': email,
      'signatureUrl': signatureUrl,
      'isProfileActive': isProfileActive,
      'isPasswordTemporary': isPasswordTemporary,
      'hasManagerApproved': hasManagerApproved,
      'firebaseFCMToken': firebaseFCMToken,
      'userType': userType,
      'taggedStore': taggedStore.toMap(),
    };
  }

  factory StaffModel.fromMap(Map<String, dynamic> map) {
    return StaffModel(
      id: map['id'],
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      signatureUrl: map['signatureUrl'],
      isProfileActive: map['isProfileActive'],
      isPasswordTemporary: map['isPasswordTemporary'],
      hasManagerApproved: map['hasManagerApproved'],
      firebaseFCMToken: map['firebaseFCMToken'],
      userType: map['userType'],
      taggedStore: StoreModel.fromMap(map['taggedStore']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffModel.fromJson(String source) =>
      StaffModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StaffModel(id: $id, uid: $uid, name: $name, email: $email, signatureUrl: $signatureUrl, isProfileActive: $isProfileActive, isPasswordTemporary: $isPasswordTemporary, hasManagerApproved: $hasManagerApproved, firebaseFCMToken: $firebaseFCMToken, userType: $userType, taggedStore: $taggedStore)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StaffModel &&
        other.id == id &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.signatureUrl == signatureUrl &&
        other.isProfileActive == isProfileActive &&
        other.isPasswordTemporary == isPasswordTemporary &&
        other.hasManagerApproved == hasManagerApproved &&
        other.firebaseFCMToken == firebaseFCMToken &&
        other.userType == userType &&
        other.taggedStore == taggedStore;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        signatureUrl.hashCode ^
        isProfileActive.hashCode ^
        isPasswordTemporary.hashCode ^
        hasManagerApproved.hashCode ^
        firebaseFCMToken.hashCode ^
        userType.hashCode ^
        taggedStore.hashCode;
  }
}
