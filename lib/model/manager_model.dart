import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fastcheque_admin/model/store_model.dart';

class ManagerModel {
  String id;
  String uid;
  String name;
  String email;
  String signatureUrl;
  bool isProfileActive;
  bool isPasswordTemporary;
  String firebaseFCMToken;
  String userType;
  List<StoreModel> taggedStores;
  ManagerModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.signatureUrl,
    required this.isProfileActive,
    required this.isPasswordTemporary,
    required this.firebaseFCMToken,
    required this.userType,
    required this.taggedStores,
  });

  ManagerModel copyWith({
    String? id,
    String? uid,
    String? name,
    String? email,
    String? signatureUrl,
    bool? isProfileActive,
    bool? isPasswordTemporary,
    String? firebaseFCMToken,
    String? userType,
    List<StoreModel>? taggedStores,
  }) {
    return ManagerModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      signatureUrl: signatureUrl ?? this.signatureUrl,
      isProfileActive: isProfileActive ?? this.isProfileActive,
      isPasswordTemporary: isPasswordTemporary ?? this.isPasswordTemporary,
      firebaseFCMToken: firebaseFCMToken ?? this.firebaseFCMToken,
      userType: userType ?? this.userType,
      taggedStores: taggedStores ?? this.taggedStores,
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
      'firebaseFCMToken': firebaseFCMToken,
      'userType': userType,
      'taggedStores': taggedStores?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ManagerModel.fromMap(Map<String, dynamic> map) {
    return ManagerModel(
      id: map['id'],
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      signatureUrl: map['signatureUrl'],
      isProfileActive: map['isProfileActive'],
      isPasswordTemporary: map['isPasswordTemporary'],
      firebaseFCMToken: map['firebaseFCMToken'],
      userType: map['userType'],
      taggedStores: List<StoreModel>.from(
          map['taggedStores']?.map((x) => StoreModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ManagerModel.fromJson(String source) =>
      ManagerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ManagerModel(id: $id, uid: $uid, name: $name, email: $email, signatureUrl: $signatureUrl, isProfileActive: $isProfileActive, isPasswordTemporary: $isPasswordTemporary, firebaseFCMToken: $firebaseFCMToken, userType: $userType, taggedStores: $taggedStores)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ManagerModel &&
        other.id == id &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.signatureUrl == signatureUrl &&
        other.isProfileActive == isProfileActive &&
        other.isPasswordTemporary == isPasswordTemporary &&
        other.firebaseFCMToken == firebaseFCMToken &&
        other.userType == userType &&
        listEquals(other.taggedStores, taggedStores);
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
        firebaseFCMToken.hashCode ^
        userType.hashCode ^
        taggedStores.hashCode;
  }
}
