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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Leave type in your schema. */
@immutable
class Leave extends Model {
  static const classType = const _LeaveModelType();
  final String id;
  final String? _studentID;
  final TemporalDate? _leaveDate;
  final String? _leaveReason;
  final int? _leaveDays;
  final String? _leaveBody;
  final String? _leaveDocLink;
  final String? _teacherID;
  final LeaveStatus? _leaveStatus;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

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
  
  TemporalDate get leaveDate {
    try {
      return _leaveDate!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get leaveReason {
    try {
      return _leaveReason!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get leaveDays {
    try {
      return _leaveDays!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get leaveBody {
    return _leaveBody;
  }
  
  String? get leaveDocLink {
    return _leaveDocLink;
  }
  
  String get teacherID {
    try {
      return _teacherID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  LeaveStatus get leaveStatus {
    try {
      return _leaveStatus!;
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
  
  const Leave._internal({required this.id, required studentID, required leaveDate, required leaveReason, required leaveDays, leaveBody, leaveDocLink, required teacherID, required leaveStatus, createdAt, updatedAt}): _studentID = studentID, _leaveDate = leaveDate, _leaveReason = leaveReason, _leaveDays = leaveDays, _leaveBody = leaveBody, _leaveDocLink = leaveDocLink, _teacherID = teacherID, _leaveStatus = leaveStatus, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Leave({String? id, required String studentID, required TemporalDate leaveDate, required String leaveReason, required int leaveDays, String? leaveBody, String? leaveDocLink, required String teacherID, required LeaveStatus leaveStatus}) {
    return Leave._internal(
      id: id == null ? UUID.getUUID() : id,
      studentID: studentID,
      leaveDate: leaveDate,
      leaveReason: leaveReason,
      leaveDays: leaveDays,
      leaveBody: leaveBody,
      leaveDocLink: leaveDocLink,
      teacherID: teacherID,
      leaveStatus: leaveStatus);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Leave &&
      id == other.id &&
      _studentID == other._studentID &&
      _leaveDate == other._leaveDate &&
      _leaveReason == other._leaveReason &&
      _leaveDays == other._leaveDays &&
      _leaveBody == other._leaveBody &&
      _leaveDocLink == other._leaveDocLink &&
      _teacherID == other._teacherID &&
      _leaveStatus == other._leaveStatus;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Leave {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("studentID=" + "$_studentID" + ", ");
    buffer.write("leaveDate=" + (_leaveDate != null ? _leaveDate!.format() : "null") + ", ");
    buffer.write("leaveReason=" + "$_leaveReason" + ", ");
    buffer.write("leaveDays=" + (_leaveDays != null ? _leaveDays!.toString() : "null") + ", ");
    buffer.write("leaveBody=" + "$_leaveBody" + ", ");
    buffer.write("leaveDocLink=" + "$_leaveDocLink" + ", ");
    buffer.write("teacherID=" + "$_teacherID" + ", ");
    buffer.write("leaveStatus=" + (_leaveStatus != null ? enumToString(_leaveStatus)! : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Leave copyWith({String? id, String? studentID, TemporalDate? leaveDate, String? leaveReason, int? leaveDays, String? leaveBody, String? leaveDocLink, String? teacherID, LeaveStatus? leaveStatus}) {
    return Leave._internal(
      id: id ?? this.id,
      studentID: studentID ?? this.studentID,
      leaveDate: leaveDate ?? this.leaveDate,
      leaveReason: leaveReason ?? this.leaveReason,
      leaveDays: leaveDays ?? this.leaveDays,
      leaveBody: leaveBody ?? this.leaveBody,
      leaveDocLink: leaveDocLink ?? this.leaveDocLink,
      teacherID: teacherID ?? this.teacherID,
      leaveStatus: leaveStatus ?? this.leaveStatus);
  }
  
  Leave.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _studentID = json['studentID'],
      _leaveDate = json['leaveDate'] != null ? TemporalDate.fromString(json['leaveDate']) : null,
      _leaveReason = json['leaveReason'],
      _leaveDays = (json['leaveDays'] as num?)?.toInt(),
      _leaveBody = json['leaveBody'],
      _leaveDocLink = json['leaveDocLink'],
      _teacherID = json['teacherID'],
      _leaveStatus = enumFromString<LeaveStatus>(json['leaveStatus'], LeaveStatus.values),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'studentID': _studentID, 'leaveDate': _leaveDate?.format(), 'leaveReason': _leaveReason, 'leaveDays': _leaveDays, 'leaveBody': _leaveBody, 'leaveDocLink': _leaveDocLink, 'teacherID': _teacherID, 'leaveStatus': enumToString(_leaveStatus), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "leave.id");
  static final QueryField STUDENTID = QueryField(fieldName: "studentID");
  static final QueryField LEAVEDATE = QueryField(fieldName: "leaveDate");
  static final QueryField LEAVEREASON = QueryField(fieldName: "leaveReason");
  static final QueryField LEAVEDAYS = QueryField(fieldName: "leaveDays");
  static final QueryField LEAVEBODY = QueryField(fieldName: "leaveBody");
  static final QueryField LEAVEDOCLINK = QueryField(fieldName: "leaveDocLink");
  static final QueryField TEACHERID = QueryField(fieldName: "teacherID");
  static final QueryField LEAVESTATUS = QueryField(fieldName: "leaveStatus");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Leave";
    modelSchemaDefinition.pluralName = "Leaves";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Leave.STUDENTID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Leave.LEAVEDATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Leave.LEAVEREASON,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Leave.LEAVEDAYS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Leave.LEAVEBODY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Leave.LEAVEDOCLINK,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Leave.TEACHERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Leave.LEAVESTATUS,
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
  });
}

class _LeaveModelType extends ModelType<Leave> {
  const _LeaveModelType();
  
  @override
  Leave fromJson(Map<String, dynamic> jsonData) {
    return Leave.fromJson(jsonData);
  }
}