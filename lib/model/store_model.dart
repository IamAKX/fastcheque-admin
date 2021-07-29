import 'dart:convert';

class StoreModel {
  String id;
  String printerEmail;
  String routingAccountNumber;
  String bankAccountNumber;
  String bankName;
  String businessName;
  String businessAddress;
  String businessPhone;
  String chequeSequenceNumber;
  String bankLogoUrl;
  String businessLogoUrl;
  String businessEmail;
  StoreModel({
    required this.id,
    required this.printerEmail,
    required this.routingAccountNumber,
    required this.bankAccountNumber,
    required this.bankName,
    required this.businessName,
    required this.businessAddress,
    required this.businessPhone,
    required this.chequeSequenceNumber,
    required this.bankLogoUrl,
    required this.businessLogoUrl,
    required this.businessEmail,
  });

  StoreModel copyWith({
    String? id,
    String? printerEmail,
    String? routingAccountNumber,
    String? bankAccountNumber,
    String? bankName,
    String? businessName,
    String? businessAddress,
    String? businessPhone,
    String? chequeSequenceNumber,
    String? bankLogoUrl,
    String? businessLogoUrl,
    String? businessEmail,
  }) {
    return StoreModel(
      id: id ?? this.id,
      printerEmail: printerEmail ?? this.printerEmail,
      routingAccountNumber: routingAccountNumber ?? this.routingAccountNumber,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankName: bankName ?? this.bankName,
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      businessPhone: businessPhone ?? this.businessPhone,
      chequeSequenceNumber: chequeSequenceNumber ?? this.chequeSequenceNumber,
      bankLogoUrl: bankLogoUrl ?? this.bankLogoUrl,
      businessLogoUrl: businessLogoUrl ?? this.businessLogoUrl,
      businessEmail: businessEmail ?? this.businessEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'printerEmail': printerEmail,
      'routingAccountNumber': routingAccountNumber,
      'bankAccountNumber': bankAccountNumber,
      'bankName': bankName,
      'businessName': businessName,
      'businessAddress': businessAddress,
      'businessPhone': businessPhone,
      'chequeSequenceNumber': chequeSequenceNumber,
      'bankLogoUrl': bankLogoUrl,
      'businessLogoUrl': businessLogoUrl,
      'businessEmail': businessEmail,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'],
      printerEmail: map['printerEmail'],
      routingAccountNumber: map['routingAccountNumber'],
      bankAccountNumber: map['bankAccountNumber'],
      bankName: map['bankName'],
      businessName: map['businessName'],
      businessAddress: map['businessAddress'],
      businessPhone: map['businessPhone'],
      chequeSequenceNumber: map['chequeSequenceNumber'],
      bankLogoUrl: map['bankLogoUrl'],
      businessLogoUrl: map['businessLogoUrl'],
      businessEmail: map['businessEmail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) =>
      StoreModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StoreModel(id: $id, printerEmail: $printerEmail, routingAccountNumber: $routingAccountNumber, bankAccountNumber: $bankAccountNumber, bankName: $bankName, businessName: $businessName, businessAddress: $businessAddress, businessPhone: $businessPhone, chequeSequenceNumber: $chequeSequenceNumber, bankLogoUrl: $bankLogoUrl, businessLogoUrl: $businessLogoUrl, businessEmail: $businessEmail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoreModel &&
        other.id == id &&
        other.printerEmail == printerEmail &&
        other.routingAccountNumber == routingAccountNumber &&
        other.bankAccountNumber == bankAccountNumber &&
        other.bankName == bankName &&
        other.businessName == businessName &&
        other.businessAddress == businessAddress &&
        other.businessPhone == businessPhone &&
        other.chequeSequenceNumber == chequeSequenceNumber &&
        other.bankLogoUrl == bankLogoUrl &&
        other.businessLogoUrl == businessLogoUrl &&
        other.businessEmail == businessEmail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        printerEmail.hashCode ^
        routingAccountNumber.hashCode ^
        bankAccountNumber.hashCode ^
        bankName.hashCode ^
        businessName.hashCode ^
        businessAddress.hashCode ^
        businessPhone.hashCode ^
        chequeSequenceNumber.hashCode ^
        bankLogoUrl.hashCode ^
        businessLogoUrl.hashCode ^
        businessEmail.hashCode;
  }
}
