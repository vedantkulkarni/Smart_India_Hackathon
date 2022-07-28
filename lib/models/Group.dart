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


/** This is an auto generated class representing the Group type in your schema. */
@immutable
class Group extends Model {
  static const classType = const _GroupModelType();
  final String id;
  final String? _groupID;
  final String? _createdBy;
  final List<ClassRoom>? _classRooms;
  final String? _groupName;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _schoolGroupsId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get groupID {
    try {
      return _groupID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get createdBy {
    try {
      return _createdBy!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<ClassRoom>? get classRooms {
    return _classRooms;
  }
  
  String get groupName {
    try {
      return _groupName!;
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
  
  String? get schoolGroupsId {
    return _schoolGroupsId;
  }
  
  const Group._internal({required this.id, required groupID, required createdBy, classRooms, required groupName, createdAt, updatedAt, schoolGroupsId}): _groupID = groupID, _createdBy = createdBy, _classRooms = classRooms, _groupName = groupName, _createdAt = createdAt, _updatedAt = updatedAt, _schoolGroupsId = schoolGroupsId;
  
  factory Group({String? id, required String groupID, required String createdBy, List<ClassRoom>? classRooms, required String groupName, String? schoolGroupsId}) {
    return Group._internal(
      id: id == null ? UUID.getUUID() : id,
      groupID: groupID,
      createdBy: createdBy,
      classRooms: classRooms != null ? List<ClassRoom>.unmodifiable(classRooms) : classRooms,
      groupName: groupName,
      schoolGroupsId: schoolGroupsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Group &&
      id == other.id &&
      _groupID == other._groupID &&
      _createdBy == other._createdBy &&
      DeepCollectionEquality().equals(_classRooms, other._classRooms) &&
      _groupName == other._groupName &&
      _schoolGroupsId == other._schoolGroupsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Group {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("groupID=" + "$_groupID" + ", ");
    buffer.write("createdBy=" + "$_createdBy" + ", ");
    buffer.write("groupName=" + "$_groupName" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("schoolGroupsId=" + "$_schoolGroupsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Group copyWith({String? id, String? groupID, String? createdBy, List<ClassRoom>? classRooms, String? groupName, String? schoolGroupsId}) {
    return Group._internal(
      id: id ?? this.id,
      groupID: groupID ?? this.groupID,
      createdBy: createdBy ?? this.createdBy,
      classRooms: classRooms ?? this.classRooms,
      groupName: groupName ?? this.groupName,
      schoolGroupsId: schoolGroupsId ?? this.schoolGroupsId);
  }
  
  Group.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _groupID = json['groupID'],
      _createdBy = json['createdBy'],
      _classRooms = json['classRooms'] is List
        ? (json['classRooms'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ClassRoom.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _groupName = json['groupName'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _schoolGroupsId = json['schoolGroupsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'groupID': _groupID, 'createdBy': _createdBy, 'classRooms': _classRooms?.map((ClassRoom? e) => e?.toJson()).toList(), 'groupName': _groupName, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'schoolGroupsId': _schoolGroupsId
  };

  static final QueryField ID = QueryField(fieldName: "group.id");
  static final QueryField GROUPID = QueryField(fieldName: "groupID");
  static final QueryField CREATEDBY = QueryField(fieldName: "createdBy");
  static final QueryField CLASSROOMS = QueryField(
    fieldName: "classRooms",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ClassRoom).toString()));
  static final QueryField GROUPNAME = QueryField(fieldName: "groupName");
  static final QueryField SCHOOLGROUPSID = QueryField(fieldName: "schoolGroupsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Group";
    modelSchemaDefinition.pluralName = "Groups";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Group.GROUPID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Group.CREATEDBY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Group.CLASSROOMS,
      isRequired: false,
      ofModelName: (ClassRoom).toString(),
      associatedKey: ClassRoom.GROUPCLASSROOMSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Group.GROUPNAME,
      isRequired: true,
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
      key: Group.SCHOOLGROUPSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _GroupModelType extends ModelType<Group> {
  const _GroupModelType();
  
  @override
  Group fromJson(Map<String, dynamic> jsonData) {
    return Group.fromJson(jsonData);
  }
}