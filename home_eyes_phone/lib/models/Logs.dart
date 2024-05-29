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
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the Logs type in your schema. */
class Logs extends amplify_core.Model {
  static const classType = const _LogsModelType();
  final String id;
  final String? _action;
  final amplify_core.TemporalDateTime? _timestamp;
  final String? _username;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  LogsModelIdentifier get modelIdentifier {
      return LogsModelIdentifier(
        id: id
      );
  }
  
  String get action {
    try {
      return _action!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime get timestamp {
    try {
      return _timestamp!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Logs._internal({required this.id, required action, required timestamp, required username, createdAt, updatedAt}): _action = action, _timestamp = timestamp, _username = username, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Logs({String? id, required String action, required amplify_core.TemporalDateTime timestamp, required String username}) {
    return Logs._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      action: action,
      timestamp: timestamp,
      username: username);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Logs &&
      id == other.id &&
      _action == other._action &&
      _timestamp == other._timestamp &&
      _username == other._username;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Logs {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("action=" + "$_action" + ", ");
    buffer.write("timestamp=" + (_timestamp != null ? _timestamp!.format() : "null") + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Logs copyWith({String? action, amplify_core.TemporalDateTime? timestamp, String? username}) {
    return Logs._internal(
      id: id,
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      username: username ?? this.username);
  }
  
  Logs copyWithModelFieldValues({
    ModelFieldValue<String>? action,
    ModelFieldValue<amplify_core.TemporalDateTime>? timestamp,
    ModelFieldValue<String>? username
  }) {
    return Logs._internal(
      id: id,
      action: action == null ? this.action : action.value,
      timestamp: timestamp == null ? this.timestamp : timestamp.value,
      username: username == null ? this.username : username.value
    );
  }
  
  Logs.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _action = json['action'],
      _timestamp = json['timestamp'] != null ? amplify_core.TemporalDateTime.fromString(json['timestamp']) : null,
      _username = json['username'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'action': _action, 'timestamp': _timestamp?.format(), 'username': _username, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'action': _action,
    'timestamp': _timestamp,
    'username': _username,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<LogsModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<LogsModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final ACTION = amplify_core.QueryField(fieldName: "action");
  static final TIMESTAMP = amplify_core.QueryField(fieldName: "timestamp");
  static final USERNAME = amplify_core.QueryField(fieldName: "username");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Logs";
    modelSchemaDefinition.pluralName = "Logs";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ]),
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Logs.ACTION,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Logs.TIMESTAMP,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Logs.USERNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _LogsModelType extends amplify_core.ModelType<Logs> {
  const _LogsModelType();
  
  @override
  Logs fromJson(Map<String, dynamic> jsonData) {
    return Logs.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Logs';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Logs] in your schema.
 */
class LogsModelIdentifier implements amplify_core.ModelIdentifier<Logs> {
  final String id;

  /** Create an instance of LogsModelIdentifier using [id] the primary key. */
  const LogsModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'LogsModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is LogsModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}