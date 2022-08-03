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


/** This is an auto generated class representing the ClassRoom type in your schema. */
@immutable
class ClassRoom extends Model {
  static const classType = const _ClassRoomModelType();
  final String id;
  final String? _schoolID;
  final String? _classRoomName;
  final String? _assignedTeacherName;
  final List<Student>? _students;
  final int? _currentAttendance;
  final List<String>? _importantNotice;
  final VerificationStatus? _attendanceMode;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _userAssignedClassId;
  final String? _schoolClassRoomsId;
  final String? _groupClassRoomsId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  String get classRoomName {
    try {
      return _classRoomName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get assignedTeacherName {
    return _assignedTeacherName;
  }
  
  List<Student>? get students {
    return _students;
  }
  
  int? get currentAttendance {
    return _currentAttendance;
  }
  
  List<String>? get importantNotice {
    return _importantNotice;
  }
  
  VerificationStatus get attendanceMode {
    try {
      return _attendanceMode!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get userAssignedClassId {
    return _userAssignedClassId;
  }
  
  String? get schoolClassRoomsId {
    return _schoolClassRoomsId;
  }
  
  String? get groupClassRoomsId {
    return _groupClassRoomsId;
  }
  
  const ClassRoom._internal({required this.id, required schoolID, required classRoomName, assignedTeacherName, students, currentAttendance, importantNotice, required attendanceMode, createdAt, updatedAt, userAssignedClassId, schoolClassRoomsId, groupClassRoomsId}): _schoolID = schoolID, _classRoomName = classRoomName, _assignedTeacherName = assignedTeacherName, _students = students, _currentAttendance = currentAttendance, _importantNotice = importantNotice, _attendanceMode = attendanceMode, _createdAt = createdAt, _updatedAt = updatedAt, _userAssignedClassId = userAssignedClassId, _schoolClassRoomsId = schoolClassRoomsId, _groupClassRoomsId = groupClassRoomsId;
  
  factory ClassRoom({String? id, required String schoolID, required String classRoomName, String? assignedTeacherName, List<Student>? students, int? currentAttendance, List<String>? importantNotice, required VerificationStatus attendanceMode, String? userAssignedClassId, String? schoolClassRoomsId, String? groupClassRoomsId}) {
    return ClassRoom._internal(
      id: id == null ? UUID.getUUID() : id,
      schoolID: schoolID,
      classRoomName: classRoomName,
      assignedTeacherName: assignedTeacherName,
      students: students != null ? List<Student>.unmodifiable(students) : students,
      currentAttendance: currentAttendance,
      importantNotice: importantNotice != null ? List<String>.unmodifiable(importantNotice) : importantNotice,
      attendanceMode: attendanceMode,
      userAssignedClassId: userAssignedClassId,
      schoolClassRoomsId: schoolClassRoomsId,
      groupClassRoomsId: groupClassRoomsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassRoom &&
      id == other.id &&
      _schoolID == other._schoolID &&
      _classRoomName == other._classRoomName &&
      _assignedTeacherName == other._assignedTeacherName &&
      DeepCollectionEquality().equals(_students, other._students) &&
      _currentAttendance == other._currentAttendance &&
      DeepCollectionEquality().equals(_importantNotice, other._importantNotice) &&
      _attendanceMode == other._attendanceMode &&
      _userAssignedClassId == other._userAssignedClassId &&
      _schoolClassRoomsId == other._schoolClassRoomsId &&
      _groupClassRoomsId == other._groupClassRoomsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ClassRoom {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("schoolID=" + "$_schoolID" + ", ");
    buffer.write("classRoomName=" + "$_classRoomName" + ", ");
    buffer.write("assignedTeacherName=" + "$_assignedTeacherName" + ", ");
    buffer.write("currentAttendance=" + (_currentAttendance != null ? _currentAttendance!.toString() : "null") + ", ");
    buffer.write("importantNotice=" + (_importantNotice != null ? _importantNotice!.toString() : "null") + ", ");
    buffer.write("attendanceMode=" + (_attendanceMode != null ? enumToString(_attendanceMode)! : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("userAssignedClassId=" + "$_userAssignedClassId" + ", ");
    buffer.write("schoolClassRoomsId=" + "$_schoolClassRoomsId" + ", ");
    buffer.write("groupClassRoomsId=" + "$_groupClassRoomsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ClassRoom copyWith({String? id, String? schoolID, String? classRoomName, String? assignedTeacherName, List<Student>? students, int? currentAttendance, List<String>? importantNotice, VerificationStatus? attendanceMode, String? userAssignedClassId, String? schoolClassRoomsId, String? groupClassRoomsId}) {
    return ClassRoom._internal(
      id: id ?? this.id,
      schoolID: schoolID ?? this.schoolID,
      classRoomName: classRoomName ?? this.classRoomName,
      assignedTeacherName: assignedTeacherName ?? this.assignedTeacherName,
      students: students ?? this.students,
      currentAttendance: currentAttendance ?? this.currentAttendance,
      importantNotice: importantNotice ?? this.importantNotice,
      attendanceMode: attendanceMode ?? this.attendanceMode,
      userAssignedClassId: userAssignedClassId ?? this.userAssignedClassId,
      schoolClassRoomsId: schoolClassRoomsId ?? this.schoolClassRoomsId,
      groupClassRoomsId: groupClassRoomsId ?? this.groupClassRoomsId);
  }
  
  ClassRoom.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _schoolID = json['schoolID'],
      _classRoomName = json['classRoomName'],
      _assignedTeacherName = json['assignedTeacherName'],
      _students = json['students'] is List
        ? (json['students'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Student.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _currentAttendance = (json['currentAttendance'] as num?)?.toInt(),
      _importantNotice = json['importantNotice']?.cast<String>(),
      _attendanceMode = enumFromString<VerificationStatus>(json['attendanceMode'], VerificationStatus.values),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _userAssignedClassId = json['userAssignedClassId'],
      _schoolClassRoomsId = json['schoolClassRoomsId'],
      _groupClassRoomsId = json['groupClassRoomsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'schoolID': _schoolID, 'classRoomName': _classRoomName, 'assignedTeacherName': _assignedTeacherName, 'students': _students?.map((Student? e) => e?.toJson()).toList(), 'currentAttendance': _currentAttendance, 'importantNotice': _importantNotice, 'attendanceMode': enumToString(_attendanceMode), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'userAssignedClassId': _userAssignedClassId, 'schoolClassRoomsId': _schoolClassRoomsId, 'groupClassRoomsId': _groupClassRoomsId
  };

  static final QueryField ID = QueryField(fieldName: "classRoom.id");
  static final QueryField SCHOOLID = QueryField(fieldName: "schoolID");
  static final QueryField CLASSROOMNAME = QueryField(fieldName: "classRoomName");
  static final QueryField ASSIGNEDTEACHERNAME = QueryField(fieldName: "assignedTeacherName");
  static final QueryField STUDENTS = QueryField(
    fieldName: "students",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Student).toString()));
  static final QueryField CURRENTATTENDANCE = QueryField(fieldName: "currentAttendance");
  static final QueryField IMPORTANTNOTICE = QueryField(fieldName: "importantNotice");
  static final QueryField ATTENDANCEMODE = QueryField(fieldName: "attendanceMode");
  static final QueryField USERASSIGNEDCLASSID = QueryField(fieldName: "userAssignedClassId");
  static final QueryField SCHOOLCLASSROOMSID = QueryField(fieldName: "schoolClassRoomsId");
  static final QueryField GROUPCLASSROOMSID = QueryField(fieldName: "groupClassRoomsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ClassRoom";
    modelSchemaDefinition.pluralName = "ClassRooms";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClassRoom.SCHOOLID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClassRoom.CLASSROOMNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClassRoom.ASSIGNEDTEACHERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: ClassRoom.STUDENTS,
      isRequired: false,
      ofModelName: (Student).toString(),
      associatedKey: Student.CLASSROOMSTUDENTSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClassRoom.CURRENTATTENDANCE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClassRoom.IMPORTANTNOTICE,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClassRoom.ATTENDANCEMODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
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
      key: ClassRoom.USERASSIGNEDCLASSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClassRoom.SCHOOLCLASSROOMSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClassRoom.GROUPCLASSROOMSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _ClassRoomModelType extends ModelType<ClassRoom> {
  const _ClassRoomModelType();
  
  @override
  ClassRoom fromJson(Map<String, dynamic> jsonData) {
    return ClassRoom.fromJson(jsonData);
  }
}