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

import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Student type in your schema. */
@immutable
class Student extends Model {
  static const classType = const _StudentModelType();
  final String id;
  final String? _studentID;
  final String? _studentName;
  final String? _email;
  final String? _phoneNumber;
  final String? _address;
  final String? _profilePhoto;
  final String? _idCardPhoto;
  final String? _roll;
  final List<double>? _modelData;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _classRoomStudentsId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get studentID {
    try {
      return _studentID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get studentName {
    try {
      return _studentName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get email {
    return _email;
  }
  
  String? get phoneNumber {
    return _phoneNumber;
  }
  
  String? get address {
    return _address;
  }
  
  String? get profilePhoto {
    return _profilePhoto;
  }
  
  String? get idCardPhoto {
    return _idCardPhoto;
  }
  
  String? get roll {
    return _roll;
  }
  
  List<double>? get modelData {
    return _modelData;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get classRoomStudentsId {
    return _classRoomStudentsId;
  }
  
  const Student._internal({required this.id, required studentID, required studentName, email, phoneNumber, address, profilePhoto, idCardPhoto, roll, modelData, createdAt, updatedAt, classRoomStudentsId}): _studentID = studentID, _studentName = studentName, _email = email, _phoneNumber = phoneNumber, _address = address, _profilePhoto = profilePhoto, _idCardPhoto = idCardPhoto, _roll = roll, _modelData = modelData, _createdAt = createdAt, _updatedAt = updatedAt, _classRoomStudentsId = classRoomStudentsId;
  
  factory Student({String? id, required String studentID, required String studentName, String? email, String? phoneNumber, String? address, String? profilePhoto, String? idCardPhoto, String? roll, List<double>? modelData, String? classRoomStudentsId}) {
    return Student._internal(
      id: id == null ? UUID.getUUID() : id,
      studentID: studentID,
      studentName: studentName,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      profilePhoto: profilePhoto,
      idCardPhoto: idCardPhoto,
      roll: roll,
      modelData: modelData != null ? List<double>.unmodifiable(modelData) : modelData,
      classRoomStudentsId: classRoomStudentsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Student &&
      id == other.id &&
      _studentID == other._studentID &&
      _studentName == other._studentName &&
      _email == other._email &&
      _phoneNumber == other._phoneNumber &&
      _address == other._address &&
      _profilePhoto == other._profilePhoto &&
      _idCardPhoto == other._idCardPhoto &&
      _roll == other._roll &&
      DeepCollectionEquality().equals(_modelData, other._modelData) &&
      _classRoomStudentsId == other._classRoomStudentsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Student {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("studentID=" + "$_studentID" + ", ");
    buffer.write("studentName=" + "$_studentName" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phoneNumber=" + "$_phoneNumber" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("profilePhoto=" + "$_profilePhoto" + ", ");
    buffer.write("idCardPhoto=" + "$_idCardPhoto" + ", ");
    buffer.write("roll=" + "$_roll" + ", ");
    buffer.write("modelData=" + (_modelData != null ? _modelData!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("classRoomStudentsId=" + "$_classRoomStudentsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Student copyWith({String? id, String? studentID, String? studentName, String? email, String? phoneNumber, String? address, String? profilePhoto, String? idCardPhoto, String? roll, List<double>? modelData, String? classRoomStudentsId}) {
    return Student._internal(
      id: id ?? this.id,
      studentID: studentID ?? this.studentID,
      studentName: studentName ?? this.studentName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      idCardPhoto: idCardPhoto ?? this.idCardPhoto,
      roll: roll ?? this.roll,
      modelData: modelData ?? this.modelData,
      classRoomStudentsId: classRoomStudentsId ?? this.classRoomStudentsId);
  }
  
  Student.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _studentID = json['studentID'],
      _studentName = json['studentName'],
      _email = json['email'],
      _phoneNumber = json['phoneNumber'],
      _address = json['address'],
      _profilePhoto = json['profilePhoto'],
      _idCardPhoto = json['idCardPhoto'],
      _roll = json['roll'],
      _modelData = (json['modelData'] as List?)?.map((e) => (e as num).toDouble()).toList(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _classRoomStudentsId = json['classRoomStudentsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'studentID': _studentID, 'studentName': _studentName, 'email': _email, 'phoneNumber': _phoneNumber, 'address': _address, 'profilePhoto': _profilePhoto, 'idCardPhoto': _idCardPhoto, 'roll': _roll, 'modelData': _modelData, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'classRoomStudentsId': _classRoomStudentsId
  };

  static final QueryField ID = QueryField(fieldName: "student.id");
  static final QueryField STUDENTID = QueryField(fieldName: "studentID");
  static final QueryField STUDENTNAME = QueryField(fieldName: "studentName");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHONENUMBER = QueryField(fieldName: "phoneNumber");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField PROFILEPHOTO = QueryField(fieldName: "profilePhoto");
  static final QueryField IDCARDPHOTO = QueryField(fieldName: "idCardPhoto");
  static final QueryField ROLL = QueryField(fieldName: "roll");
  static final QueryField MODELDATA = QueryField(fieldName: "modelData");
  static final QueryField CLASSROOMSTUDENTSID = QueryField(fieldName: "classRoomStudentsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Student";
    modelSchemaDefinition.pluralName = "Students";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.STUDENTID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.STUDENTNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.PHONENUMBER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.PROFILEPHOTO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.IDCARDPHOTO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.ROLL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.MODELDATA,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.double))
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.CLASSROOMSTUDENTSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _StudentModelType extends ModelType<Student> {
  const _StudentModelType();
  
  @override
  Student fromJson(Map<String, dynamic> jsonData) {
    return Student.fromJson(jsonData);
  }
}