import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fastcheque_admin/model/store_model.dart';

class ManagerModel {
  String id;
  String name;
  String email;
  bool isProfileActive;
  bool isPasswordTemporary;
  String userType;
  List<StoreModel> taggedStores;
  ManagerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isProfileActive,
    required this.isPasswordTemporary,
    required this.userType,
    required this.taggedStores,
  });

  ManagerModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isProfileActive,
    bool? isPasswordTemporary,
    String? userType,
    List<StoreModel>? taggedStores,
  }) {
    return ManagerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isProfileActive: isProfileActive ?? this.isProfileActive,
      isPasswordTemporary: isPasswordTemporary ?? this.isPasswordTemporary,
      userType: userType ?? this.userType,
      taggedStores: taggedStores ?? this.taggedStores,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isProfileActive': isProfileActive,
      'isPasswordTemporary': isPasswordTemporary,
      'userType': userType,
      'taggedStores': taggedStores.map((x) => x.toMap()).toList(),
    };
  }

  factory ManagerModel.fromMap(Map<String, dynamic> map) {
    return ManagerModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      isProfileActive: map['isProfileActive'],
      isPasswordTemporary: map['isPasswordTemporary'],
      userType: map['userType'],
      taggedStores: List<StoreModel>.from(
          map['taggedStores'].map((x) => StoreModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ManagerModel.fromJson(String source) =>
      ManagerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ManagerModel(id: $id, name: $name, email: $email, isProfileActive: $isProfileActive, isPasswordTemporary: $isPasswordTemporary, userType: $userType, taggedStores: $taggedStores)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ManagerModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.isProfileActive == isProfileActive &&
        other.isPasswordTemporary == isPasswordTemporary &&
        other.userType == userType &&
        listEquals(other.taggedStores, taggedStores);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        isProfileActive.hashCode ^
        isPasswordTemporary.hashCode ^
        userType.hashCode ^
        taggedStores.hashCode;
  }
}
