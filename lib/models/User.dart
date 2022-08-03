/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _email;
  final String? _name;
  final String? _description;
  final Role? _role;
  final String? _phoneNumber;
  final String? _address;
  final List<ClassRoom>? _assignedClass;
  final String? _idCard;
  final String? _photo;
  final String? _shitfInfo;
  final String? _gender;
  final int? _age;
  final String? _schoolID;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get description {
    return _description;
  }
  
  Role get role {
    try {
      return _role!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get phoneNumber {
    try {
      return _phoneNumber!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get address {
    return _address;
  }
  
  List<ClassRoom>? get assignedClass {
    return _assignedClass;
  }
  
  String? get idCard {
    return _idCard;
  }
  
  String? get photo {
    return _photo;
  }
  
  String? get shitfInfo {
    return _shitfInfo;
  }
  
  String? get gender {
    return _gender;
  }
  
  int? get age {
    return _age;
  }
  
  String? get schoolID {
    return _schoolID;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, required email, required name, description, required role, required phoneNumber, address, assignedClass, idCard, photo, shitfInfo, gender, age, schoolID, createdAt, updatedAt}): _email = email, _name = name, _description = description, _role = role, _phoneNumber = phoneNumber, _address = address, _assignedClass = assignedClass, _idCard = idCard, _photo = photo, _shitfInfo = shitfInfo, _gender = gender, _age = age, _schoolID = schoolID, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, required String email, required String name, String? description, required Role role, required String phoneNumber, String? address, List<ClassRoom>? assignedClass, String? idCard, String? photo, String? shitfInfo, String? gender, int? age, String? schoolID}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      email: email,
      name: name,
      description: description,
      role: role,
      phoneNumber: phoneNumber,
      address: address,
      assignedClass: assignedClass != null ? List<ClassRoom>.unmodifiable(assignedClass) : assignedClass,
      idCard: idCard,
      photo: photo,
      shitfInfo: shitfInfo,
      gender: gender,
      age: age,
      schoolID: schoolID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _email == other._email &&
      _name == other._name &&
      _description == other._description &&
      _role == other._role &&
      _phoneNumber == other._phoneNumber &&
      _address == other._address &&
      DeepCollectionEquality().equals(_assignedClass, other._assignedClass) &&
      _idCard == other._idCard &&
      _photo == other._photo &&
      _shitfInfo == other._shitfInfo &&
      _gender == other._gender &&
      _age == other._age &&
      _schoolID == other._schoolID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("role=" + (_role != null ? enumToString(_role)! : "null") + ", ");
    buffer.write("phoneNumber=" + "$_phoneNumber" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("idCard=" + "$_idCard" + ", ");
    buffer.write("photo=" + "$_photo" + ", ");
    buffer.write("shitfInfo=" + "$_shitfInfo" + ", ");
    buffer.write("gender=" + "$_gender" + ", ");
    buffer.write("age=" + (_age != null ? _age!.toString() : "null") + ", ");
    buffer.write("schoolID=" + "$_schoolID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? email, String? name, String? description, Role? role, String? phoneNumber, String? address, List<ClassRoom>? assignedClass, String? idCard, String? photo, String? shitfInfo, String? gender, int? age, String? schoolID}) {
    return User._internal(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      description: description ?? this.description,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      assignedClass: assignedClass ?? this.assignedClass,
      idCard: idCard ?? this.idCard,
      photo: photo ?? this.photo,
      shitfInfo: shitfInfo ?? this.shitfInfo,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      schoolID: schoolID ?? this.schoolID);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _email = json['email'],
      _name = json['name'],
      _description = json['description'],
      _role = enumFromString<Role>(json['role'], Role.values),
      _phoneNumber = json['phoneNumber'],
      _address = json['address'],
      _assignedClass = json['assignedClass'] is List
        ? (json['assignedClass'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ClassRoom.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _idCard = json['idCard'],
      _photo = json['photo'],
      _shitfInfo = json['shitfInfo'],
      _gender = json['gender'],
      _age = (json['age'] as num?)?.toInt(),
      _schoolID = json['schoolID'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'email': _email, 'name': _name, 'description': _description, 'role': enumToString(_role), 'phoneNumber': _phoneNumber, 'address': _address, 'assignedClass': _assignedClass?.map((ClassRoom? e) => e?.toJson()).toList(), 'idCard': _idCard, 'photo': _photo, 'shitfInfo': _shitfInfo, 'gender': _gender, 'age': _age, 'schoolID': _schoolID, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField ROLE = QueryField(fieldName: "role");
  static final QueryField PHONENUMBER = QueryField(fieldName: "phoneNumber");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField ASSIGNEDCLASS = QueryField(
    fieldName: "assignedClass",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ClassRoom).toString()));
  static final QueryField IDCARD = QueryField(fieldName: "idCard");
  static final QueryField PHOTO = QueryField(fieldName: "photo");
  static final QueryField SHITFINFO = QueryField(fieldName: "shitfInfo");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField AGE = QueryField(fieldName: "age");
  static final QueryField SCHOOLID = QueryField(fieldName: "schoolID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ROLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONENUMBER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.ASSIGNEDCLASS,
      isRequired: false,
      ofModelName: (ClassRoom).toString(),
      associatedKey: ClassRoom.USERASSIGNEDCLASSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.IDCARD,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHOTO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SHITFINFO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.GENDER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.AGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SCHOOLID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}