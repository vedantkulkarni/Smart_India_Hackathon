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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Student type in your schema. */
@immutable
class Student extends Model {
  static const classType = const _StudentModelType();
  final String id;
  final String? _studentID;
  final String? _studentName;
  final String? _assignedClassID;
  final String? _assignedClassName;
  final String? _assignedTeacherID;
  final String? _assignedTeacherName;
  final String? _profilePhoto;
  final String? _idCardPhoto;
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
  
  String get assignedClassID {
    try {
      return _assignedClassID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get assignedClassName {
    try {
      return _assignedClassName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get assignedTeacherID {
    try {
      return _assignedTeacherID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get assignedTeacherName {
    try {
      return _assignedTeacherName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get profilePhoto {
    return _profilePhoto;
  }
  
  String? get idCardPhoto {
    return _idCardPhoto;
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
  
  const Student._internal({required this.id, required studentID, required studentName, required assignedClassID, required assignedClassName, required assignedTeacherID, required assignedTeacherName, profilePhoto, idCardPhoto, createdAt, updatedAt, classRoomStudentsId}): _studentID = studentID, _studentName = studentName, _assignedClassID = assignedClassID, _assignedClassName = assignedClassName, _assignedTeacherID = assignedTeacherID, _assignedTeacherName = assignedTeacherName, _profilePhoto = profilePhoto, _idCardPhoto = idCardPhoto, _createdAt = createdAt, _updatedAt = updatedAt, _classRoomStudentsId = classRoomStudentsId;
  
  factory Student({String? id, required String studentID, required String studentName, required String assignedClassID, required String assignedClassName, required String assignedTeacherID, required String assignedTeacherName, String? profilePhoto, String? idCardPhoto, String? classRoomStudentsId}) {
    return Student._internal(
      id: id == null ? UUID.getUUID() : id,
      studentID: studentID,
      studentName: studentName,
      assignedClassID: assignedClassID,
      assignedClassName: assignedClassName,
      assignedTeacherID: assignedTeacherID,
      assignedTeacherName: assignedTeacherName,
      profilePhoto: profilePhoto,
      idCardPhoto: idCardPhoto,
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
      _assignedClassID == other._assignedClassID &&
      _assignedClassName == other._assignedClassName &&
      _assignedTeacherID == other._assignedTeacherID &&
      _assignedTeacherName == other._assignedTeacherName &&
      _profilePhoto == other._profilePhoto &&
      _idCardPhoto == other._idCardPhoto &&
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
    buffer.write("assignedClassID=" + "$_assignedClassID" + ", ");
    buffer.write("assignedClassName=" + "$_assignedClassName" + ", ");
    buffer.write("assignedTeacherID=" + "$_assignedTeacherID" + ", ");
    buffer.write("assignedTeacherName=" + "$_assignedTeacherName" + ", ");
    buffer.write("profilePhoto=" + "$_profilePhoto" + ", ");
    buffer.write("idCardPhoto=" + "$_idCardPhoto" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("classRoomStudentsId=" + "$_classRoomStudentsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Student copyWith({String? id, String? studentID, String? studentName, String? assignedClassID, String? assignedClassName, String? assignedTeacherID, String? assignedTeacherName, String? profilePhoto, String? idCardPhoto, String? classRoomStudentsId}) {
    return Student._internal(
      id: id ?? this.id,
      studentID: studentID ?? this.studentID,
      studentName: studentName ?? this.studentName,
      assignedClassID: assignedClassID ?? this.assignedClassID,
      assignedClassName: assignedClassName ?? this.assignedClassName,
      assignedTeacherID: assignedTeacherID ?? this.assignedTeacherID,
      assignedTeacherName: assignedTeacherName ?? this.assignedTeacherName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      idCardPhoto: idCardPhoto ?? this.idCardPhoto,
      classRoomStudentsId: classRoomStudentsId ?? this.classRoomStudentsId);
  }
  
  Student.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _studentID = json['studentID'],
      _studentName = json['studentName'],
      _assignedClassID = json['assignedClassID'],
      _assignedClassName = json['assignedClassName'],
      _assignedTeacherID = json['assignedTeacherID'],
      _assignedTeacherName = json['assignedTeacherName'],
      _profilePhoto = json['profilePhoto'],
      _idCardPhoto = json['idCardPhoto'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _classRoomStudentsId = json['classRoomStudentsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'studentID': _studentID, 'studentName': _studentName, 'assignedClassID': _assignedClassID, 'assignedClassName': _assignedClassName, 'assignedTeacherID': _assignedTeacherID, 'assignedTeacherName': _assignedTeacherName, 'profilePhoto': _profilePhoto, 'idCardPhoto': _idCardPhoto, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'classRoomStudentsId': _classRoomStudentsId
  };

  static final QueryField ID = QueryField(fieldName: "student.id");
  static final QueryField STUDENTID = QueryField(fieldName: "studentID");
  static final QueryField STUDENTNAME = QueryField(fieldName: "studentName");
  static final QueryField ASSIGNEDCLASSID = QueryField(fieldName: "assignedClassID");
  static final QueryField ASSIGNEDCLASSNAME = QueryField(fieldName: "assignedClassName");
  static final QueryField ASSIGNEDTEACHERID = QueryField(fieldName: "assignedTeacherID");
  static final QueryField ASSIGNEDTEACHERNAME = QueryField(fieldName: "assignedTeacherName");
  static final QueryField PROFILEPHOTO = QueryField(fieldName: "profilePhoto");
  static final QueryField IDCARDPHOTO = QueryField(fieldName: "idCardPhoto");
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
      key: Student.ASSIGNEDCLASSID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.ASSIGNEDCLASSNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.ASSIGNEDTEACHERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Student.ASSIGNEDTEACHERNAME,
      isRequired: true,
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