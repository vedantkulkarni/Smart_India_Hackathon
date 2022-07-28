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


/** This is an auto generated class representing the School type in your schema. */
@immutable
class School extends Model {
  static const classType = const _SchoolModelType();
  final String id;
  final String? _superAdmin;
  final String? _schoolName;
  final String? _schoolID;
  final String? _address;
  final String? _contactPhone;
  final String? _contactEmail;
  final int? _studentCount;
  final int? _teacherCount;
  final String? _location;
  final List<Group>? _groups;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get superAdmin {
    try {
      return _superAdmin!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get schoolName {
    try {
      return _schoolName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get schoolID {
    try {
      return _schoolID!;
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
  
  String? get contactPhone {
    return _contactPhone;
  }
  
  String? get contactEmail {
    return _contactEmail;
  }
  
  int? get studentCount {
    return _studentCount;
  }
  
  int? get teacherCount {
    return _teacherCount;
  }
  
  String? get location {
    return _location;
  }
  
  List<Group>? get groups {
    return _groups;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const School._internal({required this.id, required superAdmin, required schoolName, required schoolID, address, contactPhone, contactEmail, studentCount, teacherCount, location, groups, createdAt, updatedAt}): _superAdmin = superAdmin, _schoolName = schoolName, _schoolID = schoolID, _address = address, _contactPhone = contactPhone, _contactEmail = contactEmail, _studentCount = studentCount, _teacherCount = teacherCount, _location = location, _groups = groups, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory School({String? id, required String superAdmin, required String schoolName, required String schoolID, String? address, String? contactPhone, String? contactEmail, int? studentCount, int? teacherCount, String? location, List<Group>? groups}) {
    return School._internal(
      id: id == null ? UUID.getUUID() : id,
      superAdmin: superAdmin,
      schoolName: schoolName,
      schoolID: schoolID,
      address: address,
      contactPhone: contactPhone,
      contactEmail: contactEmail,
      studentCount: studentCount,
      teacherCount: teacherCount,
      location: location,
      groups: groups != null ? List<Group>.unmodifiable(groups) : groups);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is School &&
      id == other.id &&
      _superAdmin == other._superAdmin &&
      _schoolName == other._schoolName &&
      _schoolID == other._schoolID &&
      _address == other._address &&
      _contactPhone == other._contactPhone &&
      _contactEmail == other._contactEmail &&
      _studentCount == other._studentCount &&
      _teacherCount == other._teacherCount &&
      _location == other._location &&
      DeepCollectionEquality().equals(_groups, other._groups);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("School {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("superAdmin=" + "$_superAdmin" + ", ");
    buffer.write("schoolName=" + "$_schoolName" + ", ");
    buffer.write("schoolID=" + "$_schoolID" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("contactPhone=" + "$_contactPhone" + ", ");
    buffer.write("contactEmail=" + "$_contactEmail" + ", ");
    buffer.write("studentCount=" + (_studentCount != null ? _studentCount!.toString() : "null") + ", ");
    buffer.write("teacherCount=" + (_teacherCount != null ? _teacherCount!.toString() : "null") + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  School copyWith({String? id, String? superAdmin, String? schoolName, String? schoolID, String? address, String? contactPhone, String? contactEmail, int? studentCount, int? teacherCount, String? location, List<Group>? groups}) {
    return School._internal(
      id: id ?? this.id,
      superAdmin: superAdmin ?? this.superAdmin,
      schoolName: schoolName ?? this.schoolName,
      schoolID: schoolID ?? this.schoolID,
      address: address ?? this.address,
      contactPhone: contactPhone ?? this.contactPhone,
      contactEmail: contactEmail ?? this.contactEmail,
      studentCount: studentCount ?? this.studentCount,
      teacherCount: teacherCount ?? this.teacherCount,
      location: location ?? this.location,
      groups: groups ?? this.groups);
  }
  
  School.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _superAdmin = json['superAdmin'],
      _schoolName = json['schoolName'],
      _schoolID = json['schoolID'],
      _address = json['address'],
      _contactPhone = json['contactPhone'],
      _contactEmail = json['contactEmail'],
      _studentCount = (json['studentCount'] as num?)?.toInt(),
      _teacherCount = (json['teacherCount'] as num?)?.toInt(),
      _location = json['location'],
      _groups = json['groups'] is List
        ? (json['groups'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Group.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'superAdmin': _superAdmin, 'schoolName': _schoolName, 'schoolID': _schoolID, 'address': _address, 'contactPhone': _contactPhone, 'contactEmail': _contactEmail, 'studentCount': _studentCount, 'teacherCount': _teacherCount, 'location': _location, 'groups': _groups?.map((Group? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "school.id");
  static final QueryField SUPERADMIN = QueryField(fieldName: "superAdmin");
  static final QueryField SCHOOLNAME = QueryField(fieldName: "schoolName");
  static final QueryField SCHOOLID = QueryField(fieldName: "schoolID");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField CONTACTPHONE = QueryField(fieldName: "contactPhone");
  static final QueryField CONTACTEMAIL = QueryField(fieldName: "contactEmail");
  static final QueryField STUDENTCOUNT = QueryField(fieldName: "studentCount");
  static final QueryField TEACHERCOUNT = QueryField(fieldName: "teacherCount");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField GROUPS = QueryField(
    fieldName: "groups",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Group).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "School";
    modelSchemaDefinition.pluralName = "Schools";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: School.SUPERADMIN,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: School.SCHOOLNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: School.SCHOOLID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: School.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: School.CONTACTPHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: School.CONTACTEMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: School.STUDENTCOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: School.TEACHERCOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: School.LOCATION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: School.GROUPS,
      isRequired: false,
      ofModelName: (Group).toString(),
      associatedKey: Group.SCHOOLGROUPSID
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

class _SchoolModelType extends ModelType<School> {
  const _SchoolModelType();
  
  @override
  School fromJson(Map<String, dynamic> jsonData) {
    return School.fromJson(jsonData);
  }
}