// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MemoriesTable extends Memories with TableInfo<$MemoriesTable, Memory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Source, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Source>($MemoriesTable.$convertersource);
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sensitivity, int> sensitivity =
      GeneratedColumn<int>(
        'sensitivity',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Sensitivity>($MemoriesTable.$convertersensitivity);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MemoryKind, int> kind =
      GeneratedColumn<int>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MemoryKind>($MemoriesTable.$converterkind);
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _predicateMeta = const VerificationMeta(
    'predicate',
  );
  @override
  late final GeneratedColumn<String> predicate = GeneratedColumn<String>(
    'predicate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validFromMeta = const VerificationMeta(
    'validFrom',
  );
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
    'valid_from',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _validToMeta = const VerificationMeta(
    'validTo',
  );
  @override
  late final GeneratedColumn<DateTime> validTo = GeneratedColumn<DateTime>(
    'valid_to',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supersededByMeta = const VerificationMeta(
    'supersededBy',
  );
  @override
  late final GeneratedColumn<String> supersededBy = GeneratedColumn<String>(
    'superseded_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES memories (id)',
    ),
  );
  static const VerificationMeta _userEditableMeta = const VerificationMeta(
    'userEditable',
  );
  @override
  late final GeneratedColumn<bool> userEditable = GeneratedColumn<bool>(
    'user_editable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("user_editable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    kind,
    category,
    content,
    subject,
    predicate,
    value,
    validFrom,
    validTo,
    supersededBy,
    userEditable,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Memory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('predicate')) {
      context.handle(
        _predicateMeta,
        predicate.isAcceptableOrUnknown(data['predicate']!, _predicateMeta),
      );
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('valid_from')) {
      context.handle(
        _validFromMeta,
        validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta),
      );
    } else if (isInserting) {
      context.missing(_validFromMeta);
    }
    if (data.containsKey('valid_to')) {
      context.handle(
        _validToMeta,
        validTo.isAcceptableOrUnknown(data['valid_to']!, _validToMeta),
      );
    }
    if (data.containsKey('superseded_by')) {
      context.handle(
        _supersededByMeta,
        supersededBy.isAcceptableOrUnknown(
          data['superseded_by']!,
          _supersededByMeta,
        ),
      );
    }
    if (data.containsKey('user_editable')) {
      context.handle(
        _userEditableMeta,
        userEditable.isAcceptableOrUnknown(
          data['user_editable']!,
          _userEditableMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Memory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Memory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $MemoriesTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sensitivity: $MemoriesTable.$convertersensitivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sensitivity'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      kind: $MemoriesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}kind'],
        )!,
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      ),
      predicate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}predicate'],
      ),
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
      validFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_from'],
      )!,
      validTo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_to'],
      ),
      supersededBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}superseded_by'],
      ),
      userEditable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}user_editable'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $MemoriesTable createAlias(String alias) {
    return $MemoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Source, int, int> $convertersource =
      const EnumIndexConverter<Source>(Source.values);
  static JsonTypeConverter2<Sensitivity, int, int> $convertersensitivity =
      const EnumIndexConverter<Sensitivity>(Sensitivity.values);
  static JsonTypeConverter2<MemoryKind, int, int> $converterkind =
      const EnumIndexConverter<MemoryKind>(MemoryKind.values);
}

class Memory extends DataClass implements Insertable<Memory> {
  final String id;
  final Source source;
  final String? sourceRef;
  final double confidence;
  final Sensitivity sensitivity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final MemoryKind kind;
  final String category;
  final String content;

  /// Normalized subject/predicate let corrections supersede the right fact,
  /// e.g. ("user.vehicle", "model").
  final String? subject;
  final String? predicate;
  final String? value;
  final DateTime validFrom;
  final DateTime? validTo;
  final String? supersededBy;
  final bool userEditable;
  final int version;
  const Memory({
    required this.id,
    required this.source,
    this.sourceRef,
    required this.confidence,
    required this.sensitivity,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.kind,
    required this.category,
    required this.content,
    this.subject,
    this.predicate,
    this.value,
    required this.validFrom,
    this.validTo,
    this.supersededBy,
    required this.userEditable,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<int>(
        $MemoriesTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['confidence'] = Variable<double>(confidence);
    {
      map['sensitivity'] = Variable<int>(
        $MemoriesTable.$convertersensitivity.toSql(sensitivity),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    {
      map['kind'] = Variable<int>($MemoriesTable.$converterkind.toSql(kind));
    }
    map['category'] = Variable<String>(category);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || subject != null) {
      map['subject'] = Variable<String>(subject);
    }
    if (!nullToAbsent || predicate != null) {
      map['predicate'] = Variable<String>(predicate);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    map['valid_from'] = Variable<DateTime>(validFrom);
    if (!nullToAbsent || validTo != null) {
      map['valid_to'] = Variable<DateTime>(validTo);
    }
    if (!nullToAbsent || supersededBy != null) {
      map['superseded_by'] = Variable<String>(supersededBy);
    }
    map['user_editable'] = Variable<bool>(userEditable);
    map['version'] = Variable<int>(version);
    return map;
  }

  MemoriesCompanion toCompanion(bool nullToAbsent) {
    return MemoriesCompanion(
      id: Value(id),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      confidence: Value(confidence),
      sensitivity: Value(sensitivity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      kind: Value(kind),
      category: Value(category),
      content: Value(content),
      subject: subject == null && nullToAbsent
          ? const Value.absent()
          : Value(subject),
      predicate: predicate == null && nullToAbsent
          ? const Value.absent()
          : Value(predicate),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
      validFrom: Value(validFrom),
      validTo: validTo == null && nullToAbsent
          ? const Value.absent()
          : Value(validTo),
      supersededBy: supersededBy == null && nullToAbsent
          ? const Value.absent()
          : Value(supersededBy),
      userEditable: Value(userEditable),
      version: Value(version),
    );
  }

  factory Memory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Memory(
      id: serializer.fromJson<String>(json['id']),
      source: $MemoriesTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sensitivity: $MemoriesTable.$convertersensitivity.fromJson(
        serializer.fromJson<int>(json['sensitivity']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      kind: $MemoriesTable.$converterkind.fromJson(
        serializer.fromJson<int>(json['kind']),
      ),
      category: serializer.fromJson<String>(json['category']),
      content: serializer.fromJson<String>(json['content']),
      subject: serializer.fromJson<String?>(json['subject']),
      predicate: serializer.fromJson<String?>(json['predicate']),
      value: serializer.fromJson<String?>(json['value']),
      validFrom: serializer.fromJson<DateTime>(json['validFrom']),
      validTo: serializer.fromJson<DateTime?>(json['validTo']),
      supersededBy: serializer.fromJson<String?>(json['supersededBy']),
      userEditable: serializer.fromJson<bool>(json['userEditable']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<int>(
        $MemoriesTable.$convertersource.toJson(source),
      ),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'confidence': serializer.toJson<double>(confidence),
      'sensitivity': serializer.toJson<int>(
        $MemoriesTable.$convertersensitivity.toJson(sensitivity),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'kind': serializer.toJson<int>(
        $MemoriesTable.$converterkind.toJson(kind),
      ),
      'category': serializer.toJson<String>(category),
      'content': serializer.toJson<String>(content),
      'subject': serializer.toJson<String?>(subject),
      'predicate': serializer.toJson<String?>(predicate),
      'value': serializer.toJson<String?>(value),
      'validFrom': serializer.toJson<DateTime>(validFrom),
      'validTo': serializer.toJson<DateTime?>(validTo),
      'supersededBy': serializer.toJson<String?>(supersededBy),
      'userEditable': serializer.toJson<bool>(userEditable),
      'version': serializer.toJson<int>(version),
    };
  }

  Memory copyWith({
    String? id,
    Source? source,
    Value<String?> sourceRef = const Value.absent(),
    double? confidence,
    Sensitivity? sensitivity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    MemoryKind? kind,
    String? category,
    String? content,
    Value<String?> subject = const Value.absent(),
    Value<String?> predicate = const Value.absent(),
    Value<String?> value = const Value.absent(),
    DateTime? validFrom,
    Value<DateTime?> validTo = const Value.absent(),
    Value<String?> supersededBy = const Value.absent(),
    bool? userEditable,
    int? version,
  }) => Memory(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    confidence: confidence ?? this.confidence,
    sensitivity: sensitivity ?? this.sensitivity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    kind: kind ?? this.kind,
    category: category ?? this.category,
    content: content ?? this.content,
    subject: subject.present ? subject.value : this.subject,
    predicate: predicate.present ? predicate.value : this.predicate,
    value: value.present ? value.value : this.value,
    validFrom: validFrom ?? this.validFrom,
    validTo: validTo.present ? validTo.value : this.validTo,
    supersededBy: supersededBy.present ? supersededBy.value : this.supersededBy,
    userEditable: userEditable ?? this.userEditable,
    version: version ?? this.version,
  );
  Memory copyWithCompanion(MemoriesCompanion data) {
    return Memory(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sensitivity: data.sensitivity.present
          ? data.sensitivity.value
          : this.sensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      kind: data.kind.present ? data.kind.value : this.kind,
      category: data.category.present ? data.category.value : this.category,
      content: data.content.present ? data.content.value : this.content,
      subject: data.subject.present ? data.subject.value : this.subject,
      predicate: data.predicate.present ? data.predicate.value : this.predicate,
      value: data.value.present ? data.value.value : this.value,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      validTo: data.validTo.present ? data.validTo.value : this.validTo,
      supersededBy: data.supersededBy.present
          ? data.supersededBy.value
          : this.supersededBy,
      userEditable: data.userEditable.present
          ? data.userEditable.value
          : this.userEditable,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Memory(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('kind: $kind, ')
          ..write('category: $category, ')
          ..write('content: $content, ')
          ..write('subject: $subject, ')
          ..write('predicate: $predicate, ')
          ..write('value: $value, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('supersededBy: $supersededBy, ')
          ..write('userEditable: $userEditable, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    kind,
    category,
    content,
    subject,
    predicate,
    value,
    validFrom,
    validTo,
    supersededBy,
    userEditable,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Memory &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.confidence == this.confidence &&
          other.sensitivity == this.sensitivity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.kind == this.kind &&
          other.category == this.category &&
          other.content == this.content &&
          other.subject == this.subject &&
          other.predicate == this.predicate &&
          other.value == this.value &&
          other.validFrom == this.validFrom &&
          other.validTo == this.validTo &&
          other.supersededBy == this.supersededBy &&
          other.userEditable == this.userEditable &&
          other.version == this.version);
}

class MemoriesCompanion extends UpdateCompanion<Memory> {
  final Value<String> id;
  final Value<Source> source;
  final Value<String?> sourceRef;
  final Value<double> confidence;
  final Value<Sensitivity> sensitivity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<MemoryKind> kind;
  final Value<String> category;
  final Value<String> content;
  final Value<String?> subject;
  final Value<String?> predicate;
  final Value<String?> value;
  final Value<DateTime> validFrom;
  final Value<DateTime?> validTo;
  final Value<String?> supersededBy;
  final Value<bool> userEditable;
  final Value<int> version;
  final Value<int> rowid;
  const MemoriesCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.kind = const Value.absent(),
    this.category = const Value.absent(),
    this.content = const Value.absent(),
    this.subject = const Value.absent(),
    this.predicate = const Value.absent(),
    this.value = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
    this.supersededBy = const Value.absent(),
    this.userEditable = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MemoriesCompanion.insert({
    required String id,
    required Source source,
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    required MemoryKind kind,
    required String category,
    required String content,
    this.subject = const Value.absent(),
    this.predicate = const Value.absent(),
    this.value = const Value.absent(),
    required DateTime validFrom,
    this.validTo = const Value.absent(),
    this.supersededBy = const Value.absent(),
    this.userEditable = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       kind = Value(kind),
       category = Value(category),
       content = Value(content),
       validFrom = Value(validFrom);
  static Insertable<Memory> custom({
    Expression<String>? id,
    Expression<int>? source,
    Expression<String>? sourceRef,
    Expression<double>? confidence,
    Expression<int>? sensitivity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? kind,
    Expression<String>? category,
    Expression<String>? content,
    Expression<String>? subject,
    Expression<String>? predicate,
    Expression<String>? value,
    Expression<DateTime>? validFrom,
    Expression<DateTime>? validTo,
    Expression<String>? supersededBy,
    Expression<bool>? userEditable,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (confidence != null) 'confidence': confidence,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (kind != null) 'kind': kind,
      if (category != null) 'category': category,
      if (content != null) 'content': content,
      if (subject != null) 'subject': subject,
      if (predicate != null) 'predicate': predicate,
      if (value != null) 'value': value,
      if (validFrom != null) 'valid_from': validFrom,
      if (validTo != null) 'valid_to': validTo,
      if (supersededBy != null) 'superseded_by': supersededBy,
      if (userEditable != null) 'user_editable': userEditable,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MemoriesCompanion copyWith({
    Value<String>? id,
    Value<Source>? source,
    Value<String?>? sourceRef,
    Value<double>? confidence,
    Value<Sensitivity>? sensitivity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<MemoryKind>? kind,
    Value<String>? category,
    Value<String>? content,
    Value<String?>? subject,
    Value<String?>? predicate,
    Value<String?>? value,
    Value<DateTime>? validFrom,
    Value<DateTime?>? validTo,
    Value<String?>? supersededBy,
    Value<bool>? userEditable,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return MemoriesCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      confidence: confidence ?? this.confidence,
      sensitivity: sensitivity ?? this.sensitivity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      kind: kind ?? this.kind,
      category: category ?? this.category,
      content: content ?? this.content,
      subject: subject ?? this.subject,
      predicate: predicate ?? this.predicate,
      value: value ?? this.value,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      supersededBy: supersededBy ?? this.supersededBy,
      userEditable: userEditable ?? this.userEditable,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $MemoriesTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int>(
        $MemoriesTable.$convertersensitivity.toSql(sensitivity.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(
        $MemoriesTable.$converterkind.toSql(kind.value),
      );
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (predicate.present) {
      map['predicate'] = Variable<String>(predicate.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<DateTime>(validFrom.value);
    }
    if (validTo.present) {
      map['valid_to'] = Variable<DateTime>(validTo.value);
    }
    if (supersededBy.present) {
      map['superseded_by'] = Variable<String>(supersededBy.value);
    }
    if (userEditable.present) {
      map['user_editable'] = Variable<bool>(userEditable.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoriesCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('kind: $kind, ')
          ..write('category: $category, ')
          ..write('content: $content, ')
          ..write('subject: $subject, ')
          ..write('predicate: $predicate, ')
          ..write('value: $value, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('supersededBy: $supersededBy, ')
          ..write('userEditable: $userEditable, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MemoryVersionsTable extends MemoryVersions
    with TableInfo<$MemoryVersionsTable, MemoryVersion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoryVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _memoryIdMeta = const VerificationMeta(
    'memoryId',
  );
  @override
  late final GeneratedColumn<String> memoryId = GeneratedColumn<String>(
    'memory_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES memories (id)',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validToMeta = const VerificationMeta(
    'validTo',
  );
  @override
  late final GeneratedColumn<DateTime> validTo = GeneratedColumn<DateTime>(
    'valid_to',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _changedByMeta = const VerificationMeta(
    'changedBy',
  );
  @override
  late final GeneratedColumn<String> changedBy = GeneratedColumn<String>(
    'changed_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeReasonMeta = const VerificationMeta(
    'changeReason',
  );
  @override
  late final GeneratedColumn<String> changeReason = GeneratedColumn<String>(
    'change_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    memoryId,
    version,
    content,
    value,
    validTo,
    changedBy,
    changeReason,
    at,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memory_versions';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemoryVersion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('memory_id')) {
      context.handle(
        _memoryIdMeta,
        memoryId.isAcceptableOrUnknown(data['memory_id']!, _memoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memoryIdMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('valid_to')) {
      context.handle(
        _validToMeta,
        validTo.isAcceptableOrUnknown(data['valid_to']!, _validToMeta),
      );
    }
    if (data.containsKey('changed_by')) {
      context.handle(
        _changedByMeta,
        changedBy.isAcceptableOrUnknown(data['changed_by']!, _changedByMeta),
      );
    } else if (isInserting) {
      context.missing(_changedByMeta);
    }
    if (data.containsKey('change_reason')) {
      context.handle(
        _changeReasonMeta,
        changeReason.isAcceptableOrUnknown(
          data['change_reason']!,
          _changeReasonMeta,
        ),
      );
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryVersion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryVersion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      memoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memory_id'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
      validTo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_to'],
      ),
      changedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}changed_by'],
      )!,
      changeReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_reason'],
      ),
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
    );
  }

  @override
  $MemoryVersionsTable createAlias(String alias) {
    return $MemoryVersionsTable(attachedDatabase, alias);
  }
}

class MemoryVersion extends DataClass implements Insertable<MemoryVersion> {
  final int id;
  final String memoryId;
  final int version;
  final String content;
  final String? value;
  final DateTime? validTo;
  final String changedBy;
  final String? changeReason;
  final DateTime at;
  const MemoryVersion({
    required this.id,
    required this.memoryId,
    required this.version,
    required this.content,
    this.value,
    this.validTo,
    required this.changedBy,
    this.changeReason,
    required this.at,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['memory_id'] = Variable<String>(memoryId);
    map['version'] = Variable<int>(version);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    if (!nullToAbsent || validTo != null) {
      map['valid_to'] = Variable<DateTime>(validTo);
    }
    map['changed_by'] = Variable<String>(changedBy);
    if (!nullToAbsent || changeReason != null) {
      map['change_reason'] = Variable<String>(changeReason);
    }
    map['at'] = Variable<DateTime>(at);
    return map;
  }

  MemoryVersionsCompanion toCompanion(bool nullToAbsent) {
    return MemoryVersionsCompanion(
      id: Value(id),
      memoryId: Value(memoryId),
      version: Value(version),
      content: Value(content),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
      validTo: validTo == null && nullToAbsent
          ? const Value.absent()
          : Value(validTo),
      changedBy: Value(changedBy),
      changeReason: changeReason == null && nullToAbsent
          ? const Value.absent()
          : Value(changeReason),
      at: Value(at),
    );
  }

  factory MemoryVersion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryVersion(
      id: serializer.fromJson<int>(json['id']),
      memoryId: serializer.fromJson<String>(json['memoryId']),
      version: serializer.fromJson<int>(json['version']),
      content: serializer.fromJson<String>(json['content']),
      value: serializer.fromJson<String?>(json['value']),
      validTo: serializer.fromJson<DateTime?>(json['validTo']),
      changedBy: serializer.fromJson<String>(json['changedBy']),
      changeReason: serializer.fromJson<String?>(json['changeReason']),
      at: serializer.fromJson<DateTime>(json['at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'memoryId': serializer.toJson<String>(memoryId),
      'version': serializer.toJson<int>(version),
      'content': serializer.toJson<String>(content),
      'value': serializer.toJson<String?>(value),
      'validTo': serializer.toJson<DateTime?>(validTo),
      'changedBy': serializer.toJson<String>(changedBy),
      'changeReason': serializer.toJson<String?>(changeReason),
      'at': serializer.toJson<DateTime>(at),
    };
  }

  MemoryVersion copyWith({
    int? id,
    String? memoryId,
    int? version,
    String? content,
    Value<String?> value = const Value.absent(),
    Value<DateTime?> validTo = const Value.absent(),
    String? changedBy,
    Value<String?> changeReason = const Value.absent(),
    DateTime? at,
  }) => MemoryVersion(
    id: id ?? this.id,
    memoryId: memoryId ?? this.memoryId,
    version: version ?? this.version,
    content: content ?? this.content,
    value: value.present ? value.value : this.value,
    validTo: validTo.present ? validTo.value : this.validTo,
    changedBy: changedBy ?? this.changedBy,
    changeReason: changeReason.present ? changeReason.value : this.changeReason,
    at: at ?? this.at,
  );
  MemoryVersion copyWithCompanion(MemoryVersionsCompanion data) {
    return MemoryVersion(
      id: data.id.present ? data.id.value : this.id,
      memoryId: data.memoryId.present ? data.memoryId.value : this.memoryId,
      version: data.version.present ? data.version.value : this.version,
      content: data.content.present ? data.content.value : this.content,
      value: data.value.present ? data.value.value : this.value,
      validTo: data.validTo.present ? data.validTo.value : this.validTo,
      changedBy: data.changedBy.present ? data.changedBy.value : this.changedBy,
      changeReason: data.changeReason.present
          ? data.changeReason.value
          : this.changeReason,
      at: data.at.present ? data.at.value : this.at,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemoryVersion(')
          ..write('id: $id, ')
          ..write('memoryId: $memoryId, ')
          ..write('version: $version, ')
          ..write('content: $content, ')
          ..write('value: $value, ')
          ..write('validTo: $validTo, ')
          ..write('changedBy: $changedBy, ')
          ..write('changeReason: $changeReason, ')
          ..write('at: $at')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    memoryId,
    version,
    content,
    value,
    validTo,
    changedBy,
    changeReason,
    at,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryVersion &&
          other.id == this.id &&
          other.memoryId == this.memoryId &&
          other.version == this.version &&
          other.content == this.content &&
          other.value == this.value &&
          other.validTo == this.validTo &&
          other.changedBy == this.changedBy &&
          other.changeReason == this.changeReason &&
          other.at == this.at);
}

class MemoryVersionsCompanion extends UpdateCompanion<MemoryVersion> {
  final Value<int> id;
  final Value<String> memoryId;
  final Value<int> version;
  final Value<String> content;
  final Value<String?> value;
  final Value<DateTime?> validTo;
  final Value<String> changedBy;
  final Value<String?> changeReason;
  final Value<DateTime> at;
  const MemoryVersionsCompanion({
    this.id = const Value.absent(),
    this.memoryId = const Value.absent(),
    this.version = const Value.absent(),
    this.content = const Value.absent(),
    this.value = const Value.absent(),
    this.validTo = const Value.absent(),
    this.changedBy = const Value.absent(),
    this.changeReason = const Value.absent(),
    this.at = const Value.absent(),
  });
  MemoryVersionsCompanion.insert({
    this.id = const Value.absent(),
    required String memoryId,
    required int version,
    required String content,
    this.value = const Value.absent(),
    this.validTo = const Value.absent(),
    required String changedBy,
    this.changeReason = const Value.absent(),
    required DateTime at,
  }) : memoryId = Value(memoryId),
       version = Value(version),
       content = Value(content),
       changedBy = Value(changedBy),
       at = Value(at);
  static Insertable<MemoryVersion> custom({
    Expression<int>? id,
    Expression<String>? memoryId,
    Expression<int>? version,
    Expression<String>? content,
    Expression<String>? value,
    Expression<DateTime>? validTo,
    Expression<String>? changedBy,
    Expression<String>? changeReason,
    Expression<DateTime>? at,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (memoryId != null) 'memory_id': memoryId,
      if (version != null) 'version': version,
      if (content != null) 'content': content,
      if (value != null) 'value': value,
      if (validTo != null) 'valid_to': validTo,
      if (changedBy != null) 'changed_by': changedBy,
      if (changeReason != null) 'change_reason': changeReason,
      if (at != null) 'at': at,
    });
  }

  MemoryVersionsCompanion copyWith({
    Value<int>? id,
    Value<String>? memoryId,
    Value<int>? version,
    Value<String>? content,
    Value<String?>? value,
    Value<DateTime?>? validTo,
    Value<String>? changedBy,
    Value<String?>? changeReason,
    Value<DateTime>? at,
  }) {
    return MemoryVersionsCompanion(
      id: id ?? this.id,
      memoryId: memoryId ?? this.memoryId,
      version: version ?? this.version,
      content: content ?? this.content,
      value: value ?? this.value,
      validTo: validTo ?? this.validTo,
      changedBy: changedBy ?? this.changedBy,
      changeReason: changeReason ?? this.changeReason,
      at: at ?? this.at,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (memoryId.present) {
      map['memory_id'] = Variable<String>(memoryId.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (validTo.present) {
      map['valid_to'] = Variable<DateTime>(validTo.value);
    }
    if (changedBy.present) {
      map['changed_by'] = Variable<String>(changedBy.value);
    }
    if (changeReason.present) {
      map['change_reason'] = Variable<String>(changeReason.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryVersionsCompanion(')
          ..write('id: $id, ')
          ..write('memoryId: $memoryId, ')
          ..write('version: $version, ')
          ..write('content: $content, ')
          ..write('value: $value, ')
          ..write('validTo: $validTo, ')
          ..write('changedBy: $changedBy, ')
          ..write('changeReason: $changeReason, ')
          ..write('at: $at')
          ..write(')'))
        .toString();
  }
}

class $EntitiesTable extends Entities with TableInfo<$EntitiesTable, Entity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Source, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Source>($EntitiesTable.$convertersource);
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sensitivity, int> sensitivity =
      GeneratedColumn<int>(
        'sensitivity',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Sensitivity>($EntitiesTable.$convertersensitivity);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attributesMeta = const VerificationMeta(
    'attributes',
  );
  @override
  late final GeneratedColumn<String> attributes = GeneratedColumn<String>(
    'attributes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    type,
    displayName,
    attributes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Entity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('attributes')) {
      context.handle(
        _attributesMeta,
        attributes.isAcceptableOrUnknown(data['attributes']!, _attributesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Entity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $EntitiesTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sensitivity: $EntitiesTable.$convertersensitivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sensitivity'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      attributes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attributes'],
      )!,
    );
  }

  @override
  $EntitiesTable createAlias(String alias) {
    return $EntitiesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Source, int, int> $convertersource =
      const EnumIndexConverter<Source>(Source.values);
  static JsonTypeConverter2<Sensitivity, int, int> $convertersensitivity =
      const EnumIndexConverter<Sensitivity>(Sensitivity.values);
}

class Entity extends DataClass implements Insertable<Entity> {
  final String id;
  final Source source;
  final String? sourceRef;
  final double confidence;
  final Sensitivity sensitivity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String type;
  final String displayName;
  final String attributes;
  const Entity({
    required this.id,
    required this.source,
    this.sourceRef,
    required this.confidence,
    required this.sensitivity,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.type,
    required this.displayName,
    required this.attributes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<int>(
        $EntitiesTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['confidence'] = Variable<double>(confidence);
    {
      map['sensitivity'] = Variable<int>(
        $EntitiesTable.$convertersensitivity.toSql(sensitivity),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['type'] = Variable<String>(type);
    map['display_name'] = Variable<String>(displayName);
    map['attributes'] = Variable<String>(attributes);
    return map;
  }

  EntitiesCompanion toCompanion(bool nullToAbsent) {
    return EntitiesCompanion(
      id: Value(id),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      confidence: Value(confidence),
      sensitivity: Value(sensitivity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      type: Value(type),
      displayName: Value(displayName),
      attributes: Value(attributes),
    );
  }

  factory Entity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entity(
      id: serializer.fromJson<String>(json['id']),
      source: $EntitiesTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sensitivity: $EntitiesTable.$convertersensitivity.fromJson(
        serializer.fromJson<int>(json['sensitivity']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      type: serializer.fromJson<String>(json['type']),
      displayName: serializer.fromJson<String>(json['displayName']),
      attributes: serializer.fromJson<String>(json['attributes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<int>(
        $EntitiesTable.$convertersource.toJson(source),
      ),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'confidence': serializer.toJson<double>(confidence),
      'sensitivity': serializer.toJson<int>(
        $EntitiesTable.$convertersensitivity.toJson(sensitivity),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'type': serializer.toJson<String>(type),
      'displayName': serializer.toJson<String>(displayName),
      'attributes': serializer.toJson<String>(attributes),
    };
  }

  Entity copyWith({
    String? id,
    Source? source,
    Value<String?> sourceRef = const Value.absent(),
    double? confidence,
    Sensitivity? sensitivity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? type,
    String? displayName,
    String? attributes,
  }) => Entity(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    confidence: confidence ?? this.confidence,
    sensitivity: sensitivity ?? this.sensitivity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    type: type ?? this.type,
    displayName: displayName ?? this.displayName,
    attributes: attributes ?? this.attributes,
  );
  Entity copyWithCompanion(EntitiesCompanion data) {
    return Entity(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sensitivity: data.sensitivity.present
          ? data.sensitivity.value
          : this.sensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      type: data.type.present ? data.type.value : this.type,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      attributes: data.attributes.present
          ? data.attributes.value
          : this.attributes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entity(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('type: $type, ')
          ..write('displayName: $displayName, ')
          ..write('attributes: $attributes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    type,
    displayName,
    attributes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entity &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.confidence == this.confidence &&
          other.sensitivity == this.sensitivity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.type == this.type &&
          other.displayName == this.displayName &&
          other.attributes == this.attributes);
}

class EntitiesCompanion extends UpdateCompanion<Entity> {
  final Value<String> id;
  final Value<Source> source;
  final Value<String?> sourceRef;
  final Value<double> confidence;
  final Value<Sensitivity> sensitivity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> type;
  final Value<String> displayName;
  final Value<String> attributes;
  final Value<int> rowid;
  const EntitiesCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.displayName = const Value.absent(),
    this.attributes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntitiesCompanion.insert({
    required String id,
    required Source source,
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    required String type,
    required String displayName,
    this.attributes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       type = Value(type),
       displayName = Value(displayName);
  static Insertable<Entity> custom({
    Expression<String>? id,
    Expression<int>? source,
    Expression<String>? sourceRef,
    Expression<double>? confidence,
    Expression<int>? sensitivity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? type,
    Expression<String>? displayName,
    Expression<String>? attributes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (confidence != null) 'confidence': confidence,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (type != null) 'type': type,
      if (displayName != null) 'display_name': displayName,
      if (attributes != null) 'attributes': attributes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntitiesCompanion copyWith({
    Value<String>? id,
    Value<Source>? source,
    Value<String?>? sourceRef,
    Value<double>? confidence,
    Value<Sensitivity>? sensitivity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? type,
    Value<String>? displayName,
    Value<String>? attributes,
    Value<int>? rowid,
  }) {
    return EntitiesCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      confidence: confidence ?? this.confidence,
      sensitivity: sensitivity ?? this.sensitivity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      type: type ?? this.type,
      displayName: displayName ?? this.displayName,
      attributes: attributes ?? this.attributes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $EntitiesTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int>(
        $EntitiesTable.$convertersensitivity.toSql(sensitivity.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (attributes.present) {
      map['attributes'] = Variable<String>(attributes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntitiesCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('type: $type, ')
          ..write('displayName: $displayName, ')
          ..write('attributes: $attributes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntityRelationshipsTable extends EntityRelationships
    with TableInfo<$EntityRelationshipsTable, EntityRelationship> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntityRelationshipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Source, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Source>($EntityRelationshipsTable.$convertersource);
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sensitivity, int> sensitivity =
      GeneratedColumn<int>(
        'sensitivity',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Sensitivity>(
        $EntityRelationshipsTable.$convertersensitivity,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fromEntityMeta = const VerificationMeta(
    'fromEntity',
  );
  @override
  late final GeneratedColumn<String> fromEntity = GeneratedColumn<String>(
    'from_entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entities (id)',
    ),
  );
  static const VerificationMeta _toEntityMeta = const VerificationMeta(
    'toEntity',
  );
  @override
  late final GeneratedColumn<String> toEntity = GeneratedColumn<String>(
    'to_entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entities (id)',
    ),
  );
  static const VerificationMeta _relationMeta = const VerificationMeta(
    'relation',
  );
  @override
  late final GeneratedColumn<String> relation = GeneratedColumn<String>(
    'relation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _validFromMeta = const VerificationMeta(
    'validFrom',
  );
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
    'valid_from',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validToMeta = const VerificationMeta(
    'validTo',
  );
  @override
  late final GeneratedColumn<DateTime> validTo = GeneratedColumn<DateTime>(
    'valid_to',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    fromEntity,
    toEntity,
    relation,
    validFrom,
    validTo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entity_relationships';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntityRelationship> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('from_entity')) {
      context.handle(
        _fromEntityMeta,
        fromEntity.isAcceptableOrUnknown(data['from_entity']!, _fromEntityMeta),
      );
    } else if (isInserting) {
      context.missing(_fromEntityMeta);
    }
    if (data.containsKey('to_entity')) {
      context.handle(
        _toEntityMeta,
        toEntity.isAcceptableOrUnknown(data['to_entity']!, _toEntityMeta),
      );
    } else if (isInserting) {
      context.missing(_toEntityMeta);
    }
    if (data.containsKey('relation')) {
      context.handle(
        _relationMeta,
        relation.isAcceptableOrUnknown(data['relation']!, _relationMeta),
      );
    } else if (isInserting) {
      context.missing(_relationMeta);
    }
    if (data.containsKey('valid_from')) {
      context.handle(
        _validFromMeta,
        validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta),
      );
    }
    if (data.containsKey('valid_to')) {
      context.handle(
        _validToMeta,
        validTo.isAcceptableOrUnknown(data['valid_to']!, _validToMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntityRelationship map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntityRelationship(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $EntityRelationshipsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sensitivity: $EntityRelationshipsTable.$convertersensitivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sensitivity'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      fromEntity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_entity'],
      )!,
      toEntity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_entity'],
      )!,
      relation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation'],
      )!,
      validFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_from'],
      ),
      validTo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_to'],
      ),
    );
  }

  @override
  $EntityRelationshipsTable createAlias(String alias) {
    return $EntityRelationshipsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Source, int, int> $convertersource =
      const EnumIndexConverter<Source>(Source.values);
  static JsonTypeConverter2<Sensitivity, int, int> $convertersensitivity =
      const EnumIndexConverter<Sensitivity>(Sensitivity.values);
}

class EntityRelationship extends DataClass
    implements Insertable<EntityRelationship> {
  final String id;
  final Source source;
  final String? sourceRef;
  final double confidence;
  final Sensitivity sensitivity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String fromEntity;
  final String toEntity;
  final String relation;
  final DateTime? validFrom;
  final DateTime? validTo;
  const EntityRelationship({
    required this.id,
    required this.source,
    this.sourceRef,
    required this.confidence,
    required this.sensitivity,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.fromEntity,
    required this.toEntity,
    required this.relation,
    this.validFrom,
    this.validTo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<int>(
        $EntityRelationshipsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['confidence'] = Variable<double>(confidence);
    {
      map['sensitivity'] = Variable<int>(
        $EntityRelationshipsTable.$convertersensitivity.toSql(sensitivity),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['from_entity'] = Variable<String>(fromEntity);
    map['to_entity'] = Variable<String>(toEntity);
    map['relation'] = Variable<String>(relation);
    if (!nullToAbsent || validFrom != null) {
      map['valid_from'] = Variable<DateTime>(validFrom);
    }
    if (!nullToAbsent || validTo != null) {
      map['valid_to'] = Variable<DateTime>(validTo);
    }
    return map;
  }

  EntityRelationshipsCompanion toCompanion(bool nullToAbsent) {
    return EntityRelationshipsCompanion(
      id: Value(id),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      confidence: Value(confidence),
      sensitivity: Value(sensitivity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      fromEntity: Value(fromEntity),
      toEntity: Value(toEntity),
      relation: Value(relation),
      validFrom: validFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(validFrom),
      validTo: validTo == null && nullToAbsent
          ? const Value.absent()
          : Value(validTo),
    );
  }

  factory EntityRelationship.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntityRelationship(
      id: serializer.fromJson<String>(json['id']),
      source: $EntityRelationshipsTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sensitivity: $EntityRelationshipsTable.$convertersensitivity.fromJson(
        serializer.fromJson<int>(json['sensitivity']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      fromEntity: serializer.fromJson<String>(json['fromEntity']),
      toEntity: serializer.fromJson<String>(json['toEntity']),
      relation: serializer.fromJson<String>(json['relation']),
      validFrom: serializer.fromJson<DateTime?>(json['validFrom']),
      validTo: serializer.fromJson<DateTime?>(json['validTo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<int>(
        $EntityRelationshipsTable.$convertersource.toJson(source),
      ),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'confidence': serializer.toJson<double>(confidence),
      'sensitivity': serializer.toJson<int>(
        $EntityRelationshipsTable.$convertersensitivity.toJson(sensitivity),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'fromEntity': serializer.toJson<String>(fromEntity),
      'toEntity': serializer.toJson<String>(toEntity),
      'relation': serializer.toJson<String>(relation),
      'validFrom': serializer.toJson<DateTime?>(validFrom),
      'validTo': serializer.toJson<DateTime?>(validTo),
    };
  }

  EntityRelationship copyWith({
    String? id,
    Source? source,
    Value<String?> sourceRef = const Value.absent(),
    double? confidence,
    Sensitivity? sensitivity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? fromEntity,
    String? toEntity,
    String? relation,
    Value<DateTime?> validFrom = const Value.absent(),
    Value<DateTime?> validTo = const Value.absent(),
  }) => EntityRelationship(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    confidence: confidence ?? this.confidence,
    sensitivity: sensitivity ?? this.sensitivity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    fromEntity: fromEntity ?? this.fromEntity,
    toEntity: toEntity ?? this.toEntity,
    relation: relation ?? this.relation,
    validFrom: validFrom.present ? validFrom.value : this.validFrom,
    validTo: validTo.present ? validTo.value : this.validTo,
  );
  EntityRelationship copyWithCompanion(EntityRelationshipsCompanion data) {
    return EntityRelationship(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sensitivity: data.sensitivity.present
          ? data.sensitivity.value
          : this.sensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      fromEntity: data.fromEntity.present
          ? data.fromEntity.value
          : this.fromEntity,
      toEntity: data.toEntity.present ? data.toEntity.value : this.toEntity,
      relation: data.relation.present ? data.relation.value : this.relation,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      validTo: data.validTo.present ? data.validTo.value : this.validTo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntityRelationship(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('fromEntity: $fromEntity, ')
          ..write('toEntity: $toEntity, ')
          ..write('relation: $relation, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    fromEntity,
    toEntity,
    relation,
    validFrom,
    validTo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntityRelationship &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.confidence == this.confidence &&
          other.sensitivity == this.sensitivity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.fromEntity == this.fromEntity &&
          other.toEntity == this.toEntity &&
          other.relation == this.relation &&
          other.validFrom == this.validFrom &&
          other.validTo == this.validTo);
}

class EntityRelationshipsCompanion extends UpdateCompanion<EntityRelationship> {
  final Value<String> id;
  final Value<Source> source;
  final Value<String?> sourceRef;
  final Value<double> confidence;
  final Value<Sensitivity> sensitivity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> fromEntity;
  final Value<String> toEntity;
  final Value<String> relation;
  final Value<DateTime?> validFrom;
  final Value<DateTime?> validTo;
  final Value<int> rowid;
  const EntityRelationshipsCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.fromEntity = const Value.absent(),
    this.toEntity = const Value.absent(),
    this.relation = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntityRelationshipsCompanion.insert({
    required String id,
    required Source source,
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    required String fromEntity,
    required String toEntity,
    required String relation,
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       fromEntity = Value(fromEntity),
       toEntity = Value(toEntity),
       relation = Value(relation);
  static Insertable<EntityRelationship> custom({
    Expression<String>? id,
    Expression<int>? source,
    Expression<String>? sourceRef,
    Expression<double>? confidence,
    Expression<int>? sensitivity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? fromEntity,
    Expression<String>? toEntity,
    Expression<String>? relation,
    Expression<DateTime>? validFrom,
    Expression<DateTime>? validTo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (confidence != null) 'confidence': confidence,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (fromEntity != null) 'from_entity': fromEntity,
      if (toEntity != null) 'to_entity': toEntity,
      if (relation != null) 'relation': relation,
      if (validFrom != null) 'valid_from': validFrom,
      if (validTo != null) 'valid_to': validTo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntityRelationshipsCompanion copyWith({
    Value<String>? id,
    Value<Source>? source,
    Value<String?>? sourceRef,
    Value<double>? confidence,
    Value<Sensitivity>? sensitivity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? fromEntity,
    Value<String>? toEntity,
    Value<String>? relation,
    Value<DateTime?>? validFrom,
    Value<DateTime?>? validTo,
    Value<int>? rowid,
  }) {
    return EntityRelationshipsCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      confidence: confidence ?? this.confidence,
      sensitivity: sensitivity ?? this.sensitivity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      fromEntity: fromEntity ?? this.fromEntity,
      toEntity: toEntity ?? this.toEntity,
      relation: relation ?? this.relation,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $EntityRelationshipsTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int>(
        $EntityRelationshipsTable.$convertersensitivity.toSql(
          sensitivity.value,
        ),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (fromEntity.present) {
      map['from_entity'] = Variable<String>(fromEntity.value);
    }
    if (toEntity.present) {
      map['to_entity'] = Variable<String>(toEntity.value);
    }
    if (relation.present) {
      map['relation'] = Variable<String>(relation.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<DateTime>(validFrom.value);
    }
    if (validTo.present) {
      map['valid_to'] = Variable<DateTime>(validTo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntityRelationshipsCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('fromEntity: $fromEntity, ')
          ..write('toEntity: $toEntity, ')
          ..write('relation: $relation, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntityDatesTable extends EntityDates
    with TableInfo<$EntityDatesTable, EntityDate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntityDatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Source, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Source>($EntityDatesTable.$convertersource);
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sensitivity, int> sensitivity =
      GeneratedColumn<int>(
        'sensitivity',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Sensitivity>($EntityDatesTable.$convertersensitivity);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entities (id)',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recurrenceRuleMeta = const VerificationMeta(
    'recurrenceRule',
  );
  @override
  late final GeneratedColumn<String> recurrenceRule = GeneratedColumn<String>(
    'recurrence_rule',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remindDaysBeforeMeta = const VerificationMeta(
    'remindDaysBefore',
  );
  @override
  late final GeneratedColumn<int> remindDaysBefore = GeneratedColumn<int>(
    'remind_days_before',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    entityId,
    kind,
    date,
    recurrenceRule,
    remindDaysBefore,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entity_dates';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntityDate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('recurrence_rule')) {
      context.handle(
        _recurrenceRuleMeta,
        recurrenceRule.isAcceptableOrUnknown(
          data['recurrence_rule']!,
          _recurrenceRuleMeta,
        ),
      );
    }
    if (data.containsKey('remind_days_before')) {
      context.handle(
        _remindDaysBeforeMeta,
        remindDaysBefore.isAcceptableOrUnknown(
          data['remind_days_before']!,
          _remindDaysBeforeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntityDate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntityDate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $EntityDatesTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sensitivity: $EntityDatesTable.$convertersensitivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sensitivity'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      recurrenceRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_rule'],
      ),
      remindDaysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remind_days_before'],
      ),
    );
  }

  @override
  $EntityDatesTable createAlias(String alias) {
    return $EntityDatesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Source, int, int> $convertersource =
      const EnumIndexConverter<Source>(Source.values);
  static JsonTypeConverter2<Sensitivity, int, int> $convertersensitivity =
      const EnumIndexConverter<Sensitivity>(Sensitivity.values);
}

class EntityDate extends DataClass implements Insertable<EntityDate> {
  final String id;
  final Source source;
  final String? sourceRef;
  final double confidence;
  final Sensitivity sensitivity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String entityId;
  final String kind;
  final DateTime date;
  final String? recurrenceRule;

  /// Schema v4: remind this many days before each occurrence; null for none.
  final int? remindDaysBefore;
  const EntityDate({
    required this.id,
    required this.source,
    this.sourceRef,
    required this.confidence,
    required this.sensitivity,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.entityId,
    required this.kind,
    required this.date,
    this.recurrenceRule,
    this.remindDaysBefore,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<int>(
        $EntityDatesTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['confidence'] = Variable<double>(confidence);
    {
      map['sensitivity'] = Variable<int>(
        $EntityDatesTable.$convertersensitivity.toSql(sensitivity),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['entity_id'] = Variable<String>(entityId);
    map['kind'] = Variable<String>(kind);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || recurrenceRule != null) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule);
    }
    if (!nullToAbsent || remindDaysBefore != null) {
      map['remind_days_before'] = Variable<int>(remindDaysBefore);
    }
    return map;
  }

  EntityDatesCompanion toCompanion(bool nullToAbsent) {
    return EntityDatesCompanion(
      id: Value(id),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      confidence: Value(confidence),
      sensitivity: Value(sensitivity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      entityId: Value(entityId),
      kind: Value(kind),
      date: Value(date),
      recurrenceRule: recurrenceRule == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceRule),
      remindDaysBefore: remindDaysBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(remindDaysBefore),
    );
  }

  factory EntityDate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntityDate(
      id: serializer.fromJson<String>(json['id']),
      source: $EntityDatesTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sensitivity: $EntityDatesTable.$convertersensitivity.fromJson(
        serializer.fromJson<int>(json['sensitivity']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      entityId: serializer.fromJson<String>(json['entityId']),
      kind: serializer.fromJson<String>(json['kind']),
      date: serializer.fromJson<DateTime>(json['date']),
      recurrenceRule: serializer.fromJson<String?>(json['recurrenceRule']),
      remindDaysBefore: serializer.fromJson<int?>(json['remindDaysBefore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<int>(
        $EntityDatesTable.$convertersource.toJson(source),
      ),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'confidence': serializer.toJson<double>(confidence),
      'sensitivity': serializer.toJson<int>(
        $EntityDatesTable.$convertersensitivity.toJson(sensitivity),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'entityId': serializer.toJson<String>(entityId),
      'kind': serializer.toJson<String>(kind),
      'date': serializer.toJson<DateTime>(date),
      'recurrenceRule': serializer.toJson<String?>(recurrenceRule),
      'remindDaysBefore': serializer.toJson<int?>(remindDaysBefore),
    };
  }

  EntityDate copyWith({
    String? id,
    Source? source,
    Value<String?> sourceRef = const Value.absent(),
    double? confidence,
    Sensitivity? sensitivity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? entityId,
    String? kind,
    DateTime? date,
    Value<String?> recurrenceRule = const Value.absent(),
    Value<int?> remindDaysBefore = const Value.absent(),
  }) => EntityDate(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    confidence: confidence ?? this.confidence,
    sensitivity: sensitivity ?? this.sensitivity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    entityId: entityId ?? this.entityId,
    kind: kind ?? this.kind,
    date: date ?? this.date,
    recurrenceRule: recurrenceRule.present
        ? recurrenceRule.value
        : this.recurrenceRule,
    remindDaysBefore: remindDaysBefore.present
        ? remindDaysBefore.value
        : this.remindDaysBefore,
  );
  EntityDate copyWithCompanion(EntityDatesCompanion data) {
    return EntityDate(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sensitivity: data.sensitivity.present
          ? data.sensitivity.value
          : this.sensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      kind: data.kind.present ? data.kind.value : this.kind,
      date: data.date.present ? data.date.value : this.date,
      recurrenceRule: data.recurrenceRule.present
          ? data.recurrenceRule.value
          : this.recurrenceRule,
      remindDaysBefore: data.remindDaysBefore.present
          ? data.remindDaysBefore.value
          : this.remindDaysBefore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntityDate(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('entityId: $entityId, ')
          ..write('kind: $kind, ')
          ..write('date: $date, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('remindDaysBefore: $remindDaysBefore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    entityId,
    kind,
    date,
    recurrenceRule,
    remindDaysBefore,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntityDate &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.confidence == this.confidence &&
          other.sensitivity == this.sensitivity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.entityId == this.entityId &&
          other.kind == this.kind &&
          other.date == this.date &&
          other.recurrenceRule == this.recurrenceRule &&
          other.remindDaysBefore == this.remindDaysBefore);
}

class EntityDatesCompanion extends UpdateCompanion<EntityDate> {
  final Value<String> id;
  final Value<Source> source;
  final Value<String?> sourceRef;
  final Value<double> confidence;
  final Value<Sensitivity> sensitivity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> entityId;
  final Value<String> kind;
  final Value<DateTime> date;
  final Value<String?> recurrenceRule;
  final Value<int?> remindDaysBefore;
  final Value<int> rowid;
  const EntityDatesCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.entityId = const Value.absent(),
    this.kind = const Value.absent(),
    this.date = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.remindDaysBefore = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntityDatesCompanion.insert({
    required String id,
    required Source source,
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    required String entityId,
    required String kind,
    required DateTime date,
    this.recurrenceRule = const Value.absent(),
    this.remindDaysBefore = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       entityId = Value(entityId),
       kind = Value(kind),
       date = Value(date);
  static Insertable<EntityDate> custom({
    Expression<String>? id,
    Expression<int>? source,
    Expression<String>? sourceRef,
    Expression<double>? confidence,
    Expression<int>? sensitivity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? entityId,
    Expression<String>? kind,
    Expression<DateTime>? date,
    Expression<String>? recurrenceRule,
    Expression<int>? remindDaysBefore,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (confidence != null) 'confidence': confidence,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (entityId != null) 'entity_id': entityId,
      if (kind != null) 'kind': kind,
      if (date != null) 'date': date,
      if (recurrenceRule != null) 'recurrence_rule': recurrenceRule,
      if (remindDaysBefore != null) 'remind_days_before': remindDaysBefore,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntityDatesCompanion copyWith({
    Value<String>? id,
    Value<Source>? source,
    Value<String?>? sourceRef,
    Value<double>? confidence,
    Value<Sensitivity>? sensitivity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? entityId,
    Value<String>? kind,
    Value<DateTime>? date,
    Value<String?>? recurrenceRule,
    Value<int?>? remindDaysBefore,
    Value<int>? rowid,
  }) {
    return EntityDatesCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      confidence: confidence ?? this.confidence,
      sensitivity: sensitivity ?? this.sensitivity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      entityId: entityId ?? this.entityId,
      kind: kind ?? this.kind,
      date: date ?? this.date,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      remindDaysBefore: remindDaysBefore ?? this.remindDaysBefore,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $EntityDatesTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int>(
        $EntityDatesTable.$convertersensitivity.toSql(sensitivity.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (recurrenceRule.present) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule.value);
    }
    if (remindDaysBefore.present) {
      map['remind_days_before'] = Variable<int>(remindDaysBefore.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntityDatesCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('entityId: $entityId, ')
          ..write('kind: $kind, ')
          ..write('date: $date, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('remindDaysBefore: $remindDaysBefore, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Source, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Source>($DocumentsTable.$convertersource);
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sensitivity, int> sensitivity =
      GeneratedColumn<int>(
        'sensitivity',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Sensitivity>($DocumentsTable.$convertersensitivity);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _blobPathMeta = const VerificationMeta(
    'blobPath',
  );
  @override
  late final GeneratedColumn<String> blobPath = GeneratedColumn<String>(
    'blob_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _docTypeMeta = const VerificationMeta(
    'docType',
  );
  @override
  late final GeneratedColumn<String> docType = GeneratedColumn<String>(
    'doc_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _classificationConfidenceMeta =
      const VerificationMeta('classificationConfidence');
  @override
  late final GeneratedColumn<double> classificationConfidence =
      GeneratedColumn<double>(
        'classification_confidence',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _ocrStatusMeta = const VerificationMeta(
    'ocrStatus',
  );
  @override
  late final GeneratedColumn<String> ocrStatus = GeneratedColumn<String>(
    'ocr_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _extractionStatusMeta = const VerificationMeta(
    'extractionStatus',
  );
  @override
  late final GeneratedColumn<String> extractionStatus = GeneratedColumn<String>(
    'extraction_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entities (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    fileName,
    title,
    mimeType,
    sha256,
    sizeBytes,
    blobPath,
    docType,
    classificationConfidence,
    ocrStatus,
    extractionStatus,
    entityId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('blob_path')) {
      context.handle(
        _blobPathMeta,
        blobPath.isAcceptableOrUnknown(data['blob_path']!, _blobPathMeta),
      );
    } else if (isInserting) {
      context.missing(_blobPathMeta);
    }
    if (data.containsKey('doc_type')) {
      context.handle(
        _docTypeMeta,
        docType.isAcceptableOrUnknown(data['doc_type']!, _docTypeMeta),
      );
    }
    if (data.containsKey('classification_confidence')) {
      context.handle(
        _classificationConfidenceMeta,
        classificationConfidence.isAcceptableOrUnknown(
          data['classification_confidence']!,
          _classificationConfidenceMeta,
        ),
      );
    }
    if (data.containsKey('ocr_status')) {
      context.handle(
        _ocrStatusMeta,
        ocrStatus.isAcceptableOrUnknown(data['ocr_status']!, _ocrStatusMeta),
      );
    }
    if (data.containsKey('extraction_status')) {
      context.handle(
        _extractionStatusMeta,
        extractionStatus.isAcceptableOrUnknown(
          data['extraction_status']!,
          _extractionStatusMeta,
        ),
      );
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $DocumentsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sensitivity: $DocumentsTable.$convertersensitivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sensitivity'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      blobPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blob_path'],
      )!,
      docType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doc_type'],
      ),
      classificationConfidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}classification_confidence'],
      ),
      ocrStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_status'],
      )!,
      extractionStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extraction_status'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      ),
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Source, int, int> $convertersource =
      const EnumIndexConverter<Source>(Source.values);
  static JsonTypeConverter2<Sensitivity, int, int> $convertersensitivity =
      const EnumIndexConverter<Sensitivity>(Sensitivity.values);
}

class Document extends DataClass implements Insertable<Document> {
  final String id;
  final Source source;
  final String? sourceRef;
  final double confidence;
  final Sensitivity sensitivity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String fileName;

  /// Schema v3: a readable name, e.g. "Kasko poliçesi – Anadolu Sigorta".
  final String? title;
  final String mimeType;
  final String sha256;
  final int sizeBytes;

  /// Path of the encrypted blob inside the app's private storage.
  final String blobPath;
  final String? docType;
  final double? classificationConfidence;
  final String ocrStatus;
  final String extractionStatus;
  final String? entityId;
  const Document({
    required this.id,
    required this.source,
    this.sourceRef,
    required this.confidence,
    required this.sensitivity,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.fileName,
    this.title,
    required this.mimeType,
    required this.sha256,
    required this.sizeBytes,
    required this.blobPath,
    this.docType,
    this.classificationConfidence,
    required this.ocrStatus,
    required this.extractionStatus,
    this.entityId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<int>(
        $DocumentsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['confidence'] = Variable<double>(confidence);
    {
      map['sensitivity'] = Variable<int>(
        $DocumentsTable.$convertersensitivity.toSql(sensitivity),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['file_name'] = Variable<String>(fileName);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['mime_type'] = Variable<String>(mimeType);
    map['sha256'] = Variable<String>(sha256);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['blob_path'] = Variable<String>(blobPath);
    if (!nullToAbsent || docType != null) {
      map['doc_type'] = Variable<String>(docType);
    }
    if (!nullToAbsent || classificationConfidence != null) {
      map['classification_confidence'] = Variable<double>(
        classificationConfidence,
      );
    }
    map['ocr_status'] = Variable<String>(ocrStatus);
    map['extraction_status'] = Variable<String>(extractionStatus);
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<String>(entityId);
    }
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      confidence: Value(confidence),
      sensitivity: Value(sensitivity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      fileName: Value(fileName),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      mimeType: Value(mimeType),
      sha256: Value(sha256),
      sizeBytes: Value(sizeBytes),
      blobPath: Value(blobPath),
      docType: docType == null && nullToAbsent
          ? const Value.absent()
          : Value(docType),
      classificationConfidence: classificationConfidence == null && nullToAbsent
          ? const Value.absent()
          : Value(classificationConfidence),
      ocrStatus: Value(ocrStatus),
      extractionStatus: Value(extractionStatus),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<String>(json['id']),
      source: $DocumentsTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sensitivity: $DocumentsTable.$convertersensitivity.fromJson(
        serializer.fromJson<int>(json['sensitivity']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      fileName: serializer.fromJson<String>(json['fileName']),
      title: serializer.fromJson<String?>(json['title']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      sha256: serializer.fromJson<String>(json['sha256']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      blobPath: serializer.fromJson<String>(json['blobPath']),
      docType: serializer.fromJson<String?>(json['docType']),
      classificationConfidence: serializer.fromJson<double?>(
        json['classificationConfidence'],
      ),
      ocrStatus: serializer.fromJson<String>(json['ocrStatus']),
      extractionStatus: serializer.fromJson<String>(json['extractionStatus']),
      entityId: serializer.fromJson<String?>(json['entityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<int>(
        $DocumentsTable.$convertersource.toJson(source),
      ),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'confidence': serializer.toJson<double>(confidence),
      'sensitivity': serializer.toJson<int>(
        $DocumentsTable.$convertersensitivity.toJson(sensitivity),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'fileName': serializer.toJson<String>(fileName),
      'title': serializer.toJson<String?>(title),
      'mimeType': serializer.toJson<String>(mimeType),
      'sha256': serializer.toJson<String>(sha256),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'blobPath': serializer.toJson<String>(blobPath),
      'docType': serializer.toJson<String?>(docType),
      'classificationConfidence': serializer.toJson<double?>(
        classificationConfidence,
      ),
      'ocrStatus': serializer.toJson<String>(ocrStatus),
      'extractionStatus': serializer.toJson<String>(extractionStatus),
      'entityId': serializer.toJson<String?>(entityId),
    };
  }

  Document copyWith({
    String? id,
    Source? source,
    Value<String?> sourceRef = const Value.absent(),
    double? confidence,
    Sensitivity? sensitivity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? fileName,
    Value<String?> title = const Value.absent(),
    String? mimeType,
    String? sha256,
    int? sizeBytes,
    String? blobPath,
    Value<String?> docType = const Value.absent(),
    Value<double?> classificationConfidence = const Value.absent(),
    String? ocrStatus,
    String? extractionStatus,
    Value<String?> entityId = const Value.absent(),
  }) => Document(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    confidence: confidence ?? this.confidence,
    sensitivity: sensitivity ?? this.sensitivity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    fileName: fileName ?? this.fileName,
    title: title.present ? title.value : this.title,
    mimeType: mimeType ?? this.mimeType,
    sha256: sha256 ?? this.sha256,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    blobPath: blobPath ?? this.blobPath,
    docType: docType.present ? docType.value : this.docType,
    classificationConfidence: classificationConfidence.present
        ? classificationConfidence.value
        : this.classificationConfidence,
    ocrStatus: ocrStatus ?? this.ocrStatus,
    extractionStatus: extractionStatus ?? this.extractionStatus,
    entityId: entityId.present ? entityId.value : this.entityId,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sensitivity: data.sensitivity.present
          ? data.sensitivity.value
          : this.sensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      title: data.title.present ? data.title.value : this.title,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      blobPath: data.blobPath.present ? data.blobPath.value : this.blobPath,
      docType: data.docType.present ? data.docType.value : this.docType,
      classificationConfidence: data.classificationConfidence.present
          ? data.classificationConfidence.value
          : this.classificationConfidence,
      ocrStatus: data.ocrStatus.present ? data.ocrStatus.value : this.ocrStatus,
      extractionStatus: data.extractionStatus.present
          ? data.extractionStatus.value
          : this.extractionStatus,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('fileName: $fileName, ')
          ..write('title: $title, ')
          ..write('mimeType: $mimeType, ')
          ..write('sha256: $sha256, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('blobPath: $blobPath, ')
          ..write('docType: $docType, ')
          ..write('classificationConfidence: $classificationConfidence, ')
          ..write('ocrStatus: $ocrStatus, ')
          ..write('extractionStatus: $extractionStatus, ')
          ..write('entityId: $entityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    fileName,
    title,
    mimeType,
    sha256,
    sizeBytes,
    blobPath,
    docType,
    classificationConfidence,
    ocrStatus,
    extractionStatus,
    entityId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.confidence == this.confidence &&
          other.sensitivity == this.sensitivity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.fileName == this.fileName &&
          other.title == this.title &&
          other.mimeType == this.mimeType &&
          other.sha256 == this.sha256 &&
          other.sizeBytes == this.sizeBytes &&
          other.blobPath == this.blobPath &&
          other.docType == this.docType &&
          other.classificationConfidence == this.classificationConfidence &&
          other.ocrStatus == this.ocrStatus &&
          other.extractionStatus == this.extractionStatus &&
          other.entityId == this.entityId);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<String> id;
  final Value<Source> source;
  final Value<String?> sourceRef;
  final Value<double> confidence;
  final Value<Sensitivity> sensitivity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> fileName;
  final Value<String?> title;
  final Value<String> mimeType;
  final Value<String> sha256;
  final Value<int> sizeBytes;
  final Value<String> blobPath;
  final Value<String?> docType;
  final Value<double?> classificationConfidence;
  final Value<String> ocrStatus;
  final Value<String> extractionStatus;
  final Value<String?> entityId;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.fileName = const Value.absent(),
    this.title = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.blobPath = const Value.absent(),
    this.docType = const Value.absent(),
    this.classificationConfidence = const Value.absent(),
    this.ocrStatus = const Value.absent(),
    this.extractionStatus = const Value.absent(),
    this.entityId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String id,
    required Source source,
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    required String fileName,
    this.title = const Value.absent(),
    required String mimeType,
    required String sha256,
    required int sizeBytes,
    required String blobPath,
    this.docType = const Value.absent(),
    this.classificationConfidence = const Value.absent(),
    this.ocrStatus = const Value.absent(),
    this.extractionStatus = const Value.absent(),
    this.entityId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       fileName = Value(fileName),
       mimeType = Value(mimeType),
       sha256 = Value(sha256),
       sizeBytes = Value(sizeBytes),
       blobPath = Value(blobPath);
  static Insertable<Document> custom({
    Expression<String>? id,
    Expression<int>? source,
    Expression<String>? sourceRef,
    Expression<double>? confidence,
    Expression<int>? sensitivity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? fileName,
    Expression<String>? title,
    Expression<String>? mimeType,
    Expression<String>? sha256,
    Expression<int>? sizeBytes,
    Expression<String>? blobPath,
    Expression<String>? docType,
    Expression<double>? classificationConfidence,
    Expression<String>? ocrStatus,
    Expression<String>? extractionStatus,
    Expression<String>? entityId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (confidence != null) 'confidence': confidence,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (fileName != null) 'file_name': fileName,
      if (title != null) 'title': title,
      if (mimeType != null) 'mime_type': mimeType,
      if (sha256 != null) 'sha256': sha256,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (blobPath != null) 'blob_path': blobPath,
      if (docType != null) 'doc_type': docType,
      if (classificationConfidence != null)
        'classification_confidence': classificationConfidence,
      if (ocrStatus != null) 'ocr_status': ocrStatus,
      if (extractionStatus != null) 'extraction_status': extractionStatus,
      if (entityId != null) 'entity_id': entityId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<String>? id,
    Value<Source>? source,
    Value<String?>? sourceRef,
    Value<double>? confidence,
    Value<Sensitivity>? sensitivity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? fileName,
    Value<String?>? title,
    Value<String>? mimeType,
    Value<String>? sha256,
    Value<int>? sizeBytes,
    Value<String>? blobPath,
    Value<String?>? docType,
    Value<double?>? classificationConfidence,
    Value<String>? ocrStatus,
    Value<String>? extractionStatus,
    Value<String?>? entityId,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      confidence: confidence ?? this.confidence,
      sensitivity: sensitivity ?? this.sensitivity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      fileName: fileName ?? this.fileName,
      title: title ?? this.title,
      mimeType: mimeType ?? this.mimeType,
      sha256: sha256 ?? this.sha256,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      blobPath: blobPath ?? this.blobPath,
      docType: docType ?? this.docType,
      classificationConfidence:
          classificationConfidence ?? this.classificationConfidence,
      ocrStatus: ocrStatus ?? this.ocrStatus,
      extractionStatus: extractionStatus ?? this.extractionStatus,
      entityId: entityId ?? this.entityId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $DocumentsTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int>(
        $DocumentsTable.$convertersensitivity.toSql(sensitivity.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (blobPath.present) {
      map['blob_path'] = Variable<String>(blobPath.value);
    }
    if (docType.present) {
      map['doc_type'] = Variable<String>(docType.value);
    }
    if (classificationConfidence.present) {
      map['classification_confidence'] = Variable<double>(
        classificationConfidence.value,
      );
    }
    if (ocrStatus.present) {
      map['ocr_status'] = Variable<String>(ocrStatus.value);
    }
    if (extractionStatus.present) {
      map['extraction_status'] = Variable<String>(extractionStatus.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('fileName: $fileName, ')
          ..write('title: $title, ')
          ..write('mimeType: $mimeType, ')
          ..write('sha256: $sha256, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('blobPath: $blobPath, ')
          ..write('docType: $docType, ')
          ..write('classificationConfidence: $classificationConfidence, ')
          ..write('ocrStatus: $ocrStatus, ')
          ..write('extractionStatus: $extractionStatus, ')
          ..write('entityId: $entityId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentExtractionsTable extends DocumentExtractions
    with TableInfo<$DocumentExtractionsTable, DocumentExtraction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentExtractionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id)',
    ),
  );
  static const VerificationMeta _fieldMeta = const VerificationMeta('field');
  @override
  late final GeneratedColumn<String> field = GeneratedColumn<String>(
    'field',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
    'page',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReviewStatus, int> reviewStatus =
      GeneratedColumn<int>(
        'review_status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<ReviewStatus>(
        $DocumentExtractionsTable.$converterreviewStatus,
      );
  static const VerificationMeta _quoteMeta = const VerificationMeta('quote');
  @override
  late final GeneratedColumn<String> quote = GeneratedColumn<String>(
    'quote',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    field,
    value,
    confidence,
    page,
    reviewStatus,
    quote,
    origin,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_extractions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentExtraction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('field')) {
      context.handle(
        _fieldMeta,
        field.isAcceptableOrUnknown(data['field']!, _fieldMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('page')) {
      context.handle(
        _pageMeta,
        page.isAcceptableOrUnknown(data['page']!, _pageMeta),
      );
    }
    if (data.containsKey('quote')) {
      context.handle(
        _quoteMeta,
        quote.isAcceptableOrUnknown(data['quote']!, _quoteMeta),
      );
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentExtraction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentExtraction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      field: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      page: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page'],
      ),
      reviewStatus: $DocumentExtractionsTable.$converterreviewStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}review_status'],
        )!,
      ),
      quote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote'],
      ),
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      )!,
    );
  }

  @override
  $DocumentExtractionsTable createAlias(String alias) {
    return $DocumentExtractionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReviewStatus, int, int> $converterreviewStatus =
      const EnumIndexConverter<ReviewStatus>(ReviewStatus.values);
}

class DocumentExtraction extends DataClass
    implements Insertable<DocumentExtraction> {
  final String id;
  final String documentId;
  final String field;
  final String value;
  final double confidence;
  final int? page;
  final ReviewStatus reviewStatus;

  /// Schema v3: the passage the value was read from, and who read it (local | ai).
  final String? quote;
  final String origin;
  const DocumentExtraction({
    required this.id,
    required this.documentId,
    required this.field,
    required this.value,
    required this.confidence,
    this.page,
    required this.reviewStatus,
    this.quote,
    required this.origin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['field'] = Variable<String>(field);
    map['value'] = Variable<String>(value);
    map['confidence'] = Variable<double>(confidence);
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    {
      map['review_status'] = Variable<int>(
        $DocumentExtractionsTable.$converterreviewStatus.toSql(reviewStatus),
      );
    }
    if (!nullToAbsent || quote != null) {
      map['quote'] = Variable<String>(quote);
    }
    map['origin'] = Variable<String>(origin);
    return map;
  }

  DocumentExtractionsCompanion toCompanion(bool nullToAbsent) {
    return DocumentExtractionsCompanion(
      id: Value(id),
      documentId: Value(documentId),
      field: Value(field),
      value: Value(value),
      confidence: Value(confidence),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
      reviewStatus: Value(reviewStatus),
      quote: quote == null && nullToAbsent
          ? const Value.absent()
          : Value(quote),
      origin: Value(origin),
    );
  }

  factory DocumentExtraction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentExtraction(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      field: serializer.fromJson<String>(json['field']),
      value: serializer.fromJson<String>(json['value']),
      confidence: serializer.fromJson<double>(json['confidence']),
      page: serializer.fromJson<int?>(json['page']),
      reviewStatus: $DocumentExtractionsTable.$converterreviewStatus.fromJson(
        serializer.fromJson<int>(json['reviewStatus']),
      ),
      quote: serializer.fromJson<String?>(json['quote']),
      origin: serializer.fromJson<String>(json['origin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'field': serializer.toJson<String>(field),
      'value': serializer.toJson<String>(value),
      'confidence': serializer.toJson<double>(confidence),
      'page': serializer.toJson<int?>(page),
      'reviewStatus': serializer.toJson<int>(
        $DocumentExtractionsTable.$converterreviewStatus.toJson(reviewStatus),
      ),
      'quote': serializer.toJson<String?>(quote),
      'origin': serializer.toJson<String>(origin),
    };
  }

  DocumentExtraction copyWith({
    String? id,
    String? documentId,
    String? field,
    String? value,
    double? confidence,
    Value<int?> page = const Value.absent(),
    ReviewStatus? reviewStatus,
    Value<String?> quote = const Value.absent(),
    String? origin,
  }) => DocumentExtraction(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    field: field ?? this.field,
    value: value ?? this.value,
    confidence: confidence ?? this.confidence,
    page: page.present ? page.value : this.page,
    reviewStatus: reviewStatus ?? this.reviewStatus,
    quote: quote.present ? quote.value : this.quote,
    origin: origin ?? this.origin,
  );
  DocumentExtraction copyWithCompanion(DocumentExtractionsCompanion data) {
    return DocumentExtraction(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      field: data.field.present ? data.field.value : this.field,
      value: data.value.present ? data.value.value : this.value,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      page: data.page.present ? data.page.value : this.page,
      reviewStatus: data.reviewStatus.present
          ? data.reviewStatus.value
          : this.reviewStatus,
      quote: data.quote.present ? data.quote.value : this.quote,
      origin: data.origin.present ? data.origin.value : this.origin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentExtraction(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('field: $field, ')
          ..write('value: $value, ')
          ..write('confidence: $confidence, ')
          ..write('page: $page, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('quote: $quote, ')
          ..write('origin: $origin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    field,
    value,
    confidence,
    page,
    reviewStatus,
    quote,
    origin,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentExtraction &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.field == this.field &&
          other.value == this.value &&
          other.confidence == this.confidence &&
          other.page == this.page &&
          other.reviewStatus == this.reviewStatus &&
          other.quote == this.quote &&
          other.origin == this.origin);
}

class DocumentExtractionsCompanion extends UpdateCompanion<DocumentExtraction> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<String> field;
  final Value<String> value;
  final Value<double> confidence;
  final Value<int?> page;
  final Value<ReviewStatus> reviewStatus;
  final Value<String?> quote;
  final Value<String> origin;
  final Value<int> rowid;
  const DocumentExtractionsCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.field = const Value.absent(),
    this.value = const Value.absent(),
    this.confidence = const Value.absent(),
    this.page = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.quote = const Value.absent(),
    this.origin = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentExtractionsCompanion.insert({
    required String id,
    required String documentId,
    required String field,
    required String value,
    required double confidence,
    this.page = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.quote = const Value.absent(),
    this.origin = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       field = Value(field),
       value = Value(value),
       confidence = Value(confidence);
  static Insertable<DocumentExtraction> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<String>? field,
    Expression<String>? value,
    Expression<double>? confidence,
    Expression<int>? page,
    Expression<int>? reviewStatus,
    Expression<String>? quote,
    Expression<String>? origin,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (field != null) 'field': field,
      if (value != null) 'value': value,
      if (confidence != null) 'confidence': confidence,
      if (page != null) 'page': page,
      if (reviewStatus != null) 'review_status': reviewStatus,
      if (quote != null) 'quote': quote,
      if (origin != null) 'origin': origin,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentExtractionsCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<String>? field,
    Value<String>? value,
    Value<double>? confidence,
    Value<int?>? page,
    Value<ReviewStatus>? reviewStatus,
    Value<String?>? quote,
    Value<String>? origin,
    Value<int>? rowid,
  }) {
    return DocumentExtractionsCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      field: field ?? this.field,
      value: value ?? this.value,
      confidence: confidence ?? this.confidence,
      page: page ?? this.page,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      quote: quote ?? this.quote,
      origin: origin ?? this.origin,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (field.present) {
      map['field'] = Variable<String>(field.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (reviewStatus.present) {
      map['review_status'] = Variable<int>(
        $DocumentExtractionsTable.$converterreviewStatus.toSql(
          reviewStatus.value,
        ),
      );
    }
    if (quote.present) {
      map['quote'] = Variable<String>(quote.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentExtractionsCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('field: $field, ')
          ..write('value: $value, ')
          ..write('confidence: $confidence, ')
          ..write('page: $page, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('quote: $quote, ')
          ..write('origin: $origin, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentChunksTable extends DocumentChunks
    with TableInfo<$DocumentChunksTable, DocumentChunk> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentChunksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id)',
    ),
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
    'page',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _embeddingMeta = const VerificationMeta(
    'embedding',
  );
  @override
  late final GeneratedColumn<Uint8List> embedding = GeneratedColumn<Uint8List>(
    'embedding',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentId,
    ordinal,
    body,
    page,
    embedding,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'document_chunks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentChunk> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('page')) {
      context.handle(
        _pageMeta,
        page.isAcceptableOrUnknown(data['page']!, _pageMeta),
      );
    }
    if (data.containsKey('embedding')) {
      context.handle(
        _embeddingMeta,
        embedding.isAcceptableOrUnknown(data['embedding']!, _embeddingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentChunk map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentChunk(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_id'],
      )!,
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      page: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page'],
      ),
      embedding: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}embedding'],
      ),
    );
  }

  @override
  $DocumentChunksTable createAlias(String alias) {
    return $DocumentChunksTable(attachedDatabase, alias);
  }
}

class DocumentChunk extends DataClass implements Insertable<DocumentChunk> {
  final String id;
  final String documentId;
  final int ordinal;
  final String body;
  final int? page;

  /// Float32 embedding as bytes; null for sensitive content, which is never embedded remotely.
  final Uint8List? embedding;
  const DocumentChunk({
    required this.id,
    required this.documentId,
    required this.ordinal,
    required this.body,
    this.page,
    this.embedding,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_id'] = Variable<String>(documentId);
    map['ordinal'] = Variable<int>(ordinal);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || page != null) {
      map['page'] = Variable<int>(page);
    }
    if (!nullToAbsent || embedding != null) {
      map['embedding'] = Variable<Uint8List>(embedding);
    }
    return map;
  }

  DocumentChunksCompanion toCompanion(bool nullToAbsent) {
    return DocumentChunksCompanion(
      id: Value(id),
      documentId: Value(documentId),
      ordinal: Value(ordinal),
      body: Value(body),
      page: page == null && nullToAbsent ? const Value.absent() : Value(page),
      embedding: embedding == null && nullToAbsent
          ? const Value.absent()
          : Value(embedding),
    );
  }

  factory DocumentChunk.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentChunk(
      id: serializer.fromJson<String>(json['id']),
      documentId: serializer.fromJson<String>(json['documentId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      body: serializer.fromJson<String>(json['body']),
      page: serializer.fromJson<int?>(json['page']),
      embedding: serializer.fromJson<Uint8List?>(json['embedding']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentId': serializer.toJson<String>(documentId),
      'ordinal': serializer.toJson<int>(ordinal),
      'body': serializer.toJson<String>(body),
      'page': serializer.toJson<int?>(page),
      'embedding': serializer.toJson<Uint8List?>(embedding),
    };
  }

  DocumentChunk copyWith({
    String? id,
    String? documentId,
    int? ordinal,
    String? body,
    Value<int?> page = const Value.absent(),
    Value<Uint8List?> embedding = const Value.absent(),
  }) => DocumentChunk(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    ordinal: ordinal ?? this.ordinal,
    body: body ?? this.body,
    page: page.present ? page.value : this.page,
    embedding: embedding.present ? embedding.value : this.embedding,
  );
  DocumentChunk copyWithCompanion(DocumentChunksCompanion data) {
    return DocumentChunk(
      id: data.id.present ? data.id.value : this.id,
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      body: data.body.present ? data.body.value : this.body,
      page: data.page.present ? data.page.value : this.page,
      embedding: data.embedding.present ? data.embedding.value : this.embedding,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentChunk(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('ordinal: $ordinal, ')
          ..write('body: $body, ')
          ..write('page: $page, ')
          ..write('embedding: $embedding')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    ordinal,
    body,
    page,
    $driftBlobEquality.hash(embedding),
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentChunk &&
          other.id == this.id &&
          other.documentId == this.documentId &&
          other.ordinal == this.ordinal &&
          other.body == this.body &&
          other.page == this.page &&
          $driftBlobEquality.equals(other.embedding, this.embedding));
}

class DocumentChunksCompanion extends UpdateCompanion<DocumentChunk> {
  final Value<String> id;
  final Value<String> documentId;
  final Value<int> ordinal;
  final Value<String> body;
  final Value<int?> page;
  final Value<Uint8List?> embedding;
  final Value<int> rowid;
  const DocumentChunksCompanion({
    this.id = const Value.absent(),
    this.documentId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.body = const Value.absent(),
    this.page = const Value.absent(),
    this.embedding = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentChunksCompanion.insert({
    required String id,
    required String documentId,
    required int ordinal,
    required String body,
    this.page = const Value.absent(),
    this.embedding = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentId = Value(documentId),
       ordinal = Value(ordinal),
       body = Value(body);
  static Insertable<DocumentChunk> custom({
    Expression<String>? id,
    Expression<String>? documentId,
    Expression<int>? ordinal,
    Expression<String>? body,
    Expression<int>? page,
    Expression<Uint8List>? embedding,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentId != null) 'document_id': documentId,
      if (ordinal != null) 'ordinal': ordinal,
      if (body != null) 'body': body,
      if (page != null) 'page': page,
      if (embedding != null) 'embedding': embedding,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentChunksCompanion copyWith({
    Value<String>? id,
    Value<String>? documentId,
    Value<int>? ordinal,
    Value<String>? body,
    Value<int?>? page,
    Value<Uint8List?>? embedding,
    Value<int>? rowid,
  }) {
    return DocumentChunksCompanion(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      ordinal: ordinal ?? this.ordinal,
      body: body ?? this.body,
      page: page ?? this.page,
      embedding: embedding ?? this.embedding,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (embedding.present) {
      map['embedding'] = Variable<Uint8List>(embedding.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentChunksCompanion(')
          ..write('id: $id, ')
          ..write('documentId: $documentId, ')
          ..write('ordinal: $ordinal, ')
          ..write('body: $body, ')
          ..write('page: $page, ')
          ..write('embedding: $embedding, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Source, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Source>($TasksTable.$convertersource);
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sensitivity, int> sensitivity =
      GeneratedColumn<int>(
        'sensitivity',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Sensitivity>($TasksTable.$convertersensitivity);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TaskStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<TaskStatus>($TasksTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<Priority, int> priority =
      GeneratedColumn<int>(
        'priority',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(1),
      ).withConverter<Priority>($TasksTable.$converterpriority);
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _recurrenceRuleMeta = const VerificationMeta(
    'recurrenceRule',
  );
  @override
  late final GeneratedColumn<String> recurrenceRule = GeneratedColumn<String>(
    'recurrence_rule',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectEntityIdMeta = const VerificationMeta(
    'projectEntityId',
  );
  @override
  late final GeneratedColumn<String> projectEntityId = GeneratedColumn<String>(
    'project_entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entities (id)',
    ),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    title,
    notes,
    status,
    priority,
    dueAt,
    allDay,
    recurrenceRule,
    projectEntityId,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    }
    if (data.containsKey('recurrence_rule')) {
      context.handle(
        _recurrenceRuleMeta,
        recurrenceRule.isAcceptableOrUnknown(
          data['recurrence_rule']!,
          _recurrenceRuleMeta,
        ),
      );
    }
    if (data.containsKey('project_entity_id')) {
      context.handle(
        _projectEntityIdMeta,
        projectEntityId.isAcceptableOrUnknown(
          data['project_entity_id']!,
          _projectEntityIdMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $TasksTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sensitivity: $TasksTable.$convertersensitivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sensitivity'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: $TasksTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      priority: $TasksTable.$converterpriority.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}priority'],
        )!,
      ),
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      )!,
      recurrenceRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_rule'],
      ),
      projectEntityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_entity_id'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Source, int, int> $convertersource =
      const EnumIndexConverter<Source>(Source.values);
  static JsonTypeConverter2<Sensitivity, int, int> $convertersensitivity =
      const EnumIndexConverter<Sensitivity>(Sensitivity.values);
  static JsonTypeConverter2<TaskStatus, int, int> $converterstatus =
      const EnumIndexConverter<TaskStatus>(TaskStatus.values);
  static JsonTypeConverter2<Priority, int, int> $converterpriority =
      const EnumIndexConverter<Priority>(Priority.values);
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final Source source;
  final String? sourceRef;
  final double confidence;
  final Sensitivity sensitivity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String title;
  final String? notes;
  final TaskStatus status;
  final Priority priority;
  final DateTime? dueAt;

  /// Schema v2: due on a date without a specific time.
  final bool allDay;
  final String? recurrenceRule;
  final String? projectEntityId;
  final DateTime? completedAt;
  const Task({
    required this.id,
    required this.source,
    this.sourceRef,
    required this.confidence,
    required this.sensitivity,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.title,
    this.notes,
    required this.status,
    required this.priority,
    this.dueAt,
    required this.allDay,
    this.recurrenceRule,
    this.projectEntityId,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<int>($TasksTable.$convertersource.toSql(source));
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['confidence'] = Variable<double>(confidence);
    {
      map['sensitivity'] = Variable<int>(
        $TasksTable.$convertersensitivity.toSql(sensitivity),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    {
      map['status'] = Variable<int>($TasksTable.$converterstatus.toSql(status));
    }
    {
      map['priority'] = Variable<int>(
        $TasksTable.$converterpriority.toSql(priority),
      );
    }
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    map['all_day'] = Variable<bool>(allDay);
    if (!nullToAbsent || recurrenceRule != null) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule);
    }
    if (!nullToAbsent || projectEntityId != null) {
      map['project_entity_id'] = Variable<String>(projectEntityId);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      confidence: Value(confidence),
      sensitivity: Value(sensitivity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      title: Value(title),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      priority: Value(priority),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      allDay: Value(allDay),
      recurrenceRule: recurrenceRule == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceRule),
      projectEntityId: projectEntityId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectEntityId),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      source: $TasksTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sensitivity: $TasksTable.$convertersensitivity.fromJson(
        serializer.fromJson<int>(json['sensitivity']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: $TasksTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      priority: $TasksTable.$converterpriority.fromJson(
        serializer.fromJson<int>(json['priority']),
      ),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      allDay: serializer.fromJson<bool>(json['allDay']),
      recurrenceRule: serializer.fromJson<String?>(json['recurrenceRule']),
      projectEntityId: serializer.fromJson<String?>(json['projectEntityId']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<int>(
        $TasksTable.$convertersource.toJson(source),
      ),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'confidence': serializer.toJson<double>(confidence),
      'sensitivity': serializer.toJson<int>(
        $TasksTable.$convertersensitivity.toJson(sensitivity),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<int>(
        $TasksTable.$converterstatus.toJson(status),
      ),
      'priority': serializer.toJson<int>(
        $TasksTable.$converterpriority.toJson(priority),
      ),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'allDay': serializer.toJson<bool>(allDay),
      'recurrenceRule': serializer.toJson<String?>(recurrenceRule),
      'projectEntityId': serializer.toJson<String?>(projectEntityId),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Task copyWith({
    String? id,
    Source? source,
    Value<String?> sourceRef = const Value.absent(),
    double? confidence,
    Sensitivity? sensitivity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? title,
    Value<String?> notes = const Value.absent(),
    TaskStatus? status,
    Priority? priority,
    Value<DateTime?> dueAt = const Value.absent(),
    bool? allDay,
    Value<String?> recurrenceRule = const Value.absent(),
    Value<String?> projectEntityId = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
  }) => Task(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    confidence: confidence ?? this.confidence,
    sensitivity: sensitivity ?? this.sensitivity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    title: title ?? this.title,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    allDay: allDay ?? this.allDay,
    recurrenceRule: recurrenceRule.present
        ? recurrenceRule.value
        : this.recurrenceRule,
    projectEntityId: projectEntityId.present
        ? projectEntityId.value
        : this.projectEntityId,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sensitivity: data.sensitivity.present
          ? data.sensitivity.value
          : this.sensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      recurrenceRule: data.recurrenceRule.present
          ? data.recurrenceRule.value
          : this.recurrenceRule,
      projectEntityId: data.projectEntityId.present
          ? data.projectEntityId.value
          : this.projectEntityId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('dueAt: $dueAt, ')
          ..write('allDay: $allDay, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('projectEntityId: $projectEntityId, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    title,
    notes,
    status,
    priority,
    dueAt,
    allDay,
    recurrenceRule,
    projectEntityId,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.confidence == this.confidence &&
          other.sensitivity == this.sensitivity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.dueAt == this.dueAt &&
          other.allDay == this.allDay &&
          other.recurrenceRule == this.recurrenceRule &&
          other.projectEntityId == this.projectEntityId &&
          other.completedAt == this.completedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<Source> source;
  final Value<String?> sourceRef;
  final Value<double> confidence;
  final Value<Sensitivity> sensitivity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> title;
  final Value<String?> notes;
  final Value<TaskStatus> status;
  final Value<Priority> priority;
  final Value<DateTime?> dueAt;
  final Value<bool> allDay;
  final Value<String?> recurrenceRule;
  final Value<String?> projectEntityId;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.allDay = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.projectEntityId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required Source source,
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    required String title,
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.allDay = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.projectEntityId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       title = Value(title);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<int>? source,
    Expression<String>? sourceRef,
    Expression<double>? confidence,
    Expression<int>? sensitivity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<int>? status,
    Expression<int>? priority,
    Expression<DateTime>? dueAt,
    Expression<bool>? allDay,
    Expression<String>? recurrenceRule,
    Expression<String>? projectEntityId,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (confidence != null) 'confidence': confidence,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (dueAt != null) 'due_at': dueAt,
      if (allDay != null) 'all_day': allDay,
      if (recurrenceRule != null) 'recurrence_rule': recurrenceRule,
      if (projectEntityId != null) 'project_entity_id': projectEntityId,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<Source>? source,
    Value<String?>? sourceRef,
    Value<double>? confidence,
    Value<Sensitivity>? sensitivity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? title,
    Value<String?>? notes,
    Value<TaskStatus>? status,
    Value<Priority>? priority,
    Value<DateTime?>? dueAt,
    Value<bool>? allDay,
    Value<String?>? recurrenceRule,
    Value<String?>? projectEntityId,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      confidence: confidence ?? this.confidence,
      sensitivity: sensitivity ?? this.sensitivity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      dueAt: dueAt ?? this.dueAt,
      allDay: allDay ?? this.allDay,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      projectEntityId: projectEntityId ?? this.projectEntityId,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $TasksTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int>(
        $TasksTable.$convertersensitivity.toSql(sensitivity.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $TasksTable.$converterstatus.toSql(status.value),
      );
    }
    if (priority.present) {
      map['priority'] = Variable<int>(
        $TasksTable.$converterpriority.toSql(priority.value),
      );
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (recurrenceRule.present) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule.value);
    }
    if (projectEntityId.present) {
      map['project_entity_id'] = Variable<String>(projectEntityId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('dueAt: $dueAt, ')
          ..write('allDay: $allDay, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('projectEntityId: $projectEntityId, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Source, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Source>($EventsTable.$convertersource);
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sensitivity, int> sensitivity =
      GeneratedColumn<int>(
        'sensitivity',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Sensitivity>($EventsTable.$convertersensitivity);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startsAtMeta = const VerificationMeta(
    'startsAt',
  );
  @override
  late final GeneratedColumn<DateTime> startsAt = GeneratedColumn<DateTime>(
    'starts_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endsAtMeta = const VerificationMeta('endsAt');
  @override
  late final GeneratedColumn<DateTime> endsAt = GeneratedColumn<DateTime>(
    'ends_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurrenceRuleMeta = const VerificationMeta(
    'recurrenceRule',
  );
  @override
  late final GeneratedColumn<String> recurrenceRule = GeneratedColumn<String>(
    'recurrence_rule',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _externalRefMeta = const VerificationMeta(
    'externalRef',
  );
  @override
  late final GeneratedColumn<String> externalRef = GeneratedColumn<String>(
    'external_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    title,
    startsAt,
    endsAt,
    location,
    recurrenceRule,
    externalRef,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('starts_at')) {
      context.handle(
        _startsAtMeta,
        startsAt.isAcceptableOrUnknown(data['starts_at']!, _startsAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startsAtMeta);
    }
    if (data.containsKey('ends_at')) {
      context.handle(
        _endsAtMeta,
        endsAt.isAcceptableOrUnknown(data['ends_at']!, _endsAtMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('recurrence_rule')) {
      context.handle(
        _recurrenceRuleMeta,
        recurrenceRule.isAcceptableOrUnknown(
          data['recurrence_rule']!,
          _recurrenceRuleMeta,
        ),
      );
    }
    if (data.containsKey('external_ref')) {
      context.handle(
        _externalRefMeta,
        externalRef.isAcceptableOrUnknown(
          data['external_ref']!,
          _externalRefMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $EventsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sensitivity: $EventsTable.$convertersensitivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sensitivity'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}starts_at'],
      )!,
      endsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ends_at'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      recurrenceRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_rule'],
      ),
      externalRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_ref'],
      ),
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Source, int, int> $convertersource =
      const EnumIndexConverter<Source>(Source.values);
  static JsonTypeConverter2<Sensitivity, int, int> $convertersensitivity =
      const EnumIndexConverter<Sensitivity>(Sensitivity.values);
}

class Event extends DataClass implements Insertable<Event> {
  final String id;
  final Source source;
  final String? sourceRef;
  final double confidence;
  final Sensitivity sensitivity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String title;
  final DateTime startsAt;
  final DateTime? endsAt;
  final String? location;
  final String? recurrenceRule;
  final String? externalRef;
  const Event({
    required this.id,
    required this.source,
    this.sourceRef,
    required this.confidence,
    required this.sensitivity,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.title,
    required this.startsAt,
    this.endsAt,
    this.location,
    this.recurrenceRule,
    this.externalRef,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<int>(
        $EventsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['confidence'] = Variable<double>(confidence);
    {
      map['sensitivity'] = Variable<int>(
        $EventsTable.$convertersensitivity.toSql(sensitivity),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['title'] = Variable<String>(title);
    map['starts_at'] = Variable<DateTime>(startsAt);
    if (!nullToAbsent || endsAt != null) {
      map['ends_at'] = Variable<DateTime>(endsAt);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || recurrenceRule != null) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule);
    }
    if (!nullToAbsent || externalRef != null) {
      map['external_ref'] = Variable<String>(externalRef);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      confidence: Value(confidence),
      sensitivity: Value(sensitivity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      title: Value(title),
      startsAt: Value(startsAt),
      endsAt: endsAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endsAt),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      recurrenceRule: recurrenceRule == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceRule),
      externalRef: externalRef == null && nullToAbsent
          ? const Value.absent()
          : Value(externalRef),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<String>(json['id']),
      source: $EventsTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sensitivity: $EventsTable.$convertersensitivity.fromJson(
        serializer.fromJson<int>(json['sensitivity']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      title: serializer.fromJson<String>(json['title']),
      startsAt: serializer.fromJson<DateTime>(json['startsAt']),
      endsAt: serializer.fromJson<DateTime?>(json['endsAt']),
      location: serializer.fromJson<String?>(json['location']),
      recurrenceRule: serializer.fromJson<String?>(json['recurrenceRule']),
      externalRef: serializer.fromJson<String?>(json['externalRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<int>(
        $EventsTable.$convertersource.toJson(source),
      ),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'confidence': serializer.toJson<double>(confidence),
      'sensitivity': serializer.toJson<int>(
        $EventsTable.$convertersensitivity.toJson(sensitivity),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'title': serializer.toJson<String>(title),
      'startsAt': serializer.toJson<DateTime>(startsAt),
      'endsAt': serializer.toJson<DateTime?>(endsAt),
      'location': serializer.toJson<String?>(location),
      'recurrenceRule': serializer.toJson<String?>(recurrenceRule),
      'externalRef': serializer.toJson<String?>(externalRef),
    };
  }

  Event copyWith({
    String? id,
    Source? source,
    Value<String?> sourceRef = const Value.absent(),
    double? confidence,
    Sensitivity? sensitivity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? title,
    DateTime? startsAt,
    Value<DateTime?> endsAt = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<String?> recurrenceRule = const Value.absent(),
    Value<String?> externalRef = const Value.absent(),
  }) => Event(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    confidence: confidence ?? this.confidence,
    sensitivity: sensitivity ?? this.sensitivity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    title: title ?? this.title,
    startsAt: startsAt ?? this.startsAt,
    endsAt: endsAt.present ? endsAt.value : this.endsAt,
    location: location.present ? location.value : this.location,
    recurrenceRule: recurrenceRule.present
        ? recurrenceRule.value
        : this.recurrenceRule,
    externalRef: externalRef.present ? externalRef.value : this.externalRef,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sensitivity: data.sensitivity.present
          ? data.sensitivity.value
          : this.sensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      title: data.title.present ? data.title.value : this.title,
      startsAt: data.startsAt.present ? data.startsAt.value : this.startsAt,
      endsAt: data.endsAt.present ? data.endsAt.value : this.endsAt,
      location: data.location.present ? data.location.value : this.location,
      recurrenceRule: data.recurrenceRule.present
          ? data.recurrenceRule.value
          : this.recurrenceRule,
      externalRef: data.externalRef.present
          ? data.externalRef.value
          : this.externalRef,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('location: $location, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('externalRef: $externalRef')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    title,
    startsAt,
    endsAt,
    location,
    recurrenceRule,
    externalRef,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.confidence == this.confidence &&
          other.sensitivity == this.sensitivity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.title == this.title &&
          other.startsAt == this.startsAt &&
          other.endsAt == this.endsAt &&
          other.location == this.location &&
          other.recurrenceRule == this.recurrenceRule &&
          other.externalRef == this.externalRef);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<String> id;
  final Value<Source> source;
  final Value<String?> sourceRef;
  final Value<double> confidence;
  final Value<Sensitivity> sensitivity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> title;
  final Value<DateTime> startsAt;
  final Value<DateTime?> endsAt;
  final Value<String?> location;
  final Value<String?> recurrenceRule;
  final Value<String?> externalRef;
  final Value<int> rowid;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.startsAt = const Value.absent(),
    this.endsAt = const Value.absent(),
    this.location = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.externalRef = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    required Source source,
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    required String title,
    required DateTime startsAt,
    this.endsAt = const Value.absent(),
    this.location = const Value.absent(),
    this.recurrenceRule = const Value.absent(),
    this.externalRef = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       title = Value(title),
       startsAt = Value(startsAt);
  static Insertable<Event> custom({
    Expression<String>? id,
    Expression<int>? source,
    Expression<String>? sourceRef,
    Expression<double>? confidence,
    Expression<int>? sensitivity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? title,
    Expression<DateTime>? startsAt,
    Expression<DateTime>? endsAt,
    Expression<String>? location,
    Expression<String>? recurrenceRule,
    Expression<String>? externalRef,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (confidence != null) 'confidence': confidence,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (title != null) 'title': title,
      if (startsAt != null) 'starts_at': startsAt,
      if (endsAt != null) 'ends_at': endsAt,
      if (location != null) 'location': location,
      if (recurrenceRule != null) 'recurrence_rule': recurrenceRule,
      if (externalRef != null) 'external_ref': externalRef,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith({
    Value<String>? id,
    Value<Source>? source,
    Value<String?>? sourceRef,
    Value<double>? confidence,
    Value<Sensitivity>? sensitivity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? title,
    Value<DateTime>? startsAt,
    Value<DateTime?>? endsAt,
    Value<String?>? location,
    Value<String?>? recurrenceRule,
    Value<String?>? externalRef,
    Value<int>? rowid,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      confidence: confidence ?? this.confidence,
      sensitivity: sensitivity ?? this.sensitivity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      location: location ?? this.location,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      externalRef: externalRef ?? this.externalRef,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $EventsTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int>(
        $EventsTable.$convertersensitivity.toSql(sensitivity.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startsAt.present) {
      map['starts_at'] = Variable<DateTime>(startsAt.value);
    }
    if (endsAt.present) {
      map['ends_at'] = Variable<DateTime>(endsAt.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (recurrenceRule.present) {
      map['recurrence_rule'] = Variable<String>(recurrenceRule.value);
    }
    if (externalRef.present) {
      map['external_ref'] = Variable<String>(externalRef.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('location: $location, ')
          ..write('recurrenceRule: $recurrenceRule, ')
          ..write('externalRef: $externalRef, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Source, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Source>($RemindersTable.$convertersource);
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sensitivity, int> sensitivity =
      GeneratedColumn<int>(
        'sensitivity',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Sensitivity>($RemindersTable.$convertersensitivity);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fireAtMeta = const VerificationMeta('fireAt');
  @override
  late final GeneratedColumn<DateTime> fireAt = GeneratedColumn<DateTime>(
    'fire_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetIdMeta = const VerificationMeta(
    'targetId',
  );
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
    'target_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('scheduled'),
  );
  static const VerificationMeta _snoozedUntilMeta = const VerificationMeta(
    'snoozedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> snoozedUntil = GeneratedColumn<DateTime>(
    'snoozed_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    title,
    fireAt,
    targetId,
    status,
    snoozedUntil,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('fire_at')) {
      context.handle(
        _fireAtMeta,
        fireAt.isAcceptableOrUnknown(data['fire_at']!, _fireAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fireAtMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(
        _targetIdMeta,
        targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('snoozed_until')) {
      context.handle(
        _snoozedUntilMeta,
        snoozedUntil.isAcceptableOrUnknown(
          data['snoozed_until']!,
          _snoozedUntilMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $RemindersTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sensitivity: $RemindersTable.$convertersensitivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sensitivity'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      fireAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fire_at'],
      )!,
      targetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      snoozedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}snoozed_until'],
      ),
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Source, int, int> $convertersource =
      const EnumIndexConverter<Source>(Source.values);
  static JsonTypeConverter2<Sensitivity, int, int> $convertersensitivity =
      const EnumIndexConverter<Sensitivity>(Sensitivity.values);
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final String id;
  final Source source;
  final String? sourceRef;
  final double confidence;
  final Sensitivity sensitivity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String title;
  final DateTime fireAt;

  /// Id of the linked task/event/document/memory/entity, if any.
  final String? targetId;
  final String status;
  final DateTime? snoozedUntil;
  const Reminder({
    required this.id,
    required this.source,
    this.sourceRef,
    required this.confidence,
    required this.sensitivity,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.title,
    required this.fireAt,
    this.targetId,
    required this.status,
    this.snoozedUntil,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<int>(
        $RemindersTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['confidence'] = Variable<double>(confidence);
    {
      map['sensitivity'] = Variable<int>(
        $RemindersTable.$convertersensitivity.toSql(sensitivity),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['title'] = Variable<String>(title);
    map['fire_at'] = Variable<DateTime>(fireAt);
    if (!nullToAbsent || targetId != null) {
      map['target_id'] = Variable<String>(targetId);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || snoozedUntil != null) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil);
    }
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      confidence: Value(confidence),
      sensitivity: Value(sensitivity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      title: Value(title),
      fireAt: Value(fireAt),
      targetId: targetId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetId),
      status: Value(status),
      snoozedUntil: snoozedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozedUntil),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      source: $RemindersTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sensitivity: $RemindersTable.$convertersensitivity.fromJson(
        serializer.fromJson<int>(json['sensitivity']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      title: serializer.fromJson<String>(json['title']),
      fireAt: serializer.fromJson<DateTime>(json['fireAt']),
      targetId: serializer.fromJson<String?>(json['targetId']),
      status: serializer.fromJson<String>(json['status']),
      snoozedUntil: serializer.fromJson<DateTime?>(json['snoozedUntil']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<int>(
        $RemindersTable.$convertersource.toJson(source),
      ),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'confidence': serializer.toJson<double>(confidence),
      'sensitivity': serializer.toJson<int>(
        $RemindersTable.$convertersensitivity.toJson(sensitivity),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'title': serializer.toJson<String>(title),
      'fireAt': serializer.toJson<DateTime>(fireAt),
      'targetId': serializer.toJson<String?>(targetId),
      'status': serializer.toJson<String>(status),
      'snoozedUntil': serializer.toJson<DateTime?>(snoozedUntil),
    };
  }

  Reminder copyWith({
    String? id,
    Source? source,
    Value<String?> sourceRef = const Value.absent(),
    double? confidence,
    Sensitivity? sensitivity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? title,
    DateTime? fireAt,
    Value<String?> targetId = const Value.absent(),
    String? status,
    Value<DateTime?> snoozedUntil = const Value.absent(),
  }) => Reminder(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    confidence: confidence ?? this.confidence,
    sensitivity: sensitivity ?? this.sensitivity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    title: title ?? this.title,
    fireAt: fireAt ?? this.fireAt,
    targetId: targetId.present ? targetId.value : this.targetId,
    status: status ?? this.status,
    snoozedUntil: snoozedUntil.present ? snoozedUntil.value : this.snoozedUntil,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sensitivity: data.sensitivity.present
          ? data.sensitivity.value
          : this.sensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      title: data.title.present ? data.title.value : this.title,
      fireAt: data.fireAt.present ? data.fireAt.value : this.fireAt,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      status: data.status.present ? data.status.value : this.status,
      snoozedUntil: data.snoozedUntil.present
          ? data.snoozedUntil.value
          : this.snoozedUntil,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('fireAt: $fireAt, ')
          ..write('targetId: $targetId, ')
          ..write('status: $status, ')
          ..write('snoozedUntil: $snoozedUntil')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    title,
    fireAt,
    targetId,
    status,
    snoozedUntil,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.confidence == this.confidence &&
          other.sensitivity == this.sensitivity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.title == this.title &&
          other.fireAt == this.fireAt &&
          other.targetId == this.targetId &&
          other.status == this.status &&
          other.snoozedUntil == this.snoozedUntil);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<Source> source;
  final Value<String?> sourceRef;
  final Value<double> confidence;
  final Value<Sensitivity> sensitivity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> title;
  final Value<DateTime> fireAt;
  final Value<String?> targetId;
  final Value<String> status;
  final Value<DateTime?> snoozedUntil;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.fireAt = const Value.absent(),
    this.targetId = const Value.absent(),
    this.status = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required Source source,
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    required String title,
    required DateTime fireAt,
    this.targetId = const Value.absent(),
    this.status = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       title = Value(title),
       fireAt = Value(fireAt);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<int>? source,
    Expression<String>? sourceRef,
    Expression<double>? confidence,
    Expression<int>? sensitivity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? title,
    Expression<DateTime>? fireAt,
    Expression<String>? targetId,
    Expression<String>? status,
    Expression<DateTime>? snoozedUntil,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (confidence != null) 'confidence': confidence,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (title != null) 'title': title,
      if (fireAt != null) 'fire_at': fireAt,
      if (targetId != null) 'target_id': targetId,
      if (status != null) 'status': status,
      if (snoozedUntil != null) 'snoozed_until': snoozedUntil,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<Source>? source,
    Value<String?>? sourceRef,
    Value<double>? confidence,
    Value<Sensitivity>? sensitivity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? title,
    Value<DateTime>? fireAt,
    Value<String?>? targetId,
    Value<String>? status,
    Value<DateTime?>? snoozedUntil,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      confidence: confidence ?? this.confidence,
      sensitivity: sensitivity ?? this.sensitivity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
      fireAt: fireAt ?? this.fireAt,
      targetId: targetId ?? this.targetId,
      status: status ?? this.status,
      snoozedUntil: snoozedUntil ?? this.snoozedUntil,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $RemindersTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int>(
        $RemindersTable.$convertersensitivity.toSql(sensitivity.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (fireAt.present) {
      map['fire_at'] = Variable<DateTime>(fireAt.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (snoozedUntil.present) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('title: $title, ')
          ..write('fireAt: $fireAt, ')
          ..write('targetId: $targetId, ')
          ..write('status: $status, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommitmentsTable extends Commitments
    with TableInfo<$CommitmentsTable, Commitment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommitmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Source, int> source =
      GeneratedColumn<int>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Source>($CommitmentsTable.$convertersource);
  static const VerificationMeta _sourceRefMeta = const VerificationMeta(
    'sourceRef',
  );
  @override
  late final GeneratedColumn<String> sourceRef = GeneratedColumn<String>(
    'source_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sensitivity, int> sensitivity =
      GeneratedColumn<int>(
        'sensitivity',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<Sensitivity>($CommitmentsTable.$convertersensitivity);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _counterpartyMeta = const VerificationMeta(
    'counterparty',
  );
  @override
  late final GeneratedColumn<String> counterparty = GeneratedColumn<String>(
    'counterparty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('open'),
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tasks (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    description,
    counterparty,
    dueAt,
    status,
    taskId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commitments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Commitment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_ref')) {
      context.handle(
        _sourceRefMeta,
        sourceRef.isAcceptableOrUnknown(data['source_ref']!, _sourceRefMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('counterparty')) {
      context.handle(
        _counterpartyMeta,
        counterparty.isAcceptableOrUnknown(
          data['counterparty']!,
          _counterpartyMeta,
        ),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Commitment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Commitment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $CommitmentsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_ref'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sensitivity: $CommitmentsTable.$convertersensitivity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sensitivity'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      counterparty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}counterparty'],
      ),
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      ),
    );
  }

  @override
  $CommitmentsTable createAlias(String alias) {
    return $CommitmentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Source, int, int> $convertersource =
      const EnumIndexConverter<Source>(Source.values);
  static JsonTypeConverter2<Sensitivity, int, int> $convertersensitivity =
      const EnumIndexConverter<Sensitivity>(Sensitivity.values);
}

class Commitment extends DataClass implements Insertable<Commitment> {
  final String id;
  final Source source;
  final String? sourceRef;
  final double confidence;
  final Sensitivity sensitivity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String description;
  final String? counterparty;
  final DateTime? dueAt;
  final String status;
  final String? taskId;
  const Commitment({
    required this.id,
    required this.source,
    this.sourceRef,
    required this.confidence,
    required this.sensitivity,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.description,
    this.counterparty,
    this.dueAt,
    required this.status,
    this.taskId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<int>(
        $CommitmentsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceRef != null) {
      map['source_ref'] = Variable<String>(sourceRef);
    }
    map['confidence'] = Variable<double>(confidence);
    {
      map['sensitivity'] = Variable<int>(
        $CommitmentsTable.$convertersensitivity.toSql(sensitivity),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || counterparty != null) {
      map['counterparty'] = Variable<String>(counterparty);
    }
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    return map;
  }

  CommitmentsCompanion toCompanion(bool nullToAbsent) {
    return CommitmentsCompanion(
      id: Value(id),
      source: Value(source),
      sourceRef: sourceRef == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRef),
      confidence: Value(confidence),
      sensitivity: Value(sensitivity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      description: Value(description),
      counterparty: counterparty == null && nullToAbsent
          ? const Value.absent()
          : Value(counterparty),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      status: Value(status),
      taskId: taskId == null && nullToAbsent
          ? const Value.absent()
          : Value(taskId),
    );
  }

  factory Commitment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Commitment(
      id: serializer.fromJson<String>(json['id']),
      source: $CommitmentsTable.$convertersource.fromJson(
        serializer.fromJson<int>(json['source']),
      ),
      sourceRef: serializer.fromJson<String?>(json['sourceRef']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sensitivity: $CommitmentsTable.$convertersensitivity.fromJson(
        serializer.fromJson<int>(json['sensitivity']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      description: serializer.fromJson<String>(json['description']),
      counterparty: serializer.fromJson<String?>(json['counterparty']),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      status: serializer.fromJson<String>(json['status']),
      taskId: serializer.fromJson<String?>(json['taskId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<int>(
        $CommitmentsTable.$convertersource.toJson(source),
      ),
      'sourceRef': serializer.toJson<String?>(sourceRef),
      'confidence': serializer.toJson<double>(confidence),
      'sensitivity': serializer.toJson<int>(
        $CommitmentsTable.$convertersensitivity.toJson(sensitivity),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'description': serializer.toJson<String>(description),
      'counterparty': serializer.toJson<String?>(counterparty),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'status': serializer.toJson<String>(status),
      'taskId': serializer.toJson<String?>(taskId),
    };
  }

  Commitment copyWith({
    String? id,
    Source? source,
    Value<String?> sourceRef = const Value.absent(),
    double? confidence,
    Sensitivity? sensitivity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? description,
    Value<String?> counterparty = const Value.absent(),
    Value<DateTime?> dueAt = const Value.absent(),
    String? status,
    Value<String?> taskId = const Value.absent(),
  }) => Commitment(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceRef: sourceRef.present ? sourceRef.value : this.sourceRef,
    confidence: confidence ?? this.confidence,
    sensitivity: sensitivity ?? this.sensitivity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    description: description ?? this.description,
    counterparty: counterparty.present ? counterparty.value : this.counterparty,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    status: status ?? this.status,
    taskId: taskId.present ? taskId.value : this.taskId,
  );
  Commitment copyWithCompanion(CommitmentsCompanion data) {
    return Commitment(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceRef: data.sourceRef.present ? data.sourceRef.value : this.sourceRef,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sensitivity: data.sensitivity.present
          ? data.sensitivity.value
          : this.sensitivity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      description: data.description.present
          ? data.description.value
          : this.description,
      counterparty: data.counterparty.present
          ? data.counterparty.value
          : this.counterparty,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      status: data.status.present ? data.status.value : this.status,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Commitment(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('description: $description, ')
          ..write('counterparty: $counterparty, ')
          ..write('dueAt: $dueAt, ')
          ..write('status: $status, ')
          ..write('taskId: $taskId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    sourceRef,
    confidence,
    sensitivity,
    createdAt,
    updatedAt,
    deletedAt,
    description,
    counterparty,
    dueAt,
    status,
    taskId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Commitment &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceRef == this.sourceRef &&
          other.confidence == this.confidence &&
          other.sensitivity == this.sensitivity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.description == this.description &&
          other.counterparty == this.counterparty &&
          other.dueAt == this.dueAt &&
          other.status == this.status &&
          other.taskId == this.taskId);
}

class CommitmentsCompanion extends UpdateCompanion<Commitment> {
  final Value<String> id;
  final Value<Source> source;
  final Value<String?> sourceRef;
  final Value<double> confidence;
  final Value<Sensitivity> sensitivity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> description;
  final Value<String?> counterparty;
  final Value<DateTime?> dueAt;
  final Value<String> status;
  final Value<String?> taskId;
  final Value<int> rowid;
  const CommitmentsCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.description = const Value.absent(),
    this.counterparty = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.status = const Value.absent(),
    this.taskId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommitmentsCompanion.insert({
    required String id,
    required Source source,
    this.sourceRef = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sensitivity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    required String description,
    this.counterparty = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.status = const Value.absent(),
    this.taskId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       description = Value(description);
  static Insertable<Commitment> custom({
    Expression<String>? id,
    Expression<int>? source,
    Expression<String>? sourceRef,
    Expression<double>? confidence,
    Expression<int>? sensitivity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? description,
    Expression<String>? counterparty,
    Expression<DateTime>? dueAt,
    Expression<String>? status,
    Expression<String>? taskId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceRef != null) 'source_ref': sourceRef,
      if (confidence != null) 'confidence': confidence,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (description != null) 'description': description,
      if (counterparty != null) 'counterparty': counterparty,
      if (dueAt != null) 'due_at': dueAt,
      if (status != null) 'status': status,
      if (taskId != null) 'task_id': taskId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommitmentsCompanion copyWith({
    Value<String>? id,
    Value<Source>? source,
    Value<String?>? sourceRef,
    Value<double>? confidence,
    Value<Sensitivity>? sensitivity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? description,
    Value<String?>? counterparty,
    Value<DateTime?>? dueAt,
    Value<String>? status,
    Value<String?>? taskId,
    Value<int>? rowid,
  }) {
    return CommitmentsCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceRef: sourceRef ?? this.sourceRef,
      confidence: confidence ?? this.confidence,
      sensitivity: sensitivity ?? this.sensitivity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      description: description ?? this.description,
      counterparty: counterparty ?? this.counterparty,
      dueAt: dueAt ?? this.dueAt,
      status: status ?? this.status,
      taskId: taskId ?? this.taskId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<int>(
        $CommitmentsTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceRef.present) {
      map['source_ref'] = Variable<String>(sourceRef.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<int>(
        $CommitmentsTable.$convertersensitivity.toSql(sensitivity.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (counterparty.present) {
      map['counterparty'] = Variable<String>(counterparty.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommitmentsCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceRef: $sourceRef, ')
          ..write('confidence: $confidence, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('description: $description, ')
          ..write('counterparty: $counterparty, ')
          ..write('dueAt: $dueAt, ')
          ..write('status: $status, ')
          ..write('taskId: $taskId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PermissionsTable extends Permissions
    with TableInfo<$PermissionsTable, PermissionGrantRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PermissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _capabilityMeta = const VerificationMeta(
    'capability',
  );
  @override
  late final GeneratedColumn<String> capability = GeneratedColumn<String>(
    'capability',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grantedMeta = const VerificationMeta(
    'granted',
  );
  @override
  late final GeneratedColumn<bool> granted = GeneratedColumn<bool>(
    'granted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("granted" IN (0, 1))',
    ),
  );
  static const VerificationMeta _autonomousMeta = const VerificationMeta(
    'autonomous',
  );
  @override
  late final GeneratedColumn<bool> autonomous = GeneratedColumn<bool>(
    'autonomous',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("autonomous" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _grantedViaMeta = const VerificationMeta(
    'grantedVia',
  );
  @override
  late final GeneratedColumn<String> grantedVia = GeneratedColumn<String>(
    'granted_via',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grantedAtMeta = const VerificationMeta(
    'grantedAt',
  );
  @override
  late final GeneratedColumn<DateTime> grantedAt = GeneratedColumn<DateTime>(
    'granted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    capability,
    granted,
    autonomous,
    scope,
    grantedVia,
    grantedAt,
    expiresAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'permissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PermissionGrantRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('capability')) {
      context.handle(
        _capabilityMeta,
        capability.isAcceptableOrUnknown(data['capability']!, _capabilityMeta),
      );
    } else if (isInserting) {
      context.missing(_capabilityMeta);
    }
    if (data.containsKey('granted')) {
      context.handle(
        _grantedMeta,
        granted.isAcceptableOrUnknown(data['granted']!, _grantedMeta),
      );
    } else if (isInserting) {
      context.missing(_grantedMeta);
    }
    if (data.containsKey('autonomous')) {
      context.handle(
        _autonomousMeta,
        autonomous.isAcceptableOrUnknown(data['autonomous']!, _autonomousMeta),
      );
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    }
    if (data.containsKey('granted_via')) {
      context.handle(
        _grantedViaMeta,
        grantedVia.isAcceptableOrUnknown(data['granted_via']!, _grantedViaMeta),
      );
    } else if (isInserting) {
      context.missing(_grantedViaMeta);
    }
    if (data.containsKey('granted_at')) {
      context.handle(
        _grantedAtMeta,
        grantedAt.isAcceptableOrUnknown(data['granted_at']!, _grantedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_grantedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {capability};
  @override
  PermissionGrantRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PermissionGrantRow(
      capability: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}capability'],
      )!,
      granted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}granted'],
      )!,
      autonomous: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}autonomous'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      grantedVia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}granted_via'],
      )!,
      grantedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}granted_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
    );
  }

  @override
  $PermissionsTable createAlias(String alias) {
    return $PermissionsTable(attachedDatabase, alias);
  }
}

class PermissionGrantRow extends DataClass
    implements Insertable<PermissionGrantRow> {
  final String capability;
  final bool granted;

  /// When true, low/medium-risk commits under this capability run without a
  /// per-action approval. Ignored for high-risk capabilities.
  final bool autonomous;
  final String scope;
  final String grantedVia;
  final DateTime grantedAt;
  final DateTime? expiresAt;
  const PermissionGrantRow({
    required this.capability,
    required this.granted,
    required this.autonomous,
    required this.scope,
    required this.grantedVia,
    required this.grantedAt,
    this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['capability'] = Variable<String>(capability);
    map['granted'] = Variable<bool>(granted);
    map['autonomous'] = Variable<bool>(autonomous);
    map['scope'] = Variable<String>(scope);
    map['granted_via'] = Variable<String>(grantedVia);
    map['granted_at'] = Variable<DateTime>(grantedAt);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    return map;
  }

  PermissionsCompanion toCompanion(bool nullToAbsent) {
    return PermissionsCompanion(
      capability: Value(capability),
      granted: Value(granted),
      autonomous: Value(autonomous),
      scope: Value(scope),
      grantedVia: Value(grantedVia),
      grantedAt: Value(grantedAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
    );
  }

  factory PermissionGrantRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PermissionGrantRow(
      capability: serializer.fromJson<String>(json['capability']),
      granted: serializer.fromJson<bool>(json['granted']),
      autonomous: serializer.fromJson<bool>(json['autonomous']),
      scope: serializer.fromJson<String>(json['scope']),
      grantedVia: serializer.fromJson<String>(json['grantedVia']),
      grantedAt: serializer.fromJson<DateTime>(json['grantedAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'capability': serializer.toJson<String>(capability),
      'granted': serializer.toJson<bool>(granted),
      'autonomous': serializer.toJson<bool>(autonomous),
      'scope': serializer.toJson<String>(scope),
      'grantedVia': serializer.toJson<String>(grantedVia),
      'grantedAt': serializer.toJson<DateTime>(grantedAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
    };
  }

  PermissionGrantRow copyWith({
    String? capability,
    bool? granted,
    bool? autonomous,
    String? scope,
    String? grantedVia,
    DateTime? grantedAt,
    Value<DateTime?> expiresAt = const Value.absent(),
  }) => PermissionGrantRow(
    capability: capability ?? this.capability,
    granted: granted ?? this.granted,
    autonomous: autonomous ?? this.autonomous,
    scope: scope ?? this.scope,
    grantedVia: grantedVia ?? this.grantedVia,
    grantedAt: grantedAt ?? this.grantedAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
  );
  PermissionGrantRow copyWithCompanion(PermissionsCompanion data) {
    return PermissionGrantRow(
      capability: data.capability.present
          ? data.capability.value
          : this.capability,
      granted: data.granted.present ? data.granted.value : this.granted,
      autonomous: data.autonomous.present
          ? data.autonomous.value
          : this.autonomous,
      scope: data.scope.present ? data.scope.value : this.scope,
      grantedVia: data.grantedVia.present
          ? data.grantedVia.value
          : this.grantedVia,
      grantedAt: data.grantedAt.present ? data.grantedAt.value : this.grantedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PermissionGrantRow(')
          ..write('capability: $capability, ')
          ..write('granted: $granted, ')
          ..write('autonomous: $autonomous, ')
          ..write('scope: $scope, ')
          ..write('grantedVia: $grantedVia, ')
          ..write('grantedAt: $grantedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    capability,
    granted,
    autonomous,
    scope,
    grantedVia,
    grantedAt,
    expiresAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PermissionGrantRow &&
          other.capability == this.capability &&
          other.granted == this.granted &&
          other.autonomous == this.autonomous &&
          other.scope == this.scope &&
          other.grantedVia == this.grantedVia &&
          other.grantedAt == this.grantedAt &&
          other.expiresAt == this.expiresAt);
}

class PermissionsCompanion extends UpdateCompanion<PermissionGrantRow> {
  final Value<String> capability;
  final Value<bool> granted;
  final Value<bool> autonomous;
  final Value<String> scope;
  final Value<String> grantedVia;
  final Value<DateTime> grantedAt;
  final Value<DateTime?> expiresAt;
  final Value<int> rowid;
  const PermissionsCompanion({
    this.capability = const Value.absent(),
    this.granted = const Value.absent(),
    this.autonomous = const Value.absent(),
    this.scope = const Value.absent(),
    this.grantedVia = const Value.absent(),
    this.grantedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PermissionsCompanion.insert({
    required String capability,
    required bool granted,
    this.autonomous = const Value.absent(),
    this.scope = const Value.absent(),
    required String grantedVia,
    required DateTime grantedAt,
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : capability = Value(capability),
       granted = Value(granted),
       grantedVia = Value(grantedVia),
       grantedAt = Value(grantedAt);
  static Insertable<PermissionGrantRow> custom({
    Expression<String>? capability,
    Expression<bool>? granted,
    Expression<bool>? autonomous,
    Expression<String>? scope,
    Expression<String>? grantedVia,
    Expression<DateTime>? grantedAt,
    Expression<DateTime>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (capability != null) 'capability': capability,
      if (granted != null) 'granted': granted,
      if (autonomous != null) 'autonomous': autonomous,
      if (scope != null) 'scope': scope,
      if (grantedVia != null) 'granted_via': grantedVia,
      if (grantedAt != null) 'granted_at': grantedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PermissionsCompanion copyWith({
    Value<String>? capability,
    Value<bool>? granted,
    Value<bool>? autonomous,
    Value<String>? scope,
    Value<String>? grantedVia,
    Value<DateTime>? grantedAt,
    Value<DateTime?>? expiresAt,
    Value<int>? rowid,
  }) {
    return PermissionsCompanion(
      capability: capability ?? this.capability,
      granted: granted ?? this.granted,
      autonomous: autonomous ?? this.autonomous,
      scope: scope ?? this.scope,
      grantedVia: grantedVia ?? this.grantedVia,
      grantedAt: grantedAt ?? this.grantedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (capability.present) {
      map['capability'] = Variable<String>(capability.value);
    }
    if (granted.present) {
      map['granted'] = Variable<bool>(granted.value);
    }
    if (autonomous.present) {
      map['autonomous'] = Variable<bool>(autonomous.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (grantedVia.present) {
      map['granted_via'] = Variable<String>(grantedVia.value);
    }
    if (grantedAt.present) {
      map['granted_at'] = Variable<DateTime>(grantedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PermissionsCompanion(')
          ..write('capability: $capability, ')
          ..write('granted: $granted, ')
          ..write('autonomous: $autonomous, ')
          ..write('scope: $scope, ')
          ..write('grantedVia: $grantedVia, ')
          ..write('grantedAt: $grantedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgentRunsTable extends AgentRuns
    with TableInfo<$AgentRunsTable, AgentRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgentRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggerMeta = const VerificationMeta(
    'trigger',
  );
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
    'trigger',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promptVersionMeta = const VerificationMeta(
    'promptVersion',
  );
  @override
  late final GeneratedColumn<String> promptVersion = GeneratedColumn<String>(
    'prompt_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inputTokensMeta = const VerificationMeta(
    'inputTokens',
  );
  @override
  late final GeneratedColumn<int> inputTokens = GeneratedColumn<int>(
    'input_tokens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _outputTokensMeta = const VerificationMeta(
    'outputTokens',
  );
  @override
  late final GeneratedColumn<int> outputTokens = GeneratedColumn<int>(
    'output_tokens',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _latencyMsMeta = const VerificationMeta(
    'latencyMs',
  );
  @override
  late final GeneratedColumn<int> latencyMs = GeneratedColumn<int>(
    'latency_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trigger,
    model,
    promptVersion,
    inputTokens,
    outputTokens,
    latencyMs,
    status,
    startedAt,
    finishedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agent_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AgentRun> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('trigger')) {
      context.handle(
        _triggerMeta,
        trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta),
      );
    } else if (isInserting) {
      context.missing(_triggerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('prompt_version')) {
      context.handle(
        _promptVersionMeta,
        promptVersion.isAcceptableOrUnknown(
          data['prompt_version']!,
          _promptVersionMeta,
        ),
      );
    }
    if (data.containsKey('input_tokens')) {
      context.handle(
        _inputTokensMeta,
        inputTokens.isAcceptableOrUnknown(
          data['input_tokens']!,
          _inputTokensMeta,
        ),
      );
    }
    if (data.containsKey('output_tokens')) {
      context.handle(
        _outputTokensMeta,
        outputTokens.isAcceptableOrUnknown(
          data['output_tokens']!,
          _outputTokensMeta,
        ),
      );
    }
    if (data.containsKey('latency_ms')) {
      context.handle(
        _latencyMsMeta,
        latencyMs.isAcceptableOrUnknown(data['latency_ms']!, _latencyMsMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgentRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgentRun(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      trigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      promptVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_version'],
      ),
      inputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}input_tokens'],
      )!,
      outputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}output_tokens'],
      )!,
      latencyMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}latency_ms'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
    );
  }

  @override
  $AgentRunsTable createAlias(String alias) {
    return $AgentRunsTable(attachedDatabase, alias);
  }
}

class AgentRun extends DataClass implements Insertable<AgentRun> {
  final String id;
  final String trigger;
  final String? model;
  final String? promptVersion;
  final int inputTokens;
  final int outputTokens;
  final int? latencyMs;
  final String status;
  final DateTime startedAt;
  final DateTime? finishedAt;
  const AgentRun({
    required this.id,
    required this.trigger,
    this.model,
    this.promptVersion,
    required this.inputTokens,
    required this.outputTokens,
    this.latencyMs,
    required this.status,
    required this.startedAt,
    this.finishedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['trigger'] = Variable<String>(trigger);
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || promptVersion != null) {
      map['prompt_version'] = Variable<String>(promptVersion);
    }
    map['input_tokens'] = Variable<int>(inputTokens);
    map['output_tokens'] = Variable<int>(outputTokens);
    if (!nullToAbsent || latencyMs != null) {
      map['latency_ms'] = Variable<int>(latencyMs);
    }
    map['status'] = Variable<String>(status);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    return map;
  }

  AgentRunsCompanion toCompanion(bool nullToAbsent) {
    return AgentRunsCompanion(
      id: Value(id),
      trigger: Value(trigger),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      promptVersion: promptVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(promptVersion),
      inputTokens: Value(inputTokens),
      outputTokens: Value(outputTokens),
      latencyMs: latencyMs == null && nullToAbsent
          ? const Value.absent()
          : Value(latencyMs),
      status: Value(status),
      startedAt: Value(startedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
    );
  }

  factory AgentRun.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgentRun(
      id: serializer.fromJson<String>(json['id']),
      trigger: serializer.fromJson<String>(json['trigger']),
      model: serializer.fromJson<String?>(json['model']),
      promptVersion: serializer.fromJson<String?>(json['promptVersion']),
      inputTokens: serializer.fromJson<int>(json['inputTokens']),
      outputTokens: serializer.fromJson<int>(json['outputTokens']),
      latencyMs: serializer.fromJson<int?>(json['latencyMs']),
      status: serializer.fromJson<String>(json['status']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'trigger': serializer.toJson<String>(trigger),
      'model': serializer.toJson<String?>(model),
      'promptVersion': serializer.toJson<String?>(promptVersion),
      'inputTokens': serializer.toJson<int>(inputTokens),
      'outputTokens': serializer.toJson<int>(outputTokens),
      'latencyMs': serializer.toJson<int?>(latencyMs),
      'status': serializer.toJson<String>(status),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
    };
  }

  AgentRun copyWith({
    String? id,
    String? trigger,
    Value<String?> model = const Value.absent(),
    Value<String?> promptVersion = const Value.absent(),
    int? inputTokens,
    int? outputTokens,
    Value<int?> latencyMs = const Value.absent(),
    String? status,
    DateTime? startedAt,
    Value<DateTime?> finishedAt = const Value.absent(),
  }) => AgentRun(
    id: id ?? this.id,
    trigger: trigger ?? this.trigger,
    model: model.present ? model.value : this.model,
    promptVersion: promptVersion.present
        ? promptVersion.value
        : this.promptVersion,
    inputTokens: inputTokens ?? this.inputTokens,
    outputTokens: outputTokens ?? this.outputTokens,
    latencyMs: latencyMs.present ? latencyMs.value : this.latencyMs,
    status: status ?? this.status,
    startedAt: startedAt ?? this.startedAt,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
  );
  AgentRun copyWithCompanion(AgentRunsCompanion data) {
    return AgentRun(
      id: data.id.present ? data.id.value : this.id,
      trigger: data.trigger.present ? data.trigger.value : this.trigger,
      model: data.model.present ? data.model.value : this.model,
      promptVersion: data.promptVersion.present
          ? data.promptVersion.value
          : this.promptVersion,
      inputTokens: data.inputTokens.present
          ? data.inputTokens.value
          : this.inputTokens,
      outputTokens: data.outputTokens.present
          ? data.outputTokens.value
          : this.outputTokens,
      latencyMs: data.latencyMs.present ? data.latencyMs.value : this.latencyMs,
      status: data.status.present ? data.status.value : this.status,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgentRun(')
          ..write('id: $id, ')
          ..write('trigger: $trigger, ')
          ..write('model: $model, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('latencyMs: $latencyMs, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trigger,
    model,
    promptVersion,
    inputTokens,
    outputTokens,
    latencyMs,
    status,
    startedAt,
    finishedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgentRun &&
          other.id == this.id &&
          other.trigger == this.trigger &&
          other.model == this.model &&
          other.promptVersion == this.promptVersion &&
          other.inputTokens == this.inputTokens &&
          other.outputTokens == this.outputTokens &&
          other.latencyMs == this.latencyMs &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.finishedAt == this.finishedAt);
}

class AgentRunsCompanion extends UpdateCompanion<AgentRun> {
  final Value<String> id;
  final Value<String> trigger;
  final Value<String?> model;
  final Value<String?> promptVersion;
  final Value<int> inputTokens;
  final Value<int> outputTokens;
  final Value<int?> latencyMs;
  final Value<String> status;
  final Value<DateTime> startedAt;
  final Value<DateTime?> finishedAt;
  final Value<int> rowid;
  const AgentRunsCompanion({
    this.id = const Value.absent(),
    this.trigger = const Value.absent(),
    this.model = const Value.absent(),
    this.promptVersion = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.latencyMs = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgentRunsCompanion.insert({
    required String id,
    required String trigger,
    this.model = const Value.absent(),
    this.promptVersion = const Value.absent(),
    this.inputTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.latencyMs = const Value.absent(),
    required String status,
    required DateTime startedAt,
    this.finishedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       trigger = Value(trigger),
       status = Value(status),
       startedAt = Value(startedAt);
  static Insertable<AgentRun> custom({
    Expression<String>? id,
    Expression<String>? trigger,
    Expression<String>? model,
    Expression<String>? promptVersion,
    Expression<int>? inputTokens,
    Expression<int>? outputTokens,
    Expression<int>? latencyMs,
    Expression<String>? status,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? finishedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trigger != null) 'trigger': trigger,
      if (model != null) 'model': model,
      if (promptVersion != null) 'prompt_version': promptVersion,
      if (inputTokens != null) 'input_tokens': inputTokens,
      if (outputTokens != null) 'output_tokens': outputTokens,
      if (latencyMs != null) 'latency_ms': latencyMs,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgentRunsCompanion copyWith({
    Value<String>? id,
    Value<String>? trigger,
    Value<String?>? model,
    Value<String?>? promptVersion,
    Value<int>? inputTokens,
    Value<int>? outputTokens,
    Value<int?>? latencyMs,
    Value<String>? status,
    Value<DateTime>? startedAt,
    Value<DateTime?>? finishedAt,
    Value<int>? rowid,
  }) {
    return AgentRunsCompanion(
      id: id ?? this.id,
      trigger: trigger ?? this.trigger,
      model: model ?? this.model,
      promptVersion: promptVersion ?? this.promptVersion,
      inputTokens: inputTokens ?? this.inputTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      latencyMs: latencyMs ?? this.latencyMs,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (promptVersion.present) {
      map['prompt_version'] = Variable<String>(promptVersion.value);
    }
    if (inputTokens.present) {
      map['input_tokens'] = Variable<int>(inputTokens.value);
    }
    if (outputTokens.present) {
      map['output_tokens'] = Variable<int>(outputTokens.value);
    }
    if (latencyMs.present) {
      map['latency_ms'] = Variable<int>(latencyMs.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgentRunsCompanion(')
          ..write('id: $id, ')
          ..write('trigger: $trigger, ')
          ..write('model: $model, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('inputTokens: $inputTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('latencyMs: $latencyMs, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgentActionsTable extends AgentActions
    with TableInfo<$AgentActionsTable, AgentActionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgentActionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _runIdMeta = const VerificationMeta('runId');
  @override
  late final GeneratedColumn<String> runId = GeneratedColumn<String>(
    'run_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES agent_runs (id)',
    ),
  );
  static const VerificationMeta _toolMeta = const VerificationMeta('tool');
  @override
  late final GeneratedColumn<String> tool = GeneratedColumn<String>(
    'tool',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _argsMeta = const VerificationMeta('args');
  @override
  late final GeneratedColumn<String> args = GeneratedColumn<String>(
    'args',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _argsHashMeta = const VerificationMeta(
    'argsHash',
  );
  @override
  late final GeneratedColumn<String> argsHash = GeneratedColumn<String>(
    'args_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _riskMeta = const VerificationMeta('risk');
  @override
  late final GeneratedColumn<String> risk = GeneratedColumn<String>(
    'risk',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ActionState, int> state =
      GeneratedColumn<int>(
        'state',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ActionState>($AgentActionsTable.$converterstate);
  static const VerificationMeta _blockReasonMeta = const VerificationMeta(
    'blockReason',
  );
  @override
  late final GeneratedColumn<String> blockReason = GeneratedColumn<String>(
    'block_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultRefMeta = const VerificationMeta(
    'resultRef',
  );
  @override
  late final GeneratedColumn<String> resultRef = GeneratedColumn<String>(
    'result_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorCodeMeta = const VerificationMeta(
    'errorCode',
  );
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decidedAtMeta = const VerificationMeta(
    'decidedAt',
  );
  @override
  late final GeneratedColumn<DateTime> decidedAt = GeneratedColumn<DateTime>(
    'decided_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    runId,
    tool,
    args,
    argsHash,
    risk,
    state,
    blockReason,
    resultRef,
    errorCode,
    createdAt,
    decidedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agent_actions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AgentActionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('run_id')) {
      context.handle(
        _runIdMeta,
        runId.isAcceptableOrUnknown(data['run_id']!, _runIdMeta),
      );
    } else if (isInserting) {
      context.missing(_runIdMeta);
    }
    if (data.containsKey('tool')) {
      context.handle(
        _toolMeta,
        tool.isAcceptableOrUnknown(data['tool']!, _toolMeta),
      );
    } else if (isInserting) {
      context.missing(_toolMeta);
    }
    if (data.containsKey('args')) {
      context.handle(
        _argsMeta,
        args.isAcceptableOrUnknown(data['args']!, _argsMeta),
      );
    } else if (isInserting) {
      context.missing(_argsMeta);
    }
    if (data.containsKey('args_hash')) {
      context.handle(
        _argsHashMeta,
        argsHash.isAcceptableOrUnknown(data['args_hash']!, _argsHashMeta),
      );
    } else if (isInserting) {
      context.missing(_argsHashMeta);
    }
    if (data.containsKey('risk')) {
      context.handle(
        _riskMeta,
        risk.isAcceptableOrUnknown(data['risk']!, _riskMeta),
      );
    } else if (isInserting) {
      context.missing(_riskMeta);
    }
    if (data.containsKey('block_reason')) {
      context.handle(
        _blockReasonMeta,
        blockReason.isAcceptableOrUnknown(
          data['block_reason']!,
          _blockReasonMeta,
        ),
      );
    }
    if (data.containsKey('result_ref')) {
      context.handle(
        _resultRefMeta,
        resultRef.isAcceptableOrUnknown(data['result_ref']!, _resultRefMeta),
      );
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('decided_at')) {
      context.handle(
        _decidedAtMeta,
        decidedAt.isAcceptableOrUnknown(data['decided_at']!, _decidedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgentActionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgentActionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      runId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}run_id'],
      )!,
      tool: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool'],
      )!,
      args: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}args'],
      )!,
      argsHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}args_hash'],
      )!,
      risk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk'],
      )!,
      state: $AgentActionsTable.$converterstate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}state'],
        )!,
      ),
      blockReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_reason'],
      ),
      resultRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_ref'],
      ),
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      decidedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}decided_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $AgentActionsTable createAlias(String alias) {
    return $AgentActionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ActionState, int, int> $converterstate =
      const EnumIndexConverter<ActionState>(ActionState.values);
}

class AgentActionRow extends DataClass implements Insertable<AgentActionRow> {
  final String id;
  final String runId;
  final String tool;
  final String args;
  final String argsHash;
  final String risk;
  final ActionState state;
  final String? blockReason;
  final String? resultRef;
  final String? errorCode;
  final DateTime createdAt;
  final DateTime? decidedAt;
  final DateTime? completedAt;
  const AgentActionRow({
    required this.id,
    required this.runId,
    required this.tool,
    required this.args,
    required this.argsHash,
    required this.risk,
    required this.state,
    this.blockReason,
    this.resultRef,
    this.errorCode,
    required this.createdAt,
    this.decidedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['run_id'] = Variable<String>(runId);
    map['tool'] = Variable<String>(tool);
    map['args'] = Variable<String>(args);
    map['args_hash'] = Variable<String>(argsHash);
    map['risk'] = Variable<String>(risk);
    {
      map['state'] = Variable<int>(
        $AgentActionsTable.$converterstate.toSql(state),
      );
    }
    if (!nullToAbsent || blockReason != null) {
      map['block_reason'] = Variable<String>(blockReason);
    }
    if (!nullToAbsent || resultRef != null) {
      map['result_ref'] = Variable<String>(resultRef);
    }
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || decidedAt != null) {
      map['decided_at'] = Variable<DateTime>(decidedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  AgentActionsCompanion toCompanion(bool nullToAbsent) {
    return AgentActionsCompanion(
      id: Value(id),
      runId: Value(runId),
      tool: Value(tool),
      args: Value(args),
      argsHash: Value(argsHash),
      risk: Value(risk),
      state: Value(state),
      blockReason: blockReason == null && nullToAbsent
          ? const Value.absent()
          : Value(blockReason),
      resultRef: resultRef == null && nullToAbsent
          ? const Value.absent()
          : Value(resultRef),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      createdAt: Value(createdAt),
      decidedAt: decidedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(decidedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory AgentActionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgentActionRow(
      id: serializer.fromJson<String>(json['id']),
      runId: serializer.fromJson<String>(json['runId']),
      tool: serializer.fromJson<String>(json['tool']),
      args: serializer.fromJson<String>(json['args']),
      argsHash: serializer.fromJson<String>(json['argsHash']),
      risk: serializer.fromJson<String>(json['risk']),
      state: $AgentActionsTable.$converterstate.fromJson(
        serializer.fromJson<int>(json['state']),
      ),
      blockReason: serializer.fromJson<String?>(json['blockReason']),
      resultRef: serializer.fromJson<String?>(json['resultRef']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      decidedAt: serializer.fromJson<DateTime?>(json['decidedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'runId': serializer.toJson<String>(runId),
      'tool': serializer.toJson<String>(tool),
      'args': serializer.toJson<String>(args),
      'argsHash': serializer.toJson<String>(argsHash),
      'risk': serializer.toJson<String>(risk),
      'state': serializer.toJson<int>(
        $AgentActionsTable.$converterstate.toJson(state),
      ),
      'blockReason': serializer.toJson<String?>(blockReason),
      'resultRef': serializer.toJson<String?>(resultRef),
      'errorCode': serializer.toJson<String?>(errorCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'decidedAt': serializer.toJson<DateTime?>(decidedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  AgentActionRow copyWith({
    String? id,
    String? runId,
    String? tool,
    String? args,
    String? argsHash,
    String? risk,
    ActionState? state,
    Value<String?> blockReason = const Value.absent(),
    Value<String?> resultRef = const Value.absent(),
    Value<String?> errorCode = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> decidedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
  }) => AgentActionRow(
    id: id ?? this.id,
    runId: runId ?? this.runId,
    tool: tool ?? this.tool,
    args: args ?? this.args,
    argsHash: argsHash ?? this.argsHash,
    risk: risk ?? this.risk,
    state: state ?? this.state,
    blockReason: blockReason.present ? blockReason.value : this.blockReason,
    resultRef: resultRef.present ? resultRef.value : this.resultRef,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    createdAt: createdAt ?? this.createdAt,
    decidedAt: decidedAt.present ? decidedAt.value : this.decidedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  AgentActionRow copyWithCompanion(AgentActionsCompanion data) {
    return AgentActionRow(
      id: data.id.present ? data.id.value : this.id,
      runId: data.runId.present ? data.runId.value : this.runId,
      tool: data.tool.present ? data.tool.value : this.tool,
      args: data.args.present ? data.args.value : this.args,
      argsHash: data.argsHash.present ? data.argsHash.value : this.argsHash,
      risk: data.risk.present ? data.risk.value : this.risk,
      state: data.state.present ? data.state.value : this.state,
      blockReason: data.blockReason.present
          ? data.blockReason.value
          : this.blockReason,
      resultRef: data.resultRef.present ? data.resultRef.value : this.resultRef,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      decidedAt: data.decidedAt.present ? data.decidedAt.value : this.decidedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgentActionRow(')
          ..write('id: $id, ')
          ..write('runId: $runId, ')
          ..write('tool: $tool, ')
          ..write('args: $args, ')
          ..write('argsHash: $argsHash, ')
          ..write('risk: $risk, ')
          ..write('state: $state, ')
          ..write('blockReason: $blockReason, ')
          ..write('resultRef: $resultRef, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('decidedAt: $decidedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    runId,
    tool,
    args,
    argsHash,
    risk,
    state,
    blockReason,
    resultRef,
    errorCode,
    createdAt,
    decidedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgentActionRow &&
          other.id == this.id &&
          other.runId == this.runId &&
          other.tool == this.tool &&
          other.args == this.args &&
          other.argsHash == this.argsHash &&
          other.risk == this.risk &&
          other.state == this.state &&
          other.blockReason == this.blockReason &&
          other.resultRef == this.resultRef &&
          other.errorCode == this.errorCode &&
          other.createdAt == this.createdAt &&
          other.decidedAt == this.decidedAt &&
          other.completedAt == this.completedAt);
}

class AgentActionsCompanion extends UpdateCompanion<AgentActionRow> {
  final Value<String> id;
  final Value<String> runId;
  final Value<String> tool;
  final Value<String> args;
  final Value<String> argsHash;
  final Value<String> risk;
  final Value<ActionState> state;
  final Value<String?> blockReason;
  final Value<String?> resultRef;
  final Value<String?> errorCode;
  final Value<DateTime> createdAt;
  final Value<DateTime?> decidedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const AgentActionsCompanion({
    this.id = const Value.absent(),
    this.runId = const Value.absent(),
    this.tool = const Value.absent(),
    this.args = const Value.absent(),
    this.argsHash = const Value.absent(),
    this.risk = const Value.absent(),
    this.state = const Value.absent(),
    this.blockReason = const Value.absent(),
    this.resultRef = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.decidedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgentActionsCompanion.insert({
    required String id,
    required String runId,
    required String tool,
    required String args,
    required String argsHash,
    required String risk,
    required ActionState state,
    this.blockReason = const Value.absent(),
    this.resultRef = const Value.absent(),
    this.errorCode = const Value.absent(),
    required DateTime createdAt,
    this.decidedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       runId = Value(runId),
       tool = Value(tool),
       args = Value(args),
       argsHash = Value(argsHash),
       risk = Value(risk),
       state = Value(state),
       createdAt = Value(createdAt);
  static Insertable<AgentActionRow> custom({
    Expression<String>? id,
    Expression<String>? runId,
    Expression<String>? tool,
    Expression<String>? args,
    Expression<String>? argsHash,
    Expression<String>? risk,
    Expression<int>? state,
    Expression<String>? blockReason,
    Expression<String>? resultRef,
    Expression<String>? errorCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? decidedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (runId != null) 'run_id': runId,
      if (tool != null) 'tool': tool,
      if (args != null) 'args': args,
      if (argsHash != null) 'args_hash': argsHash,
      if (risk != null) 'risk': risk,
      if (state != null) 'state': state,
      if (blockReason != null) 'block_reason': blockReason,
      if (resultRef != null) 'result_ref': resultRef,
      if (errorCode != null) 'error_code': errorCode,
      if (createdAt != null) 'created_at': createdAt,
      if (decidedAt != null) 'decided_at': decidedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgentActionsCompanion copyWith({
    Value<String>? id,
    Value<String>? runId,
    Value<String>? tool,
    Value<String>? args,
    Value<String>? argsHash,
    Value<String>? risk,
    Value<ActionState>? state,
    Value<String?>? blockReason,
    Value<String?>? resultRef,
    Value<String?>? errorCode,
    Value<DateTime>? createdAt,
    Value<DateTime?>? decidedAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return AgentActionsCompanion(
      id: id ?? this.id,
      runId: runId ?? this.runId,
      tool: tool ?? this.tool,
      args: args ?? this.args,
      argsHash: argsHash ?? this.argsHash,
      risk: risk ?? this.risk,
      state: state ?? this.state,
      blockReason: blockReason ?? this.blockReason,
      resultRef: resultRef ?? this.resultRef,
      errorCode: errorCode ?? this.errorCode,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt ?? this.decidedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (runId.present) {
      map['run_id'] = Variable<String>(runId.value);
    }
    if (tool.present) {
      map['tool'] = Variable<String>(tool.value);
    }
    if (args.present) {
      map['args'] = Variable<String>(args.value);
    }
    if (argsHash.present) {
      map['args_hash'] = Variable<String>(argsHash.value);
    }
    if (risk.present) {
      map['risk'] = Variable<String>(risk.value);
    }
    if (state.present) {
      map['state'] = Variable<int>(
        $AgentActionsTable.$converterstate.toSql(state.value),
      );
    }
    if (blockReason.present) {
      map['block_reason'] = Variable<String>(blockReason.value);
    }
    if (resultRef.present) {
      map['result_ref'] = Variable<String>(resultRef.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (decidedAt.present) {
      map['decided_at'] = Variable<DateTime>(decidedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgentActionsCompanion(')
          ..write('id: $id, ')
          ..write('runId: $runId, ')
          ..write('tool: $tool, ')
          ..write('args: $args, ')
          ..write('argsHash: $argsHash, ')
          ..write('risk: $risk, ')
          ..write('state: $state, ')
          ..write('blockReason: $blockReason, ')
          ..write('resultRef: $resultRef, ')
          ..write('errorCode: $errorCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('decidedAt: $decidedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuggestionsTable extends Suggestions
    with TableInfo<$SuggestionsTable, Suggestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuggestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detectorMeta = const VerificationMeta(
    'detector',
  );
  @override
  late final GeneratedColumn<String> detector = GeneratedColumn<String>(
    'detector',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonCodeMeta = const VerificationMeta(
    'reasonCode',
  );
  @override
  late final GeneratedColumn<String> reasonCode = GeneratedColumn<String>(
    'reason_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _explanationFactsMeta = const VerificationMeta(
    'explanationFacts',
  );
  @override
  late final GeneratedColumn<String> explanationFacts = GeneratedColumn<String>(
    'explanation_facts',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surfacedAtMeta = const VerificationMeta(
    'surfacedAt',
  );
  @override
  late final GeneratedColumn<DateTime> surfacedAt = GeneratedColumn<DateTime>(
    'surfaced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dismissedAtMeta = const VerificationMeta(
    'dismissedAt',
  );
  @override
  late final GeneratedColumn<DateTime> dismissedAt = GeneratedColumn<DateTime>(
    'dismissed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _snoozedUntilMeta = const VerificationMeta(
    'snoozedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> snoozedUntil = GeneratedColumn<DateTime>(
    'snoozed_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    detector,
    subjectId,
    reasonCode,
    explanationFacts,
    dueAt,
    surfacedAt,
    dismissedAt,
    snoozedUntil,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suggestions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Suggestion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('detector')) {
      context.handle(
        _detectorMeta,
        detector.isAcceptableOrUnknown(data['detector']!, _detectorMeta),
      );
    } else if (isInserting) {
      context.missing(_detectorMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('reason_code')) {
      context.handle(
        _reasonCodeMeta,
        reasonCode.isAcceptableOrUnknown(data['reason_code']!, _reasonCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonCodeMeta);
    }
    if (data.containsKey('explanation_facts')) {
      context.handle(
        _explanationFactsMeta,
        explanationFacts.isAcceptableOrUnknown(
          data['explanation_facts']!,
          _explanationFactsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_explanationFactsMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('surfaced_at')) {
      context.handle(
        _surfacedAtMeta,
        surfacedAt.isAcceptableOrUnknown(data['surfaced_at']!, _surfacedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_surfacedAtMeta);
    }
    if (data.containsKey('dismissed_at')) {
      context.handle(
        _dismissedAtMeta,
        dismissedAt.isAcceptableOrUnknown(
          data['dismissed_at']!,
          _dismissedAtMeta,
        ),
      );
    }
    if (data.containsKey('snoozed_until')) {
      context.handle(
        _snoozedUntilMeta,
        snoozedUntil.isAcceptableOrUnknown(
          data['snoozed_until']!,
          _snoozedUntilMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Suggestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Suggestion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      detector: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detector'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      reasonCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason_code'],
      )!,
      explanationFacts: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation_facts'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      surfacedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}surfaced_at'],
      )!,
      dismissedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dismissed_at'],
      ),
      snoozedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}snoozed_until'],
      ),
    );
  }

  @override
  $SuggestionsTable createAlias(String alias) {
    return $SuggestionsTable(attachedDatabase, alias);
  }
}

class Suggestion extends DataClass implements Insertable<Suggestion> {
  final String id;
  final String detector;
  final String subjectId;
  final String reasonCode;
  final String explanationFacts;
  final DateTime? dueAt;
  final DateTime surfacedAt;
  final DateTime? dismissedAt;
  final DateTime? snoozedUntil;
  const Suggestion({
    required this.id,
    required this.detector,
    required this.subjectId,
    required this.reasonCode,
    required this.explanationFacts,
    this.dueAt,
    required this.surfacedAt,
    this.dismissedAt,
    this.snoozedUntil,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['detector'] = Variable<String>(detector);
    map['subject_id'] = Variable<String>(subjectId);
    map['reason_code'] = Variable<String>(reasonCode);
    map['explanation_facts'] = Variable<String>(explanationFacts);
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    map['surfaced_at'] = Variable<DateTime>(surfacedAt);
    if (!nullToAbsent || dismissedAt != null) {
      map['dismissed_at'] = Variable<DateTime>(dismissedAt);
    }
    if (!nullToAbsent || snoozedUntil != null) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil);
    }
    return map;
  }

  SuggestionsCompanion toCompanion(bool nullToAbsent) {
    return SuggestionsCompanion(
      id: Value(id),
      detector: Value(detector),
      subjectId: Value(subjectId),
      reasonCode: Value(reasonCode),
      explanationFacts: Value(explanationFacts),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      surfacedAt: Value(surfacedAt),
      dismissedAt: dismissedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dismissedAt),
      snoozedUntil: snoozedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozedUntil),
    );
  }

  factory Suggestion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Suggestion(
      id: serializer.fromJson<String>(json['id']),
      detector: serializer.fromJson<String>(json['detector']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      reasonCode: serializer.fromJson<String>(json['reasonCode']),
      explanationFacts: serializer.fromJson<String>(json['explanationFacts']),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      surfacedAt: serializer.fromJson<DateTime>(json['surfacedAt']),
      dismissedAt: serializer.fromJson<DateTime?>(json['dismissedAt']),
      snoozedUntil: serializer.fromJson<DateTime?>(json['snoozedUntil']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'detector': serializer.toJson<String>(detector),
      'subjectId': serializer.toJson<String>(subjectId),
      'reasonCode': serializer.toJson<String>(reasonCode),
      'explanationFacts': serializer.toJson<String>(explanationFacts),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'surfacedAt': serializer.toJson<DateTime>(surfacedAt),
      'dismissedAt': serializer.toJson<DateTime?>(dismissedAt),
      'snoozedUntil': serializer.toJson<DateTime?>(snoozedUntil),
    };
  }

  Suggestion copyWith({
    String? id,
    String? detector,
    String? subjectId,
    String? reasonCode,
    String? explanationFacts,
    Value<DateTime?> dueAt = const Value.absent(),
    DateTime? surfacedAt,
    Value<DateTime?> dismissedAt = const Value.absent(),
    Value<DateTime?> snoozedUntil = const Value.absent(),
  }) => Suggestion(
    id: id ?? this.id,
    detector: detector ?? this.detector,
    subjectId: subjectId ?? this.subjectId,
    reasonCode: reasonCode ?? this.reasonCode,
    explanationFacts: explanationFacts ?? this.explanationFacts,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    surfacedAt: surfacedAt ?? this.surfacedAt,
    dismissedAt: dismissedAt.present ? dismissedAt.value : this.dismissedAt,
    snoozedUntil: snoozedUntil.present ? snoozedUntil.value : this.snoozedUntil,
  );
  Suggestion copyWithCompanion(SuggestionsCompanion data) {
    return Suggestion(
      id: data.id.present ? data.id.value : this.id,
      detector: data.detector.present ? data.detector.value : this.detector,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      reasonCode: data.reasonCode.present
          ? data.reasonCode.value
          : this.reasonCode,
      explanationFacts: data.explanationFacts.present
          ? data.explanationFacts.value
          : this.explanationFacts,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      surfacedAt: data.surfacedAt.present
          ? data.surfacedAt.value
          : this.surfacedAt,
      dismissedAt: data.dismissedAt.present
          ? data.dismissedAt.value
          : this.dismissedAt,
      snoozedUntil: data.snoozedUntil.present
          ? data.snoozedUntil.value
          : this.snoozedUntil,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Suggestion(')
          ..write('id: $id, ')
          ..write('detector: $detector, ')
          ..write('subjectId: $subjectId, ')
          ..write('reasonCode: $reasonCode, ')
          ..write('explanationFacts: $explanationFacts, ')
          ..write('dueAt: $dueAt, ')
          ..write('surfacedAt: $surfacedAt, ')
          ..write('dismissedAt: $dismissedAt, ')
          ..write('snoozedUntil: $snoozedUntil')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    detector,
    subjectId,
    reasonCode,
    explanationFacts,
    dueAt,
    surfacedAt,
    dismissedAt,
    snoozedUntil,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Suggestion &&
          other.id == this.id &&
          other.detector == this.detector &&
          other.subjectId == this.subjectId &&
          other.reasonCode == this.reasonCode &&
          other.explanationFacts == this.explanationFacts &&
          other.dueAt == this.dueAt &&
          other.surfacedAt == this.surfacedAt &&
          other.dismissedAt == this.dismissedAt &&
          other.snoozedUntil == this.snoozedUntil);
}

class SuggestionsCompanion extends UpdateCompanion<Suggestion> {
  final Value<String> id;
  final Value<String> detector;
  final Value<String> subjectId;
  final Value<String> reasonCode;
  final Value<String> explanationFacts;
  final Value<DateTime?> dueAt;
  final Value<DateTime> surfacedAt;
  final Value<DateTime?> dismissedAt;
  final Value<DateTime?> snoozedUntil;
  final Value<int> rowid;
  const SuggestionsCompanion({
    this.id = const Value.absent(),
    this.detector = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.reasonCode = const Value.absent(),
    this.explanationFacts = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.surfacedAt = const Value.absent(),
    this.dismissedAt = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuggestionsCompanion.insert({
    required String id,
    required String detector,
    required String subjectId,
    required String reasonCode,
    required String explanationFacts,
    this.dueAt = const Value.absent(),
    required DateTime surfacedAt,
    this.dismissedAt = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       detector = Value(detector),
       subjectId = Value(subjectId),
       reasonCode = Value(reasonCode),
       explanationFacts = Value(explanationFacts),
       surfacedAt = Value(surfacedAt);
  static Insertable<Suggestion> custom({
    Expression<String>? id,
    Expression<String>? detector,
    Expression<String>? subjectId,
    Expression<String>? reasonCode,
    Expression<String>? explanationFacts,
    Expression<DateTime>? dueAt,
    Expression<DateTime>? surfacedAt,
    Expression<DateTime>? dismissedAt,
    Expression<DateTime>? snoozedUntil,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (detector != null) 'detector': detector,
      if (subjectId != null) 'subject_id': subjectId,
      if (reasonCode != null) 'reason_code': reasonCode,
      if (explanationFacts != null) 'explanation_facts': explanationFacts,
      if (dueAt != null) 'due_at': dueAt,
      if (surfacedAt != null) 'surfaced_at': surfacedAt,
      if (dismissedAt != null) 'dismissed_at': dismissedAt,
      if (snoozedUntil != null) 'snoozed_until': snoozedUntil,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuggestionsCompanion copyWith({
    Value<String>? id,
    Value<String>? detector,
    Value<String>? subjectId,
    Value<String>? reasonCode,
    Value<String>? explanationFacts,
    Value<DateTime?>? dueAt,
    Value<DateTime>? surfacedAt,
    Value<DateTime?>? dismissedAt,
    Value<DateTime?>? snoozedUntil,
    Value<int>? rowid,
  }) {
    return SuggestionsCompanion(
      id: id ?? this.id,
      detector: detector ?? this.detector,
      subjectId: subjectId ?? this.subjectId,
      reasonCode: reasonCode ?? this.reasonCode,
      explanationFacts: explanationFacts ?? this.explanationFacts,
      dueAt: dueAt ?? this.dueAt,
      surfacedAt: surfacedAt ?? this.surfacedAt,
      dismissedAt: dismissedAt ?? this.dismissedAt,
      snoozedUntil: snoozedUntil ?? this.snoozedUntil,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (detector.present) {
      map['detector'] = Variable<String>(detector.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (reasonCode.present) {
      map['reason_code'] = Variable<String>(reasonCode.value);
    }
    if (explanationFacts.present) {
      map['explanation_facts'] = Variable<String>(explanationFacts.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (surfacedAt.present) {
      map['surfaced_at'] = Variable<DateTime>(surfacedAt.value);
    }
    if (dismissedAt.present) {
      map['dismissed_at'] = Variable<DateTime>(dismissedAt.value);
    }
    if (snoozedUntil.present) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuggestionsCompanion(')
          ..write('id: $id, ')
          ..write('detector: $detector, ')
          ..write('subjectId: $subjectId, ')
          ..write('reasonCode: $reasonCode, ')
          ..write('explanationFacts: $explanationFacts, ')
          ..write('dueAt: $dueAt, ')
          ..write('surfacedAt: $surfacedAt, ')
          ..write('dismissedAt: $dismissedAt, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _actorMeta = const VerificationMeta('actor');
  @override
  late final GeneratedColumn<String> actor = GeneratedColumn<String>(
    'actor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetTypeMeta = const VerificationMeta(
    'targetType',
  );
  @override
  late final GeneratedColumn<String> targetType = GeneratedColumn<String>(
    'target_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetIdMeta = const VerificationMeta(
    'targetId',
  );
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
    'target_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    actor,
    action,
    targetType,
    targetId,
    outcome,
    at,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('actor')) {
      context.handle(
        _actorMeta,
        actor.isAcceptableOrUnknown(data['actor']!, _actorMeta),
      );
    } else if (isInserting) {
      context.missing(_actorMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('target_type')) {
      context.handle(
        _targetTypeMeta,
        targetType.isAcceptableOrUnknown(data['target_type']!, _targetTypeMeta),
      );
    }
    if (data.containsKey('target_id')) {
      context.handle(
        _targetIdMeta,
        targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta),
      );
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    } else if (isInserting) {
      context.missing(_outcomeMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      actor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      targetType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_type'],
      ),
      targetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_id'],
      ),
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditEntry extends DataClass implements Insertable<AuditEntry> {
  final int id;
  final String actor;
  final String action;
  final String? targetType;
  final String? targetId;
  final String outcome;
  final DateTime at;
  const AuditEntry({
    required this.id,
    required this.actor,
    required this.action,
    this.targetType,
    this.targetId,
    required this.outcome,
    required this.at,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['actor'] = Variable<String>(actor);
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || targetType != null) {
      map['target_type'] = Variable<String>(targetType);
    }
    if (!nullToAbsent || targetId != null) {
      map['target_id'] = Variable<String>(targetId);
    }
    map['outcome'] = Variable<String>(outcome);
    map['at'] = Variable<DateTime>(at);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      actor: Value(actor),
      action: Value(action),
      targetType: targetType == null && nullToAbsent
          ? const Value.absent()
          : Value(targetType),
      targetId: targetId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetId),
      outcome: Value(outcome),
      at: Value(at),
    );
  }

  factory AuditEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditEntry(
      id: serializer.fromJson<int>(json['id']),
      actor: serializer.fromJson<String>(json['actor']),
      action: serializer.fromJson<String>(json['action']),
      targetType: serializer.fromJson<String?>(json['targetType']),
      targetId: serializer.fromJson<String?>(json['targetId']),
      outcome: serializer.fromJson<String>(json['outcome']),
      at: serializer.fromJson<DateTime>(json['at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'actor': serializer.toJson<String>(actor),
      'action': serializer.toJson<String>(action),
      'targetType': serializer.toJson<String?>(targetType),
      'targetId': serializer.toJson<String?>(targetId),
      'outcome': serializer.toJson<String>(outcome),
      'at': serializer.toJson<DateTime>(at),
    };
  }

  AuditEntry copyWith({
    int? id,
    String? actor,
    String? action,
    Value<String?> targetType = const Value.absent(),
    Value<String?> targetId = const Value.absent(),
    String? outcome,
    DateTime? at,
  }) => AuditEntry(
    id: id ?? this.id,
    actor: actor ?? this.actor,
    action: action ?? this.action,
    targetType: targetType.present ? targetType.value : this.targetType,
    targetId: targetId.present ? targetId.value : this.targetId,
    outcome: outcome ?? this.outcome,
    at: at ?? this.at,
  );
  AuditEntry copyWithCompanion(AuditLogsCompanion data) {
    return AuditEntry(
      id: data.id.present ? data.id.value : this.id,
      actor: data.actor.present ? data.actor.value : this.actor,
      action: data.action.present ? data.action.value : this.action,
      targetType: data.targetType.present
          ? data.targetType.value
          : this.targetType,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      at: data.at.present ? data.at.value : this.at,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditEntry(')
          ..write('id: $id, ')
          ..write('actor: $actor, ')
          ..write('action: $action, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('outcome: $outcome, ')
          ..write('at: $at')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, actor, action, targetType, targetId, outcome, at);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditEntry &&
          other.id == this.id &&
          other.actor == this.actor &&
          other.action == this.action &&
          other.targetType == this.targetType &&
          other.targetId == this.targetId &&
          other.outcome == this.outcome &&
          other.at == this.at);
}

class AuditLogsCompanion extends UpdateCompanion<AuditEntry> {
  final Value<int> id;
  final Value<String> actor;
  final Value<String> action;
  final Value<String?> targetType;
  final Value<String?> targetId;
  final Value<String> outcome;
  final Value<DateTime> at;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.actor = const Value.absent(),
    this.action = const Value.absent(),
    this.targetType = const Value.absent(),
    this.targetId = const Value.absent(),
    this.outcome = const Value.absent(),
    this.at = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    required String actor,
    required String action,
    this.targetType = const Value.absent(),
    this.targetId = const Value.absent(),
    required String outcome,
    required DateTime at,
  }) : actor = Value(actor),
       action = Value(action),
       outcome = Value(outcome),
       at = Value(at);
  static Insertable<AuditEntry> custom({
    Expression<int>? id,
    Expression<String>? actor,
    Expression<String>? action,
    Expression<String>? targetType,
    Expression<String>? targetId,
    Expression<String>? outcome,
    Expression<DateTime>? at,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (actor != null) 'actor': actor,
      if (action != null) 'action': action,
      if (targetType != null) 'target_type': targetType,
      if (targetId != null) 'target_id': targetId,
      if (outcome != null) 'outcome': outcome,
      if (at != null) 'at': at,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? actor,
    Value<String>? action,
    Value<String?>? targetType,
    Value<String?>? targetId,
    Value<String>? outcome,
    Value<DateTime>? at,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      actor: actor ?? this.actor,
      action: action ?? this.action,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      outcome: outcome ?? this.outcome,
      at: at ?? this.at,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (actor.present) {
      map['actor'] = Variable<String>(actor.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (targetType.present) {
      map['target_type'] = Variable<String>(targetType.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('actor: $actor, ')
          ..write('action: $action, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('outcome: $outcome, ')
          ..write('at: $at')
          ..write(')'))
        .toString();
  }
}

class $EmergencyFieldsTable extends EmergencyFields
    with TableInfo<$EmergencyFieldsTable, EmergencyField> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmergencyFieldsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _showOnCardMeta = const VerificationMeta(
    'showOnCard',
  );
  @override
  late final GeneratedColumn<bool> showOnCard = GeneratedColumn<bool>(
    'show_on_card',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_on_card" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, showOnCard, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_fields';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmergencyField> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('show_on_card')) {
      context.handle(
        _showOnCardMeta,
        showOnCard.isAcceptableOrUnknown(
          data['show_on_card']!,
          _showOnCardMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  EmergencyField map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyField(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      showOnCard: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_on_card'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EmergencyFieldsTable createAlias(String alias) {
    return $EmergencyFieldsTable(attachedDatabase, alias);
  }
}

class EmergencyField extends DataClass implements Insertable<EmergencyField> {
  final String key;
  final String value;
  final bool showOnCard;
  final DateTime updatedAt;
  const EmergencyField({
    required this.key,
    required this.value,
    required this.showOnCard,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['show_on_card'] = Variable<bool>(showOnCard);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EmergencyFieldsCompanion toCompanion(bool nullToAbsent) {
    return EmergencyFieldsCompanion(
      key: Value(key),
      value: Value(value),
      showOnCard: Value(showOnCard),
      updatedAt: Value(updatedAt),
    );
  }

  factory EmergencyField.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyField(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      showOnCard: serializer.fromJson<bool>(json['showOnCard']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'showOnCard': serializer.toJson<bool>(showOnCard),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EmergencyField copyWith({
    String? key,
    String? value,
    bool? showOnCard,
    DateTime? updatedAt,
  }) => EmergencyField(
    key: key ?? this.key,
    value: value ?? this.value,
    showOnCard: showOnCard ?? this.showOnCard,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EmergencyField copyWithCompanion(EmergencyFieldsCompanion data) {
    return EmergencyField(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      showOnCard: data.showOnCard.present
          ? data.showOnCard.value
          : this.showOnCard,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyField(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('showOnCard: $showOnCard, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, showOnCard, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyField &&
          other.key == this.key &&
          other.value == this.value &&
          other.showOnCard == this.showOnCard &&
          other.updatedAt == this.updatedAt);
}

class EmergencyFieldsCompanion extends UpdateCompanion<EmergencyField> {
  final Value<String> key;
  final Value<String> value;
  final Value<bool> showOnCard;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EmergencyFieldsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.showOnCard = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmergencyFieldsCompanion.insert({
    required String key,
    required String value,
    this.showOnCard = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<EmergencyField> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<bool>? showOnCard,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (showOnCard != null) 'show_on_card': showOnCard,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmergencyFieldsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<bool>? showOnCard,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EmergencyFieldsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      showOnCard: showOnCard ?? this.showOnCard,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (showOnCard.present) {
      map['show_on_card'] = Variable<bool>(showOnCard.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyFieldsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('showOnCard: $showOnCard, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LifeDatabase extends GeneratedDatabase {
  _$LifeDatabase(QueryExecutor e) : super(e);
  $LifeDatabaseManager get managers => $LifeDatabaseManager(this);
  late final $MemoriesTable memories = $MemoriesTable(this);
  late final $MemoryVersionsTable memoryVersions = $MemoryVersionsTable(this);
  late final $EntitiesTable entities = $EntitiesTable(this);
  late final $EntityRelationshipsTable entityRelationships =
      $EntityRelationshipsTable(this);
  late final $EntityDatesTable entityDates = $EntityDatesTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $DocumentExtractionsTable documentExtractions =
      $DocumentExtractionsTable(this);
  late final $DocumentChunksTable documentChunks = $DocumentChunksTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $CommitmentsTable commitments = $CommitmentsTable(this);
  late final $PermissionsTable permissions = $PermissionsTable(this);
  late final $AgentRunsTable agentRuns = $AgentRunsTable(this);
  late final $AgentActionsTable agentActions = $AgentActionsTable(this);
  late final $SuggestionsTable suggestions = $SuggestionsTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $EmergencyFieldsTable emergencyFields = $EmergencyFieldsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    memories,
    memoryVersions,
    entities,
    entityRelationships,
    entityDates,
    documents,
    documentExtractions,
    documentChunks,
    tasks,
    events,
    reminders,
    commitments,
    permissions,
    agentRuns,
    agentActions,
    suggestions,
    auditLogs,
    emergencyFields,
  ];
}

typedef $$MemoriesTableCreateCompanionBuilder = MemoriesCompanion Function({
  required String id,
  required Source source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  required MemoryKind kind,
  required String category,
  required String content,
  Value<String?> subject,
  Value<String?> predicate,
  Value<String?> value,
  required DateTime validFrom,
  Value<DateTime?> validTo,
  Value<String?> supersededBy,
  Value<bool> userEditable,
  Value<int> version,
  Value<int> rowid,
});
typedef $$MemoriesTableUpdateCompanionBuilder = MemoriesCompanion Function({
  Value<String> id,
  Value<Source> source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<MemoryKind> kind,
  Value<String> category,
  Value<String> content,
  Value<String?> subject,
  Value<String?> predicate,
  Value<String?> value,
  Value<DateTime> validFrom,
  Value<DateTime?> validTo,
  Value<String?> supersededBy,
  Value<bool> userEditable,
  Value<int> version,
  Value<int> rowid,
});

final class $$MemoriesTableReferences
    extends BaseReferences<_$LifeDatabase, $MemoriesTable, Memory> {
  $$MemoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MemoriesTable _supersededByTable(_$LifeDatabase db) =>
      db.memories.createAlias('memories__superseded_by__memories__id');

  $$MemoriesTableProcessedTableManager? get supersededBy {
    final $_column = $_itemColumn<String>('superseded_by');
    if ($_column == null) return null;
    final manager = $$MemoriesTableTableManager(
      $_db,
      $_db.memories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supersededByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MemoryVersionsTable, List<MemoryVersion>>
  _memoryVersionsRefsTable(_$LifeDatabase db) => MultiTypedResultKey.fromTable(
    db.memoryVersions,
    aliasName: 'memories__id__memory_versions__memory_id',
  );

  $$MemoryVersionsTableProcessedTableManager get memoryVersionsRefs {
    final manager = $$MemoryVersionsTableTableManager(
      $_db,
      $_db.memoryVersions,
    ).filter((f) => f.memoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_memoryVersionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MemoriesTableFilterComposer
    extends Composer<_$LifeDatabase, $MemoriesTable> {
  $$MemoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Source, Source, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sensitivity, Sensitivity, int>
  get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MemoryKind, MemoryKind, int> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get predicate => $composableBuilder(
    column: $table.predicate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get userEditable => $composableBuilder(
    column: $table.userEditable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  $$MemoriesTableFilterComposer get supersededBy {
    final $$MemoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supersededBy,
      referencedTable: $db.memories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoriesTableFilterComposer(
            $db: $db,
            $table: $db.memories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> memoryVersionsRefs(
    Expression<bool> Function($$MemoryVersionsTableFilterComposer f) f,
  ) {
    final $$MemoryVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memoryVersions,
      getReferencedColumn: (t) => t.memoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoryVersionsTableFilterComposer(
            $db: $db,
            $table: $db.memoryVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MemoriesTableOrderingComposer
    extends Composer<_$LifeDatabase, $MemoriesTable> {
  $$MemoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get predicate => $composableBuilder(
    column: $table.predicate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get userEditable => $composableBuilder(
    column: $table.userEditable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  $$MemoriesTableOrderingComposer get supersededBy {
    final $$MemoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supersededBy,
      referencedTable: $db.memories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoriesTableOrderingComposer(
            $db: $db,
            $table: $db.memories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemoriesTableAnnotationComposer
    extends Composer<_$LifeDatabase, $MemoriesTable> {
  $$MemoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Source, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Sensitivity, int> get sensitivity =>
      $composableBuilder(
        column: $table.sensitivity,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MemoryKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get predicate =>
      $composableBuilder(column: $table.predicate, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get validTo =>
      $composableBuilder(column: $table.validTo, builder: (column) => column);

  GeneratedColumn<bool> get userEditable => $composableBuilder(
    column: $table.userEditable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$MemoriesTableAnnotationComposer get supersededBy {
    final $$MemoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supersededBy,
      referencedTable: $db.memories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.memories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> memoryVersionsRefs<T extends Object>(
    Expression<T> Function($$MemoryVersionsTableAnnotationComposer a) f,
  ) {
    final $$MemoryVersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memoryVersions,
      getReferencedColumn: (t) => t.memoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoryVersionsTableAnnotationComposer(
            $db: $db,
            $table: $db.memoryVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MemoriesTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $MemoriesTable,
          Memory,
          $$MemoriesTableFilterComposer,
          $$MemoriesTableOrderingComposer,
          $$MemoriesTableAnnotationComposer,
          $$MemoriesTableCreateCompanionBuilder,
          $$MemoriesTableUpdateCompanionBuilder,
          (Memory, $$MemoriesTableReferences),
          Memory,
          PrefetchHooks Function({bool supersededBy, bool memoryVersionsRefs})
        > {
  $$MemoriesTableTableManager(_$LifeDatabase db, $MemoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Source> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<MemoryKind> kind = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> subject = const Value.absent(),
                Value<String?> predicate = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<DateTime> validFrom = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
                Value<String?> supersededBy = const Value.absent(),
                Value<bool> userEditable = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MemoriesCompanion(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                kind: kind,
                category: category,
                content: content,
                subject: subject,
                predicate: predicate,
                value: value,
                validFrom: validFrom,
                validTo: validTo,
                supersededBy: supersededBy,
                userEditable: userEditable,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Source source,
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required MemoryKind kind,
                required String category,
                required String content,
                Value<String?> subject = const Value.absent(),
                Value<String?> predicate = const Value.absent(),
                Value<String?> value = const Value.absent(),
                required DateTime validFrom,
                Value<DateTime?> validTo = const Value.absent(),
                Value<String?> supersededBy = const Value.absent(),
                Value<bool> userEditable = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MemoriesCompanion.insert(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                kind: kind,
                category: category,
                content: content,
                subject: subject,
                predicate: predicate,
                value: value,
                validFrom: validFrom,
                validTo: validTo,
                supersededBy: supersededBy,
                userEditable: userEditable,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MemoriesTable, Memory>(table),
                  $$MemoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({supersededBy = false, memoryVersionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (memoryVersionsRefs) db.memoryVersions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (supersededBy) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.supersededBy,
                            referencedTable: $$MemoriesTableReferences
                                ._supersededByTable(db),
                            referencedColumn: $$MemoriesTableReferences
                                ._supersededByTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (memoryVersionsRefs)
                        await $_getPrefetchedData<
                          Memory,
                          $MemoriesTable,
                          MemoryVersion
                        >(
                          currentTable: table,
                          referencedTable: $$MemoriesTableReferences
                              ._memoryVersionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MemoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).memoryVersionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MemoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $MemoriesTable,
      Memory,
      $$MemoriesTableFilterComposer,
      $$MemoriesTableOrderingComposer,
      $$MemoriesTableAnnotationComposer,
      $$MemoriesTableCreateCompanionBuilder,
      $$MemoriesTableUpdateCompanionBuilder,
      (Memory, $$MemoriesTableReferences),
      Memory,
      PrefetchHooks Function({bool supersededBy, bool memoryVersionsRefs})
    >;
typedef $$MemoryVersionsTableCreateCompanionBuilder =
    MemoryVersionsCompanion Function({
      Value<int> id,
      required String memoryId,
      required int version,
      required String content,
      Value<String?> value,
      Value<DateTime?> validTo,
      required String changedBy,
      Value<String?> changeReason,
      required DateTime at,
    });
typedef $$MemoryVersionsTableUpdateCompanionBuilder =
    MemoryVersionsCompanion Function({
      Value<int> id,
      Value<String> memoryId,
      Value<int> version,
      Value<String> content,
      Value<String?> value,
      Value<DateTime?> validTo,
      Value<String> changedBy,
      Value<String?> changeReason,
      Value<DateTime> at,
    });

final class $$MemoryVersionsTableReferences
    extends
        BaseReferences<_$LifeDatabase, $MemoryVersionsTable, MemoryVersion> {
  $$MemoryVersionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MemoriesTable _memoryIdTable(_$LifeDatabase db) =>
      db.memories.createAlias('memory_versions__memory_id__memories__id');

  $$MemoriesTableProcessedTableManager get memoryId {
    final $_column = $_itemColumn<String>('memory_id')!;

    final manager = $$MemoriesTableTableManager(
      $_db,
      $_db.memories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MemoryVersionsTableFilterComposer
    extends Composer<_$LifeDatabase, $MemoryVersionsTable> {
  $$MemoryVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changedBy => $composableBuilder(
    column: $table.changedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeReason => $composableBuilder(
    column: $table.changeReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  $$MemoriesTableFilterComposer get memoryId {
    final $$MemoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memoryId,
      referencedTable: $db.memories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoriesTableFilterComposer(
            $db: $db,
            $table: $db.memories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemoryVersionsTableOrderingComposer
    extends Composer<_$LifeDatabase, $MemoryVersionsTable> {
  $$MemoryVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changedBy => $composableBuilder(
    column: $table.changedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeReason => $composableBuilder(
    column: $table.changeReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  $$MemoriesTableOrderingComposer get memoryId {
    final $$MemoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memoryId,
      referencedTable: $db.memories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoriesTableOrderingComposer(
            $db: $db,
            $table: $db.memories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemoryVersionsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $MemoryVersionsTable> {
  $$MemoryVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get validTo =>
      $composableBuilder(column: $table.validTo, builder: (column) => column);

  GeneratedColumn<String> get changedBy =>
      $composableBuilder(column: $table.changedBy, builder: (column) => column);

  GeneratedColumn<String> get changeReason => $composableBuilder(
    column: $table.changeReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  $$MemoriesTableAnnotationComposer get memoryId {
    final $$MemoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memoryId,
      referencedTable: $db.memories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.memories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemoryVersionsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $MemoryVersionsTable,
          MemoryVersion,
          $$MemoryVersionsTableFilterComposer,
          $$MemoryVersionsTableOrderingComposer,
          $$MemoryVersionsTableAnnotationComposer,
          $$MemoryVersionsTableCreateCompanionBuilder,
          $$MemoryVersionsTableUpdateCompanionBuilder,
          (MemoryVersion, $$MemoryVersionsTableReferences),
          MemoryVersion,
          PrefetchHooks Function({bool memoryId})
        > {
  $$MemoryVersionsTableTableManager(
    _$LifeDatabase db,
    $MemoryVersionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemoryVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemoryVersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemoryVersionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> memoryId = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
                Value<String> changedBy = const Value.absent(),
                Value<String?> changeReason = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
              }) => MemoryVersionsCompanion(
                id: id,
                memoryId: memoryId,
                version: version,
                content: content,
                value: value,
                validTo: validTo,
                changedBy: changedBy,
                changeReason: changeReason,
                at: at,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String memoryId,
                required int version,
                required String content,
                Value<String?> value = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
                required String changedBy,
                Value<String?> changeReason = const Value.absent(),
                required DateTime at,
              }) => MemoryVersionsCompanion.insert(
                id: id,
                memoryId: memoryId,
                version: version,
                content: content,
                value: value,
                validTo: validTo,
                changedBy: changedBy,
                changeReason: changeReason,
                at: at,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MemoryVersionsTable, MemoryVersion>(table),
                  $$MemoryVersionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({memoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (memoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.memoryId,
                        referencedTable: $$MemoryVersionsTableReferences
                            ._memoryIdTable(db),
                        referencedColumn: $$MemoryVersionsTableReferences
                            ._memoryIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MemoryVersionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $MemoryVersionsTable,
      MemoryVersion,
      $$MemoryVersionsTableFilterComposer,
      $$MemoryVersionsTableOrderingComposer,
      $$MemoryVersionsTableAnnotationComposer,
      $$MemoryVersionsTableCreateCompanionBuilder,
      $$MemoryVersionsTableUpdateCompanionBuilder,
      (MemoryVersion, $$MemoryVersionsTableReferences),
      MemoryVersion,
      PrefetchHooks Function({bool memoryId})
    >;
typedef $$EntitiesTableCreateCompanionBuilder = EntitiesCompanion Function({
  required String id,
  required Source source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  required String type,
  required String displayName,
  Value<String> attributes,
  Value<int> rowid,
});
typedef $$EntitiesTableUpdateCompanionBuilder = EntitiesCompanion Function({
  Value<String> id,
  Value<Source> source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> type,
  Value<String> displayName,
  Value<String> attributes,
  Value<int> rowid,
});

final class $$EntitiesTableReferences
    extends BaseReferences<_$LifeDatabase, $EntitiesTable, Entity> {
  $$EntitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $EntityRelationshipsTable,
    List<EntityRelationship>
  >
  _outgoingRelationshipsTable(_$LifeDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.entityRelationships,
        aliasName: 'entities__id__entity_relationships__from_entity',
      );

  $$EntityRelationshipsTableProcessedTableManager get outgoingRelationships {
    final manager = $$EntityRelationshipsTableTableManager(
      $_db,
      $_db.entityRelationships,
    ).filter((f) => f.fromEntity.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _outgoingRelationshipsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $EntityRelationshipsTable,
    List<EntityRelationship>
  >
  _incomingRelationshipsTable(_$LifeDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.entityRelationships,
        aliasName: 'entities__id__entity_relationships__to_entity',
      );

  $$EntityRelationshipsTableProcessedTableManager get incomingRelationships {
    final manager = $$EntityRelationshipsTableTableManager(
      $_db,
      $_db.entityRelationships,
    ).filter((f) => f.toEntity.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _incomingRelationshipsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EntityDatesTable, List<EntityDate>>
  _entityDatesRefsTable(_$LifeDatabase db) => MultiTypedResultKey.fromTable(
    db.entityDates,
    aliasName: 'entities__id__entity_dates__entity_id',
  );

  $$EntityDatesTableProcessedTableManager get entityDatesRefs {
    final manager = $$EntityDatesTableTableManager(
      $_db,
      $_db.entityDates,
    ).filter((f) => f.entityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entityDatesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
  _documentsRefsTable(_$LifeDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: 'entities__id__documents__entity_id',
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.entityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
    _$LifeDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: 'entities__id__tasks__project_entity_id',
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager($_db, $_db.tasks).filter(
      (f) => f.projectEntityId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EntitiesTableFilterComposer
    extends Composer<_$LifeDatabase, $EntitiesTable> {
  $$EntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Source, Source, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sensitivity, Sensitivity, int>
  get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attributes => $composableBuilder(
    column: $table.attributes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> outgoingRelationships(
    Expression<bool> Function($$EntityRelationshipsTableFilterComposer f) f,
  ) {
    final $$EntityRelationshipsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entityRelationships,
      getReferencedColumn: (t) => t.fromEntity,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntityRelationshipsTableFilterComposer(
            $db: $db,
            $table: $db.entityRelationships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> incomingRelationships(
    Expression<bool> Function($$EntityRelationshipsTableFilterComposer f) f,
  ) {
    final $$EntityRelationshipsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entityRelationships,
      getReferencedColumn: (t) => t.toEntity,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntityRelationshipsTableFilterComposer(
            $db: $db,
            $table: $db.entityRelationships,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> entityDatesRefs(
    Expression<bool> Function($$EntityDatesTableFilterComposer f) f,
  ) {
    final $$EntityDatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entityDates,
      getReferencedColumn: (t) => t.entityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntityDatesTableFilterComposer(
            $db: $db,
            $table: $db.entityDates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.entityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.projectEntityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntitiesTableOrderingComposer
    extends Composer<_$LifeDatabase, $EntitiesTable> {
  $$EntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attributes => $composableBuilder(
    column: $table.attributes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EntitiesTableAnnotationComposer
    extends Composer<_$LifeDatabase, $EntitiesTable> {
  $$EntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Source, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Sensitivity, int> get sensitivity =>
      $composableBuilder(
        column: $table.sensitivity,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attributes => $composableBuilder(
    column: $table.attributes,
    builder: (column) => column,
  );

  Expression<T> outgoingRelationships<T extends Object>(
    Expression<T> Function($$EntityRelationshipsTableAnnotationComposer a) f,
  ) {
    final $$EntityRelationshipsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.entityRelationships,
          getReferencedColumn: (t) => t.fromEntity,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EntityRelationshipsTableAnnotationComposer(
                $db: $db,
                $table: $db.entityRelationships,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> incomingRelationships<T extends Object>(
    Expression<T> Function($$EntityRelationshipsTableAnnotationComposer a) f,
  ) {
    final $$EntityRelationshipsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.entityRelationships,
          getReferencedColumn: (t) => t.toEntity,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EntityRelationshipsTableAnnotationComposer(
                $db: $db,
                $table: $db.entityRelationships,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> entityDatesRefs<T extends Object>(
    Expression<T> Function($$EntityDatesTableAnnotationComposer a) f,
  ) {
    final $$EntityDatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entityDates,
      getReferencedColumn: (t) => t.entityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntityDatesTableAnnotationComposer(
            $db: $db,
            $table: $db.entityDates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.entityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.projectEntityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntitiesTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $EntitiesTable,
          Entity,
          $$EntitiesTableFilterComposer,
          $$EntitiesTableOrderingComposer,
          $$EntitiesTableAnnotationComposer,
          $$EntitiesTableCreateCompanionBuilder,
          $$EntitiesTableUpdateCompanionBuilder,
          (Entity, $$EntitiesTableReferences),
          Entity,
          PrefetchHooks Function({
            bool outgoingRelationships,
            bool incomingRelationships,
            bool entityDatesRefs,
            bool documentsRefs,
            bool tasksRefs,
          })
        > {
  $$EntitiesTableTableManager(_$LifeDatabase db, $EntitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Source> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> attributes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntitiesCompanion(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                type: type,
                displayName: displayName,
                attributes: attributes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Source source,
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String type,
                required String displayName,
                Value<String> attributes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntitiesCompanion.insert(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                type: type,
                displayName: displayName,
                attributes: attributes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EntitiesTable, Entity>(table),
                  $$EntitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                outgoingRelationships = false,
                incomingRelationships = false,
                entityDatesRefs = false,
                documentsRefs = false,
                tasksRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (outgoingRelationships) db.entityRelationships,
                    if (incomingRelationships) db.entityRelationships,
                    if (entityDatesRefs) db.entityDates,
                    if (documentsRefs) db.documents,
                    if (tasksRefs) db.tasks,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (outgoingRelationships)
                        await $_getPrefetchedData<
                          Entity,
                          $EntitiesTable,
                          EntityRelationship
                        >(
                          currentTable: table,
                          referencedTable: $$EntitiesTableReferences
                              ._outgoingRelationshipsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).outgoingRelationships,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fromEntity == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (incomingRelationships)
                        await $_getPrefetchedData<
                          Entity,
                          $EntitiesTable,
                          EntityRelationship
                        >(
                          currentTable: table,
                          referencedTable: $$EntitiesTableReferences
                              ._incomingRelationshipsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).incomingRelationships,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.toEntity == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (entityDatesRefs)
                        await $_getPrefetchedData<
                          Entity,
                          $EntitiesTable,
                          EntityDate
                        >(
                          currentTable: table,
                          referencedTable: $$EntitiesTableReferences
                              ._entityDatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).entityDatesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entityId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentsRefs)
                        await $_getPrefetchedData<
                          Entity,
                          $EntitiesTable,
                          Document
                        >(
                          currentTable: table,
                          referencedTable: $$EntitiesTableReferences
                              ._documentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).documentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entityId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedData<Entity, $EntitiesTable, Task>(
                          currentTable: table,
                          referencedTable: $$EntitiesTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectEntityId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EntitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $EntitiesTable,
      Entity,
      $$EntitiesTableFilterComposer,
      $$EntitiesTableOrderingComposer,
      $$EntitiesTableAnnotationComposer,
      $$EntitiesTableCreateCompanionBuilder,
      $$EntitiesTableUpdateCompanionBuilder,
      (Entity, $$EntitiesTableReferences),
      Entity,
      PrefetchHooks Function({
        bool outgoingRelationships,
        bool incomingRelationships,
        bool entityDatesRefs,
        bool documentsRefs,
        bool tasksRefs,
      })
    >;
typedef $$EntityRelationshipsTableCreateCompanionBuilder =
    EntityRelationshipsCompanion Function({
      required String id,
      required Source source,
      Value<String?> sourceRef,
      Value<double> confidence,
      Value<Sensitivity> sensitivity,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      required String fromEntity,
      required String toEntity,
      required String relation,
      Value<DateTime?> validFrom,
      Value<DateTime?> validTo,
      Value<int> rowid,
    });
typedef $$EntityRelationshipsTableUpdateCompanionBuilder =
    EntityRelationshipsCompanion Function({
      Value<String> id,
      Value<Source> source,
      Value<String?> sourceRef,
      Value<double> confidence,
      Value<Sensitivity> sensitivity,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> fromEntity,
      Value<String> toEntity,
      Value<String> relation,
      Value<DateTime?> validFrom,
      Value<DateTime?> validTo,
      Value<int> rowid,
    });

final class $$EntityRelationshipsTableReferences
    extends
        BaseReferences<
          _$LifeDatabase,
          $EntityRelationshipsTable,
          EntityRelationship
        > {
  $$EntityRelationshipsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EntitiesTable _fromEntityTable(_$LifeDatabase db) => db.entities
      .createAlias('entity_relationships__from_entity__entities__id');

  $$EntitiesTableProcessedTableManager get fromEntity {
    final $_column = $_itemColumn<String>('from_entity')!;

    final manager = $$EntitiesTableTableManager(
      $_db,
      $_db.entities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromEntityTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EntitiesTable _toEntityTable(_$LifeDatabase db) =>
      db.entities.createAlias('entity_relationships__to_entity__entities__id');

  $$EntitiesTableProcessedTableManager get toEntity {
    final $_column = $_itemColumn<String>('to_entity')!;

    final manager = $$EntitiesTableTableManager(
      $_db,
      $_db.entities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toEntityTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EntityRelationshipsTableFilterComposer
    extends Composer<_$LifeDatabase, $EntityRelationshipsTable> {
  $$EntityRelationshipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Source, Source, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sensitivity, Sensitivity, int>
  get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnFilters(column),
  );

  $$EntitiesTableFilterComposer get fromEntity {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromEntity,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableFilterComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableFilterComposer get toEntity {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toEntity,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableFilterComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntityRelationshipsTableOrderingComposer
    extends Composer<_$LifeDatabase, $EntityRelationshipsTable> {
  $$EntityRelationshipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnOrderings(column),
  );

  $$EntitiesTableOrderingComposer get fromEntity {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromEntity,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableOrderingComposer get toEntity {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toEntity,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntityRelationshipsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $EntityRelationshipsTable> {
  $$EntityRelationshipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Source, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Sensitivity, int> get sensitivity =>
      $composableBuilder(
        column: $table.sensitivity,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get relation =>
      $composableBuilder(column: $table.relation, builder: (column) => column);

  GeneratedColumn<DateTime> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get validTo =>
      $composableBuilder(column: $table.validTo, builder: (column) => column);

  $$EntitiesTableAnnotationComposer get fromEntity {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromEntity,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableAnnotationComposer get toEntity {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toEntity,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntityRelationshipsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $EntityRelationshipsTable,
          EntityRelationship,
          $$EntityRelationshipsTableFilterComposer,
          $$EntityRelationshipsTableOrderingComposer,
          $$EntityRelationshipsTableAnnotationComposer,
          $$EntityRelationshipsTableCreateCompanionBuilder,
          $$EntityRelationshipsTableUpdateCompanionBuilder,
          (EntityRelationship, $$EntityRelationshipsTableReferences),
          EntityRelationship,
          PrefetchHooks Function({bool fromEntity, bool toEntity})
        > {
  $$EntityRelationshipsTableTableManager(
    _$LifeDatabase db,
    $EntityRelationshipsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntityRelationshipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntityRelationshipsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EntityRelationshipsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Source> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> fromEntity = const Value.absent(),
                Value<String> toEntity = const Value.absent(),
                Value<String> relation = const Value.absent(),
                Value<DateTime?> validFrom = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntityRelationshipsCompanion(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                fromEntity: fromEntity,
                toEntity: toEntity,
                relation: relation,
                validFrom: validFrom,
                validTo: validTo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Source source,
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String fromEntity,
                required String toEntity,
                required String relation,
                Value<DateTime?> validFrom = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntityRelationshipsCompanion.insert(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                fromEntity: fromEntity,
                toEntity: toEntity,
                relation: relation,
                validFrom: validFrom,
                validTo: validTo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EntityRelationshipsTable, EntityRelationship>(
                    table,
                  ),
                  $$EntityRelationshipsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fromEntity = false, toEntity = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fromEntity) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.fromEntity,
                        referencedTable: $$EntityRelationshipsTableReferences
                            ._fromEntityTable(db),
                        referencedColumn: $$EntityRelationshipsTableReferences
                            ._fromEntityTable(db)
                            .id,
                      ) as T;
                    }
                    if (toEntity) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.toEntity,
                        referencedTable: $$EntityRelationshipsTableReferences
                            ._toEntityTable(db),
                        referencedColumn: $$EntityRelationshipsTableReferences
                            ._toEntityTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EntityRelationshipsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $EntityRelationshipsTable,
      EntityRelationship,
      $$EntityRelationshipsTableFilterComposer,
      $$EntityRelationshipsTableOrderingComposer,
      $$EntityRelationshipsTableAnnotationComposer,
      $$EntityRelationshipsTableCreateCompanionBuilder,
      $$EntityRelationshipsTableUpdateCompanionBuilder,
      (EntityRelationship, $$EntityRelationshipsTableReferences),
      EntityRelationship,
      PrefetchHooks Function({bool fromEntity, bool toEntity})
    >;
typedef $$EntityDatesTableCreateCompanionBuilder =
    EntityDatesCompanion Function({
      required String id,
      required Source source,
      Value<String?> sourceRef,
      Value<double> confidence,
      Value<Sensitivity> sensitivity,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      required String entityId,
      required String kind,
      required DateTime date,
      Value<String?> recurrenceRule,
      Value<int?> remindDaysBefore,
      Value<int> rowid,
    });
typedef $$EntityDatesTableUpdateCompanionBuilder =
    EntityDatesCompanion Function({
      Value<String> id,
      Value<Source> source,
      Value<String?> sourceRef,
      Value<double> confidence,
      Value<Sensitivity> sensitivity,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> entityId,
      Value<String> kind,
      Value<DateTime> date,
      Value<String?> recurrenceRule,
      Value<int?> remindDaysBefore,
      Value<int> rowid,
    });

final class $$EntityDatesTableReferences
    extends BaseReferences<_$LifeDatabase, $EntityDatesTable, EntityDate> {
  $$EntityDatesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EntitiesTable _entityIdTable(_$LifeDatabase db) =>
      db.entities.createAlias('entity_dates__entity_id__entities__id');

  $$EntitiesTableProcessedTableManager get entityId {
    final $_column = $_itemColumn<String>('entity_id')!;

    final manager = $$EntitiesTableTableManager(
      $_db,
      $_db.entities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EntityDatesTableFilterComposer
    extends Composer<_$LifeDatabase, $EntityDatesTable> {
  $$EntityDatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Source, Source, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sensitivity, Sensitivity, int>
  get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceRule => $composableBuilder(
    column: $table.recurrenceRule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => ColumnFilters(column),
  );

  $$EntitiesTableFilterComposer get entityId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entityId,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableFilterComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntityDatesTableOrderingComposer
    extends Composer<_$LifeDatabase, $EntityDatesTable> {
  $$EntityDatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceRule => $composableBuilder(
    column: $table.recurrenceRule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  $$EntitiesTableOrderingComposer get entityId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entityId,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntityDatesTableAnnotationComposer
    extends Composer<_$LifeDatabase, $EntityDatesTable> {
  $$EntityDatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Source, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Sensitivity, int> get sensitivity =>
      $composableBuilder(
        column: $table.sensitivity,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get recurrenceRule => $composableBuilder(
    column: $table.recurrenceRule,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remindDaysBefore => $composableBuilder(
    column: $table.remindDaysBefore,
    builder: (column) => column,
  );

  $$EntitiesTableAnnotationComposer get entityId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entityId,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntityDatesTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $EntityDatesTable,
          EntityDate,
          $$EntityDatesTableFilterComposer,
          $$EntityDatesTableOrderingComposer,
          $$EntityDatesTableAnnotationComposer,
          $$EntityDatesTableCreateCompanionBuilder,
          $$EntityDatesTableUpdateCompanionBuilder,
          (EntityDate, $$EntityDatesTableReferences),
          EntityDate,
          PrefetchHooks Function({bool entityId})
        > {
  $$EntityDatesTableTableManager(_$LifeDatabase db, $EntityDatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntityDatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntityDatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntityDatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Source> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> recurrenceRule = const Value.absent(),
                Value<int?> remindDaysBefore = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntityDatesCompanion(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                entityId: entityId,
                kind: kind,
                date: date,
                recurrenceRule: recurrenceRule,
                remindDaysBefore: remindDaysBefore,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Source source,
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String entityId,
                required String kind,
                required DateTime date,
                Value<String?> recurrenceRule = const Value.absent(),
                Value<int?> remindDaysBefore = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntityDatesCompanion.insert(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                entityId: entityId,
                kind: kind,
                date: date,
                recurrenceRule: recurrenceRule,
                remindDaysBefore: remindDaysBefore,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EntityDatesTable, EntityDate>(table),
                  $$EntityDatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (entityId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.entityId,
                        referencedTable: $$EntityDatesTableReferences
                            ._entityIdTable(db),
                        referencedColumn: $$EntityDatesTableReferences
                            ._entityIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EntityDatesTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $EntityDatesTable,
      EntityDate,
      $$EntityDatesTableFilterComposer,
      $$EntityDatesTableOrderingComposer,
      $$EntityDatesTableAnnotationComposer,
      $$EntityDatesTableCreateCompanionBuilder,
      $$EntityDatesTableUpdateCompanionBuilder,
      (EntityDate, $$EntityDatesTableReferences),
      EntityDate,
      PrefetchHooks Function({bool entityId})
    >;
typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  required String id,
  required Source source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  required String fileName,
  Value<String?> title,
  required String mimeType,
  required String sha256,
  required int sizeBytes,
  required String blobPath,
  Value<String?> docType,
  Value<double?> classificationConfidence,
  Value<String> ocrStatus,
  Value<String> extractionStatus,
  Value<String?> entityId,
  Value<int> rowid,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<String> id,
  Value<Source> source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> fileName,
  Value<String?> title,
  Value<String> mimeType,
  Value<String> sha256,
  Value<int> sizeBytes,
  Value<String> blobPath,
  Value<String?> docType,
  Value<double?> classificationConfidence,
  Value<String> ocrStatus,
  Value<String> extractionStatus,
  Value<String?> entityId,
  Value<int> rowid,
});

final class $$DocumentsTableReferences
    extends BaseReferences<_$LifeDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EntitiesTable _entityIdTable(_$LifeDatabase db) =>
      db.entities.createAlias('documents__entity_id__entities__id');

  $$EntitiesTableProcessedTableManager? get entityId {
    final $_column = $_itemColumn<String>('entity_id');
    if ($_column == null) return null;
    final manager = $$EntitiesTableTableManager(
      $_db,
      $_db.entities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $DocumentExtractionsTable,
    List<DocumentExtraction>
  >
  _documentExtractionsRefsTable(_$LifeDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.documentExtractions,
        aliasName: 'documents__id__document_extractions__document_id',
      );

  $$DocumentExtractionsTableProcessedTableManager get documentExtractionsRefs {
    final manager = $$DocumentExtractionsTableTableManager(
      $_db,
      $_db.documentExtractions,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _documentExtractionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentChunksTable, List<DocumentChunk>>
  _documentChunksRefsTable(_$LifeDatabase db) => MultiTypedResultKey.fromTable(
    db.documentChunks,
    aliasName: 'documents__id__document_chunks__document_id',
  );

  $$DocumentChunksTableProcessedTableManager get documentChunksRefs {
    final manager = $$DocumentChunksTableTableManager(
      $_db,
      $_db.documentChunks,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentChunksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$LifeDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Source, Source, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sensitivity, Sensitivity, int>
  get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blobPath => $composableBuilder(
    column: $table.blobPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get docType => $composableBuilder(
    column: $table.docType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get classificationConfidence => $composableBuilder(
    column: $table.classificationConfidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrStatus => $composableBuilder(
    column: $table.ocrStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extractionStatus => $composableBuilder(
    column: $table.extractionStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$EntitiesTableFilterComposer get entityId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entityId,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableFilterComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> documentExtractionsRefs(
    Expression<bool> Function($$DocumentExtractionsTableFilterComposer f) f,
  ) {
    final $$DocumentExtractionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentExtractions,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentExtractionsTableFilterComposer(
            $db: $db,
            $table: $db.documentExtractions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentChunksRefs(
    Expression<bool> Function($$DocumentChunksTableFilterComposer f) f,
  ) {
    final $$DocumentChunksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentChunks,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentChunksTableFilterComposer(
            $db: $db,
            $table: $db.documentChunks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$LifeDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blobPath => $composableBuilder(
    column: $table.blobPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get docType => $composableBuilder(
    column: $table.docType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get classificationConfidence => $composableBuilder(
    column: $table.classificationConfidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrStatus => $composableBuilder(
    column: $table.ocrStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extractionStatus => $composableBuilder(
    column: $table.extractionStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$EntitiesTableOrderingComposer get entityId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entityId,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Source, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Sensitivity, int> get sensitivity =>
      $composableBuilder(
        column: $table.sensitivity,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get blobPath =>
      $composableBuilder(column: $table.blobPath, builder: (column) => column);

  GeneratedColumn<String> get docType =>
      $composableBuilder(column: $table.docType, builder: (column) => column);

  GeneratedColumn<double> get classificationConfidence => $composableBuilder(
    column: $table.classificationConfidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocrStatus =>
      $composableBuilder(column: $table.ocrStatus, builder: (column) => column);

  GeneratedColumn<String> get extractionStatus => $composableBuilder(
    column: $table.extractionStatus,
    builder: (column) => column,
  );

  $$EntitiesTableAnnotationComposer get entityId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entityId,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> documentExtractionsRefs<T extends Object>(
    Expression<T> Function($$DocumentExtractionsTableAnnotationComposer a) f,
  ) {
    final $$DocumentExtractionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.documentExtractions,
          getReferencedColumn: (t) => t.documentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DocumentExtractionsTableAnnotationComposer(
                $db: $db,
                $table: $db.documentExtractions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> documentChunksRefs<T extends Object>(
    Expression<T> Function($$DocumentChunksTableAnnotationComposer a) f,
  ) {
    final $$DocumentChunksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documentChunks,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentChunksTableAnnotationComposer(
            $db: $db,
            $table: $db.documentChunks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, $$DocumentsTableReferences),
          Document,
          PrefetchHooks Function({
            bool entityId,
            bool documentExtractionsRefs,
            bool documentChunksRefs,
          })
        > {
  $$DocumentsTableTableManager(_$LifeDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Source> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String> blobPath = const Value.absent(),
                Value<String?> docType = const Value.absent(),
                Value<double?> classificationConfidence = const Value.absent(),
                Value<String> ocrStatus = const Value.absent(),
                Value<String> extractionStatus = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                fileName: fileName,
                title: title,
                mimeType: mimeType,
                sha256: sha256,
                sizeBytes: sizeBytes,
                blobPath: blobPath,
                docType: docType,
                classificationConfidence: classificationConfidence,
                ocrStatus: ocrStatus,
                extractionStatus: extractionStatus,
                entityId: entityId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Source source,
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String fileName,
                Value<String?> title = const Value.absent(),
                required String mimeType,
                required String sha256,
                required int sizeBytes,
                required String blobPath,
                Value<String?> docType = const Value.absent(),
                Value<double?> classificationConfidence = const Value.absent(),
                Value<String> ocrStatus = const Value.absent(),
                Value<String> extractionStatus = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                fileName: fileName,
                title: title,
                mimeType: mimeType,
                sha256: sha256,
                sizeBytes: sizeBytes,
                blobPath: blobPath,
                docType: docType,
                classificationConfidence: classificationConfidence,
                ocrStatus: ocrStatus,
                extractionStatus: extractionStatus,
                entityId: entityId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentsTable, Document>(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                entityId = false,
                documentExtractionsRefs = false,
                documentChunksRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (documentExtractionsRefs) db.documentExtractions,
                    if (documentChunksRefs) db.documentChunks,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (entityId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.entityId,
                            referencedTable: $$DocumentsTableReferences
                                ._entityIdTable(db),
                            referencedColumn: $$DocumentsTableReferences
                                ._entityIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (documentExtractionsRefs)
                        await $_getPrefetchedData<
                          Document,
                          $DocumentsTable,
                          DocumentExtraction
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._documentExtractionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).documentExtractionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documentChunksRefs)
                        await $_getPrefetchedData<
                          Document,
                          $DocumentsTable,
                          DocumentChunk
                        >(
                          currentTable: table,
                          referencedTable: $$DocumentsTableReferences
                              ._documentChunksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DocumentsTableReferences(
                                db,
                                table,
                                p0,
                              ).documentChunksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.documentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, $$DocumentsTableReferences),
      Document,
      PrefetchHooks Function({
        bool entityId,
        bool documentExtractionsRefs,
        bool documentChunksRefs,
      })
    >;
typedef $$DocumentExtractionsTableCreateCompanionBuilder =
    DocumentExtractionsCompanion Function({
      required String id,
      required String documentId,
      required String field,
      required String value,
      required double confidence,
      Value<int?> page,
      Value<ReviewStatus> reviewStatus,
      Value<String?> quote,
      Value<String> origin,
      Value<int> rowid,
    });
typedef $$DocumentExtractionsTableUpdateCompanionBuilder =
    DocumentExtractionsCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<String> field,
      Value<String> value,
      Value<double> confidence,
      Value<int?> page,
      Value<ReviewStatus> reviewStatus,
      Value<String?> quote,
      Value<String> origin,
      Value<int> rowid,
    });

final class $$DocumentExtractionsTableReferences
    extends
        BaseReferences<
          _$LifeDatabase,
          $DocumentExtractionsTable,
          DocumentExtraction
        > {
  $$DocumentExtractionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentsTable _documentIdTable(_$LifeDatabase db) => db.documents
      .createAlias('document_extractions__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentExtractionsTableFilterComposer
    extends Composer<_$LifeDatabase, $DocumentExtractionsTable> {
  $$DocumentExtractionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get field => $composableBuilder(
    column: $table.field,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReviewStatus, ReviewStatus, int>
  get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentExtractionsTableOrderingComposer
    extends Composer<_$LifeDatabase, $DocumentExtractionsTable> {
  $$DocumentExtractionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get field => $composableBuilder(
    column: $table.field,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewStatus => $composableBuilder(
    column: $table.reviewStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentExtractionsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $DocumentExtractionsTable> {
  $$DocumentExtractionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get field =>
      $composableBuilder(column: $table.field, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReviewStatus, int> get reviewStatus =>
      $composableBuilder(
        column: $table.reviewStatus,
        builder: (column) => column,
      );

  GeneratedColumn<String> get quote =>
      $composableBuilder(column: $table.quote, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentExtractionsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $DocumentExtractionsTable,
          DocumentExtraction,
          $$DocumentExtractionsTableFilterComposer,
          $$DocumentExtractionsTableOrderingComposer,
          $$DocumentExtractionsTableAnnotationComposer,
          $$DocumentExtractionsTableCreateCompanionBuilder,
          $$DocumentExtractionsTableUpdateCompanionBuilder,
          (DocumentExtraction, $$DocumentExtractionsTableReferences),
          DocumentExtraction,
          PrefetchHooks Function({bool documentId})
        > {
  $$DocumentExtractionsTableTableManager(
    _$LifeDatabase db,
    $DocumentExtractionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentExtractionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentExtractionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DocumentExtractionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<String> field = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<int?> page = const Value.absent(),
                Value<ReviewStatus> reviewStatus = const Value.absent(),
                Value<String?> quote = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentExtractionsCompanion(
                id: id,
                documentId: documentId,
                field: field,
                value: value,
                confidence: confidence,
                page: page,
                reviewStatus: reviewStatus,
                quote: quote,
                origin: origin,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required String field,
                required String value,
                required double confidence,
                Value<int?> page = const Value.absent(),
                Value<ReviewStatus> reviewStatus = const Value.absent(),
                Value<String?> quote = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentExtractionsCompanion.insert(
                id: id,
                documentId: documentId,
                field: field,
                value: value,
                confidence: confidence,
                page: page,
                reviewStatus: reviewStatus,
                quote: quote,
                origin: origin,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentExtractionsTable, DocumentExtraction>(
                    table,
                  ),
                  $$DocumentExtractionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.documentId,
                        referencedTable: $$DocumentExtractionsTableReferences
                            ._documentIdTable(db),
                        referencedColumn: $$DocumentExtractionsTableReferences
                            ._documentIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DocumentExtractionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $DocumentExtractionsTable,
      DocumentExtraction,
      $$DocumentExtractionsTableFilterComposer,
      $$DocumentExtractionsTableOrderingComposer,
      $$DocumentExtractionsTableAnnotationComposer,
      $$DocumentExtractionsTableCreateCompanionBuilder,
      $$DocumentExtractionsTableUpdateCompanionBuilder,
      (DocumentExtraction, $$DocumentExtractionsTableReferences),
      DocumentExtraction,
      PrefetchHooks Function({bool documentId})
    >;
typedef $$DocumentChunksTableCreateCompanionBuilder =
    DocumentChunksCompanion Function({
      required String id,
      required String documentId,
      required int ordinal,
      required String body,
      Value<int?> page,
      Value<Uint8List?> embedding,
      Value<int> rowid,
    });
typedef $$DocumentChunksTableUpdateCompanionBuilder =
    DocumentChunksCompanion Function({
      Value<String> id,
      Value<String> documentId,
      Value<int> ordinal,
      Value<String> body,
      Value<int?> page,
      Value<Uint8List?> embedding,
      Value<int> rowid,
    });

final class $$DocumentChunksTableReferences
    extends
        BaseReferences<_$LifeDatabase, $DocumentChunksTable, DocumentChunk> {
  $$DocumentChunksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentsTable _documentIdTable(_$LifeDatabase db) =>
      db.documents.createAlias('document_chunks__document_id__documents__id');

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<String>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentChunksTableFilterComposer
    extends Composer<_$LifeDatabase, $DocumentChunksTable> {
  $$DocumentChunksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get embedding => $composableBuilder(
    column: $table.embedding,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentChunksTableOrderingComposer
    extends Composer<_$LifeDatabase, $DocumentChunksTable> {
  $$DocumentChunksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get embedding => $composableBuilder(
    column: $table.embedding,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentChunksTableAnnotationComposer
    extends Composer<_$LifeDatabase, $DocumentChunksTable> {
  $$DocumentChunksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);

  GeneratedColumn<Uint8List> get embedding =>
      $composableBuilder(column: $table.embedding, builder: (column) => column);

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentChunksTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $DocumentChunksTable,
          DocumentChunk,
          $$DocumentChunksTableFilterComposer,
          $$DocumentChunksTableOrderingComposer,
          $$DocumentChunksTableAnnotationComposer,
          $$DocumentChunksTableCreateCompanionBuilder,
          $$DocumentChunksTableUpdateCompanionBuilder,
          (DocumentChunk, $$DocumentChunksTableReferences),
          DocumentChunk,
          PrefetchHooks Function({bool documentId})
        > {
  $$DocumentChunksTableTableManager(
    _$LifeDatabase db,
    $DocumentChunksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentChunksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentChunksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentChunksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentId = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int?> page = const Value.absent(),
                Value<Uint8List?> embedding = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentChunksCompanion(
                id: id,
                documentId: documentId,
                ordinal: ordinal,
                body: body,
                page: page,
                embedding: embedding,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentId,
                required int ordinal,
                required String body,
                Value<int?> page = const Value.absent(),
                Value<Uint8List?> embedding = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentChunksCompanion.insert(
                id: id,
                documentId: documentId,
                ordinal: ordinal,
                body: body,
                page: page,
                embedding: embedding,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentChunksTable, DocumentChunk>(table),
                  $$DocumentChunksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (documentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.documentId,
                        referencedTable: $$DocumentChunksTableReferences
                            ._documentIdTable(db),
                        referencedColumn: $$DocumentChunksTableReferences
                            ._documentIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DocumentChunksTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $DocumentChunksTable,
      DocumentChunk,
      $$DocumentChunksTableFilterComposer,
      $$DocumentChunksTableOrderingComposer,
      $$DocumentChunksTableAnnotationComposer,
      $$DocumentChunksTableCreateCompanionBuilder,
      $$DocumentChunksTableUpdateCompanionBuilder,
      (DocumentChunk, $$DocumentChunksTableReferences),
      DocumentChunk,
      PrefetchHooks Function({bool documentId})
    >;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  required String id,
  required Source source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  required String title,
  Value<String?> notes,
  Value<TaskStatus> status,
  Value<Priority> priority,
  Value<DateTime?> dueAt,
  Value<bool> allDay,
  Value<String?> recurrenceRule,
  Value<String?> projectEntityId,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<String> id,
  Value<Source> source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> title,
  Value<String?> notes,
  Value<TaskStatus> status,
  Value<Priority> priority,
  Value<DateTime?> dueAt,
  Value<bool> allDay,
  Value<String?> recurrenceRule,
  Value<String?> projectEntityId,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

final class $$TasksTableReferences
    extends BaseReferences<_$LifeDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EntitiesTable _projectEntityIdTable(_$LifeDatabase db) =>
      db.entities.createAlias('tasks__project_entity_id__entities__id');

  $$EntitiesTableProcessedTableManager? get projectEntityId {
    final $_column = $_itemColumn<String>('project_entity_id');
    if ($_column == null) return null;
    final manager = $$EntitiesTableTableManager(
      $_db,
      $_db.entities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectEntityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CommitmentsTable, List<Commitment>>
  _commitmentsRefsTable(_$LifeDatabase db) => MultiTypedResultKey.fromTable(
    db.commitments,
    aliasName: 'tasks__id__commitments__task_id',
  );

  $$CommitmentsTableProcessedTableManager get commitmentsRefs {
    final manager = $$CommitmentsTableTableManager(
      $_db,
      $_db.commitments,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_commitmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$LifeDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Source, Source, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sensitivity, Sensitivity, int>
  get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TaskStatus, TaskStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Priority, Priority, int> get priority =>
      $composableBuilder(
        column: $table.priority,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceRule => $composableBuilder(
    column: $table.recurrenceRule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EntitiesTableFilterComposer get projectEntityId {
    final $$EntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectEntityId,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableFilterComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> commitmentsRefs(
    Expression<bool> Function($$CommitmentsTableFilterComposer f) f,
  ) {
    final $$CommitmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.commitments,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommitmentsTableFilterComposer(
            $db: $db,
            $table: $db.commitments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$LifeDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceRule => $composableBuilder(
    column: $table.recurrenceRule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EntitiesTableOrderingComposer get projectEntityId {
    final $$EntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectEntityId,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$LifeDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Source, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Sensitivity, int> get sensitivity =>
      $composableBuilder(
        column: $table.sensitivity,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaskStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Priority, int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<String> get recurrenceRule => $composableBuilder(
    column: $table.recurrenceRule,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$EntitiesTableAnnotationComposer get projectEntityId {
    final $$EntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectEntityId,
      referencedTable: $db.entities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.entities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> commitmentsRefs<T extends Object>(
    Expression<T> Function($$CommitmentsTableAnnotationComposer a) f,
  ) {
    final $$CommitmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.commitments,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommitmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.commitments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, $$TasksTableReferences),
          Task,
          PrefetchHooks Function({bool projectEntityId, bool commitmentsRefs})
        > {
  $$TasksTableTableManager(_$LifeDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Source> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<TaskStatus> status = const Value.absent(),
                Value<Priority> priority = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<String?> recurrenceRule = const Value.absent(),
                Value<String?> projectEntityId = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                title: title,
                notes: notes,
                status: status,
                priority: priority,
                dueAt: dueAt,
                allDay: allDay,
                recurrenceRule: recurrenceRule,
                projectEntityId: projectEntityId,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Source source,
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String title,
                Value<String?> notes = const Value.absent(),
                Value<TaskStatus> status = const Value.absent(),
                Value<Priority> priority = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<String?> recurrenceRule = const Value.absent(),
                Value<String?> projectEntityId = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                title: title,
                notes: notes,
                status: status,
                priority: priority,
                dueAt: dueAt,
                allDay: allDay,
                recurrenceRule: recurrenceRule,
                projectEntityId: projectEntityId,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TasksTable, Task>(table),
                  $$TasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({projectEntityId = false, commitmentsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (commitmentsRefs) db.commitments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectEntityId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.projectEntityId,
                            referencedTable: $$TasksTableReferences
                                ._projectEntityIdTable(db),
                            referencedColumn: $$TasksTableReferences
                                ._projectEntityIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (commitmentsRefs)
                        await $_getPrefetchedData<
                          Task,
                          $TasksTable,
                          Commitment
                        >(
                          currentTable: table,
                          referencedTable: $$TasksTableReferences
                              ._commitmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TasksTableReferences(
                                db,
                                table,
                                p0,
                              ).commitmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.taskId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, $$TasksTableReferences),
      Task,
      PrefetchHooks Function({bool projectEntityId, bool commitmentsRefs})
    >;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  required String id,
  required Source source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  required String title,
  required DateTime startsAt,
  Value<DateTime?> endsAt,
  Value<String?> location,
  Value<String?> recurrenceRule,
  Value<String?> externalRef,
  Value<int> rowid,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<String> id,
  Value<Source> source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> title,
  Value<DateTime> startsAt,
  Value<DateTime?> endsAt,
  Value<String?> location,
  Value<String?> recurrenceRule,
  Value<String?> externalRef,
  Value<int> rowid,
});

class $$EventsTableFilterComposer
    extends Composer<_$LifeDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Source, Source, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sensitivity, Sensitivity, int>
  get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceRule => $composableBuilder(
    column: $table.recurrenceRule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalRef => $composableBuilder(
    column: $table.externalRef,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventsTableOrderingComposer
    extends Composer<_$LifeDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceRule => $composableBuilder(
    column: $table.recurrenceRule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalRef => $composableBuilder(
    column: $table.externalRef,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Source, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Sensitivity, int> get sensitivity =>
      $composableBuilder(
        column: $table.sensitivity,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startsAt =>
      $composableBuilder(column: $table.startsAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endsAt =>
      $composableBuilder(column: $table.endsAt, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get recurrenceRule => $composableBuilder(
    column: $table.recurrenceRule,
    builder: (column) => column,
  );

  GeneratedColumn<String> get externalRef => $composableBuilder(
    column: $table.externalRef,
    builder: (column) => column,
  );
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, BaseReferences<_$LifeDatabase, $EventsTable, Event>),
          Event,
          PrefetchHooks Function()
        > {
  $$EventsTableTableManager(_$LifeDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Source> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> startsAt = const Value.absent(),
                Value<DateTime?> endsAt = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> recurrenceRule = const Value.absent(),
                Value<String?> externalRef = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                title: title,
                startsAt: startsAt,
                endsAt: endsAt,
                location: location,
                recurrenceRule: recurrenceRule,
                externalRef: externalRef,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Source source,
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String title,
                required DateTime startsAt,
                Value<DateTime?> endsAt = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> recurrenceRule = const Value.absent(),
                Value<String?> externalRef = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                title: title,
                startsAt: startsAt,
                endsAt: endsAt,
                location: location,
                recurrenceRule: recurrenceRule,
                externalRef: externalRef,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EventsTable, Event>(table),
                  BaseReferences<_$LifeDatabase, $EventsTable, Event>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, BaseReferences<_$LifeDatabase, $EventsTable, Event>),
      Event,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required Source source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  required String title,
  required DateTime fireAt,
  Value<String?> targetId,
  Value<String> status,
  Value<DateTime?> snoozedUntil,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<Source> source,
  Value<String?> sourceRef,
  Value<double> confidence,
  Value<Sensitivity> sensitivity,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> title,
  Value<DateTime> fireAt,
  Value<String?> targetId,
  Value<String> status,
  Value<DateTime?> snoozedUntil,
  Value<int> rowid,
});

class $$RemindersTableFilterComposer
    extends Composer<_$LifeDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Source, Source, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sensitivity, Sensitivity, int>
  get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableOrderingComposer
    extends Composer<_$LifeDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fireAt => $composableBuilder(
    column: $table.fireAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$LifeDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Source, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Sensitivity, int> get sensitivity =>
      $composableBuilder(
        column: $table.sensitivity,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get fireAt =>
      $composableBuilder(column: $table.fireAt, builder: (column) => column);

  GeneratedColumn<String> get targetId =>
      $composableBuilder(column: $table.targetId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => column,
  );
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, BaseReferences<_$LifeDatabase, $RemindersTable, Reminder>),
          Reminder,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableManager(_$LifeDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Source> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> fireAt = const Value.absent(),
                Value<String?> targetId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                title: title,
                fireAt: fireAt,
                targetId: targetId,
                status: status,
                snoozedUntil: snoozedUntil,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Source source,
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String title,
                required DateTime fireAt,
                Value<String?> targetId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                title: title,
                fireAt: fireAt,
                targetId: targetId,
                status: status,
                snoozedUntil: snoozedUntil,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, Reminder>(table),
                  BaseReferences<_$LifeDatabase, $RemindersTable, Reminder>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, BaseReferences<_$LifeDatabase, $RemindersTable, Reminder>),
      Reminder,
      PrefetchHooks Function()
    >;
typedef $$CommitmentsTableCreateCompanionBuilder =
    CommitmentsCompanion Function({
      required String id,
      required Source source,
      Value<String?> sourceRef,
      Value<double> confidence,
      Value<Sensitivity> sensitivity,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      required String description,
      Value<String?> counterparty,
      Value<DateTime?> dueAt,
      Value<String> status,
      Value<String?> taskId,
      Value<int> rowid,
    });
typedef $$CommitmentsTableUpdateCompanionBuilder =
    CommitmentsCompanion Function({
      Value<String> id,
      Value<Source> source,
      Value<String?> sourceRef,
      Value<double> confidence,
      Value<Sensitivity> sensitivity,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> description,
      Value<String?> counterparty,
      Value<DateTime?> dueAt,
      Value<String> status,
      Value<String?> taskId,
      Value<int> rowid,
    });

final class $$CommitmentsTableReferences
    extends BaseReferences<_$LifeDatabase, $CommitmentsTable, Commitment> {
  $$CommitmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIdTable(_$LifeDatabase db) =>
      db.tasks.createAlias('commitments__task_id__tasks__id');

  $$TasksTableProcessedTableManager? get taskId {
    final $_column = $_itemColumn<String>('task_id');
    if ($_column == null) return null;
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CommitmentsTableFilterComposer
    extends Composer<_$LifeDatabase, $CommitmentsTable> {
  $$CommitmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Source, Source, int> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sensitivity, Sensitivity, int>
  get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get counterparty => $composableBuilder(
    column: $table.counterparty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CommitmentsTableOrderingComposer
    extends Composer<_$LifeDatabase, $CommitmentsTable> {
  $$CommitmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRef => $composableBuilder(
    column: $table.sourceRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sensitivity => $composableBuilder(
    column: $table.sensitivity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get counterparty => $composableBuilder(
    column: $table.counterparty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableOrderingComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CommitmentsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $CommitmentsTable> {
  $$CommitmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Source, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceRef =>
      $composableBuilder(column: $table.sourceRef, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Sensitivity, int> get sensitivity =>
      $composableBuilder(
        column: $table.sensitivity,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get counterparty => $composableBuilder(
    column: $table.counterparty,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CommitmentsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $CommitmentsTable,
          Commitment,
          $$CommitmentsTableFilterComposer,
          $$CommitmentsTableOrderingComposer,
          $$CommitmentsTableAnnotationComposer,
          $$CommitmentsTableCreateCompanionBuilder,
          $$CommitmentsTableUpdateCompanionBuilder,
          (Commitment, $$CommitmentsTableReferences),
          Commitment,
          PrefetchHooks Function({bool taskId})
        > {
  $$CommitmentsTableTableManager(_$LifeDatabase db, $CommitmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommitmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommitmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommitmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<Source> source = const Value.absent(),
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> counterparty = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> taskId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommitmentsCompanion(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                description: description,
                counterparty: counterparty,
                dueAt: dueAt,
                status: status,
                taskId: taskId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required Source source,
                Value<String?> sourceRef = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<Sensitivity> sensitivity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String description,
                Value<String?> counterparty = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> taskId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CommitmentsCompanion.insert(
                id: id,
                source: source,
                sourceRef: sourceRef,
                confidence: confidence,
                sensitivity: sensitivity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                description: description,
                counterparty: counterparty,
                dueAt: dueAt,
                status: status,
                taskId: taskId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CommitmentsTable, Commitment>(table),
                  $$CommitmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.taskId,
                        referencedTable: $$CommitmentsTableReferences
                            ._taskIdTable(db),
                        referencedColumn: $$CommitmentsTableReferences
                            ._taskIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CommitmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $CommitmentsTable,
      Commitment,
      $$CommitmentsTableFilterComposer,
      $$CommitmentsTableOrderingComposer,
      $$CommitmentsTableAnnotationComposer,
      $$CommitmentsTableCreateCompanionBuilder,
      $$CommitmentsTableUpdateCompanionBuilder,
      (Commitment, $$CommitmentsTableReferences),
      Commitment,
      PrefetchHooks Function({bool taskId})
    >;
typedef $$PermissionsTableCreateCompanionBuilder =
    PermissionsCompanion Function({
      required String capability,
      required bool granted,
      Value<bool> autonomous,
      Value<String> scope,
      required String grantedVia,
      required DateTime grantedAt,
      Value<DateTime?> expiresAt,
      Value<int> rowid,
    });
typedef $$PermissionsTableUpdateCompanionBuilder =
    PermissionsCompanion Function({
      Value<String> capability,
      Value<bool> granted,
      Value<bool> autonomous,
      Value<String> scope,
      Value<String> grantedVia,
      Value<DateTime> grantedAt,
      Value<DateTime?> expiresAt,
      Value<int> rowid,
    });

class $$PermissionsTableFilterComposer
    extends Composer<_$LifeDatabase, $PermissionsTable> {
  $$PermissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get capability => $composableBuilder(
    column: $table.capability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get granted => $composableBuilder(
    column: $table.granted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autonomous => $composableBuilder(
    column: $table.autonomous,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grantedVia => $composableBuilder(
    column: $table.grantedVia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get grantedAt => $composableBuilder(
    column: $table.grantedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PermissionsTableOrderingComposer
    extends Composer<_$LifeDatabase, $PermissionsTable> {
  $$PermissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get capability => $composableBuilder(
    column: $table.capability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get granted => $composableBuilder(
    column: $table.granted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autonomous => $composableBuilder(
    column: $table.autonomous,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grantedVia => $composableBuilder(
    column: $table.grantedVia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get grantedAt => $composableBuilder(
    column: $table.grantedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PermissionsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $PermissionsTable> {
  $$PermissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get capability => $composableBuilder(
    column: $table.capability,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get granted =>
      $composableBuilder(column: $table.granted, builder: (column) => column);

  GeneratedColumn<bool> get autonomous => $composableBuilder(
    column: $table.autonomous,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get grantedVia => $composableBuilder(
    column: $table.grantedVia,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get grantedAt =>
      $composableBuilder(column: $table.grantedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$PermissionsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $PermissionsTable,
          PermissionGrantRow,
          $$PermissionsTableFilterComposer,
          $$PermissionsTableOrderingComposer,
          $$PermissionsTableAnnotationComposer,
          $$PermissionsTableCreateCompanionBuilder,
          $$PermissionsTableUpdateCompanionBuilder,
          (
            PermissionGrantRow,
            BaseReferences<
              _$LifeDatabase,
              $PermissionsTable,
              PermissionGrantRow
            >,
          ),
          PermissionGrantRow,
          PrefetchHooks Function()
        > {
  $$PermissionsTableTableManager(_$LifeDatabase db, $PermissionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PermissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PermissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PermissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> capability = const Value.absent(),
                Value<bool> granted = const Value.absent(),
                Value<bool> autonomous = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String> grantedVia = const Value.absent(),
                Value<DateTime> grantedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PermissionsCompanion(
                capability: capability,
                granted: granted,
                autonomous: autonomous,
                scope: scope,
                grantedVia: grantedVia,
                grantedAt: grantedAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String capability,
                required bool granted,
                Value<bool> autonomous = const Value.absent(),
                Value<String> scope = const Value.absent(),
                required String grantedVia,
                required DateTime grantedAt,
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PermissionsCompanion.insert(
                capability: capability,
                granted: granted,
                autonomous: autonomous,
                scope: scope,
                grantedVia: grantedVia,
                grantedAt: grantedAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PermissionsTable, PermissionGrantRow>(table),
                  BaseReferences<
                    _$LifeDatabase,
                    $PermissionsTable,
                    PermissionGrantRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PermissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $PermissionsTable,
      PermissionGrantRow,
      $$PermissionsTableFilterComposer,
      $$PermissionsTableOrderingComposer,
      $$PermissionsTableAnnotationComposer,
      $$PermissionsTableCreateCompanionBuilder,
      $$PermissionsTableUpdateCompanionBuilder,
      (
        PermissionGrantRow,
        BaseReferences<_$LifeDatabase, $PermissionsTable, PermissionGrantRow>,
      ),
      PermissionGrantRow,
      PrefetchHooks Function()
    >;
typedef $$AgentRunsTableCreateCompanionBuilder = AgentRunsCompanion Function({
  required String id,
  required String trigger,
  Value<String?> model,
  Value<String?> promptVersion,
  Value<int> inputTokens,
  Value<int> outputTokens,
  Value<int?> latencyMs,
  required String status,
  required DateTime startedAt,
  Value<DateTime?> finishedAt,
  Value<int> rowid,
});
typedef $$AgentRunsTableUpdateCompanionBuilder = AgentRunsCompanion Function({
  Value<String> id,
  Value<String> trigger,
  Value<String?> model,
  Value<String?> promptVersion,
  Value<int> inputTokens,
  Value<int> outputTokens,
  Value<int?> latencyMs,
  Value<String> status,
  Value<DateTime> startedAt,
  Value<DateTime?> finishedAt,
  Value<int> rowid,
});

final class $$AgentRunsTableReferences
    extends BaseReferences<_$LifeDatabase, $AgentRunsTable, AgentRun> {
  $$AgentRunsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AgentActionsTable, List<AgentActionRow>>
  _agentActionsRefsTable(_$LifeDatabase db) => MultiTypedResultKey.fromTable(
    db.agentActions,
    aliasName: 'agent_runs__id__agent_actions__run_id',
  );

  $$AgentActionsTableProcessedTableManager get agentActionsRefs {
    final manager = $$AgentActionsTableTableManager(
      $_db,
      $_db.agentActions,
    ).filter((f) => f.runId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_agentActionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AgentRunsTableFilterComposer
    extends Composer<_$LifeDatabase, $AgentRunsTable> {
  $$AgentRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get latencyMs => $composableBuilder(
    column: $table.latencyMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> agentActionsRefs(
    Expression<bool> Function($$AgentActionsTableFilterComposer f) f,
  ) {
    final $$AgentActionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.agentActions,
      getReferencedColumn: (t) => t.runId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentActionsTableFilterComposer(
            $db: $db,
            $table: $db.agentActions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AgentRunsTableOrderingComposer
    extends Composer<_$LifeDatabase, $AgentRunsTable> {
  $$AgentRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get latencyMs => $composableBuilder(
    column: $table.latencyMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AgentRunsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $AgentRunsTable> {
  $$AgentRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inputTokens => $composableBuilder(
    column: $table.inputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get latencyMs =>
      $composableBuilder(column: $table.latencyMs, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  Expression<T> agentActionsRefs<T extends Object>(
    Expression<T> Function($$AgentActionsTableAnnotationComposer a) f,
  ) {
    final $$AgentActionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.agentActions,
      getReferencedColumn: (t) => t.runId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentActionsTableAnnotationComposer(
            $db: $db,
            $table: $db.agentActions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AgentRunsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $AgentRunsTable,
          AgentRun,
          $$AgentRunsTableFilterComposer,
          $$AgentRunsTableOrderingComposer,
          $$AgentRunsTableAnnotationComposer,
          $$AgentRunsTableCreateCompanionBuilder,
          $$AgentRunsTableUpdateCompanionBuilder,
          (AgentRun, $$AgentRunsTableReferences),
          AgentRun,
          PrefetchHooks Function({bool agentActionsRefs})
        > {
  $$AgentRunsTableTableManager(_$LifeDatabase db, $AgentRunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgentRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgentRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgentRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> trigger = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> promptVersion = const Value.absent(),
                Value<int> inputTokens = const Value.absent(),
                Value<int> outputTokens = const Value.absent(),
                Value<int?> latencyMs = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgentRunsCompanion(
                id: id,
                trigger: trigger,
                model: model,
                promptVersion: promptVersion,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                latencyMs: latencyMs,
                status: status,
                startedAt: startedAt,
                finishedAt: finishedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String trigger,
                Value<String?> model = const Value.absent(),
                Value<String?> promptVersion = const Value.absent(),
                Value<int> inputTokens = const Value.absent(),
                Value<int> outputTokens = const Value.absent(),
                Value<int?> latencyMs = const Value.absent(),
                required String status,
                required DateTime startedAt,
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgentRunsCompanion.insert(
                id: id,
                trigger: trigger,
                model: model,
                promptVersion: promptVersion,
                inputTokens: inputTokens,
                outputTokens: outputTokens,
                latencyMs: latencyMs,
                status: status,
                startedAt: startedAt,
                finishedAt: finishedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AgentRunsTable, AgentRun>(table),
                  $$AgentRunsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({agentActionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (agentActionsRefs) db.agentActions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (agentActionsRefs)
                    await $_getPrefetchedData<
                      AgentRun,
                      $AgentRunsTable,
                      AgentActionRow
                    >(
                      currentTable: table,
                      referencedTable: $$AgentRunsTableReferences
                          ._agentActionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AgentRunsTableReferences(
                            db,
                            table,
                            p0,
                          ).agentActionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.runId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AgentRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $AgentRunsTable,
      AgentRun,
      $$AgentRunsTableFilterComposer,
      $$AgentRunsTableOrderingComposer,
      $$AgentRunsTableAnnotationComposer,
      $$AgentRunsTableCreateCompanionBuilder,
      $$AgentRunsTableUpdateCompanionBuilder,
      (AgentRun, $$AgentRunsTableReferences),
      AgentRun,
      PrefetchHooks Function({bool agentActionsRefs})
    >;
typedef $$AgentActionsTableCreateCompanionBuilder =
    AgentActionsCompanion Function({
      required String id,
      required String runId,
      required String tool,
      required String args,
      required String argsHash,
      required String risk,
      required ActionState state,
      Value<String?> blockReason,
      Value<String?> resultRef,
      Value<String?> errorCode,
      required DateTime createdAt,
      Value<DateTime?> decidedAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$AgentActionsTableUpdateCompanionBuilder =
    AgentActionsCompanion Function({
      Value<String> id,
      Value<String> runId,
      Value<String> tool,
      Value<String> args,
      Value<String> argsHash,
      Value<String> risk,
      Value<ActionState> state,
      Value<String?> blockReason,
      Value<String?> resultRef,
      Value<String?> errorCode,
      Value<DateTime> createdAt,
      Value<DateTime?> decidedAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

final class $$AgentActionsTableReferences
    extends BaseReferences<_$LifeDatabase, $AgentActionsTable, AgentActionRow> {
  $$AgentActionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AgentRunsTable _runIdTable(_$LifeDatabase db) =>
      db.agentRuns.createAlias('agent_actions__run_id__agent_runs__id');

  $$AgentRunsTableProcessedTableManager get runId {
    final $_column = $_itemColumn<String>('run_id')!;

    final manager = $$AgentRunsTableTableManager(
      $_db,
      $_db.agentRuns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_runIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AgentActionsTableFilterComposer
    extends Composer<_$LifeDatabase, $AgentActionsTable> {
  $$AgentActionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tool => $composableBuilder(
    column: $table.tool,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get args => $composableBuilder(
    column: $table.args,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get argsHash => $composableBuilder(
    column: $table.argsHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get risk => $composableBuilder(
    column: $table.risk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ActionState, ActionState, int> get state =>
      $composableBuilder(
        column: $table.state,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get blockReason => $composableBuilder(
    column: $table.blockReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultRef => $composableBuilder(
    column: $table.resultRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get decidedAt => $composableBuilder(
    column: $table.decidedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AgentRunsTableFilterComposer get runId {
    final $$AgentRunsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.runId,
      referencedTable: $db.agentRuns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentRunsTableFilterComposer(
            $db: $db,
            $table: $db.agentRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgentActionsTableOrderingComposer
    extends Composer<_$LifeDatabase, $AgentActionsTable> {
  $$AgentActionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tool => $composableBuilder(
    column: $table.tool,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get args => $composableBuilder(
    column: $table.args,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get argsHash => $composableBuilder(
    column: $table.argsHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get risk => $composableBuilder(
    column: $table.risk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockReason => $composableBuilder(
    column: $table.blockReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultRef => $composableBuilder(
    column: $table.resultRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get decidedAt => $composableBuilder(
    column: $table.decidedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AgentRunsTableOrderingComposer get runId {
    final $$AgentRunsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.runId,
      referencedTable: $db.agentRuns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentRunsTableOrderingComposer(
            $db: $db,
            $table: $db.agentRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgentActionsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $AgentActionsTable> {
  $$AgentActionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tool =>
      $composableBuilder(column: $table.tool, builder: (column) => column);

  GeneratedColumn<String> get args =>
      $composableBuilder(column: $table.args, builder: (column) => column);

  GeneratedColumn<String> get argsHash =>
      $composableBuilder(column: $table.argsHash, builder: (column) => column);

  GeneratedColumn<String> get risk =>
      $composableBuilder(column: $table.risk, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ActionState, int> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get blockReason => $composableBuilder(
    column: $table.blockReason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resultRef =>
      $composableBuilder(column: $table.resultRef, builder: (column) => column);

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get decidedAt =>
      $composableBuilder(column: $table.decidedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$AgentRunsTableAnnotationComposer get runId {
    final $$AgentRunsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.runId,
      referencedTable: $db.agentRuns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgentRunsTableAnnotationComposer(
            $db: $db,
            $table: $db.agentRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgentActionsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $AgentActionsTable,
          AgentActionRow,
          $$AgentActionsTableFilterComposer,
          $$AgentActionsTableOrderingComposer,
          $$AgentActionsTableAnnotationComposer,
          $$AgentActionsTableCreateCompanionBuilder,
          $$AgentActionsTableUpdateCompanionBuilder,
          (AgentActionRow, $$AgentActionsTableReferences),
          AgentActionRow,
          PrefetchHooks Function({bool runId})
        > {
  $$AgentActionsTableTableManager(_$LifeDatabase db, $AgentActionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgentActionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgentActionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgentActionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> runId = const Value.absent(),
                Value<String> tool = const Value.absent(),
                Value<String> args = const Value.absent(),
                Value<String> argsHash = const Value.absent(),
                Value<String> risk = const Value.absent(),
                Value<ActionState> state = const Value.absent(),
                Value<String?> blockReason = const Value.absent(),
                Value<String?> resultRef = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> decidedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgentActionsCompanion(
                id: id,
                runId: runId,
                tool: tool,
                args: args,
                argsHash: argsHash,
                risk: risk,
                state: state,
                blockReason: blockReason,
                resultRef: resultRef,
                errorCode: errorCode,
                createdAt: createdAt,
                decidedAt: decidedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String runId,
                required String tool,
                required String args,
                required String argsHash,
                required String risk,
                required ActionState state,
                Value<String?> blockReason = const Value.absent(),
                Value<String?> resultRef = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> decidedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgentActionsCompanion.insert(
                id: id,
                runId: runId,
                tool: tool,
                args: args,
                argsHash: argsHash,
                risk: risk,
                state: state,
                blockReason: blockReason,
                resultRef: resultRef,
                errorCode: errorCode,
                createdAt: createdAt,
                decidedAt: decidedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AgentActionsTable, AgentActionRow>(table),
                  $$AgentActionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({runId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (runId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.runId,
                        referencedTable: $$AgentActionsTableReferences
                            ._runIdTable(db),
                        referencedColumn: $$AgentActionsTableReferences
                            ._runIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AgentActionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $AgentActionsTable,
      AgentActionRow,
      $$AgentActionsTableFilterComposer,
      $$AgentActionsTableOrderingComposer,
      $$AgentActionsTableAnnotationComposer,
      $$AgentActionsTableCreateCompanionBuilder,
      $$AgentActionsTableUpdateCompanionBuilder,
      (AgentActionRow, $$AgentActionsTableReferences),
      AgentActionRow,
      PrefetchHooks Function({bool runId})
    >;
typedef $$SuggestionsTableCreateCompanionBuilder =
    SuggestionsCompanion Function({
      required String id,
      required String detector,
      required String subjectId,
      required String reasonCode,
      required String explanationFacts,
      Value<DateTime?> dueAt,
      required DateTime surfacedAt,
      Value<DateTime?> dismissedAt,
      Value<DateTime?> snoozedUntil,
      Value<int> rowid,
    });
typedef $$SuggestionsTableUpdateCompanionBuilder =
    SuggestionsCompanion Function({
      Value<String> id,
      Value<String> detector,
      Value<String> subjectId,
      Value<String> reasonCode,
      Value<String> explanationFacts,
      Value<DateTime?> dueAt,
      Value<DateTime> surfacedAt,
      Value<DateTime?> dismissedAt,
      Value<DateTime?> snoozedUntil,
      Value<int> rowid,
    });

class $$SuggestionsTableFilterComposer
    extends Composer<_$LifeDatabase, $SuggestionsTable> {
  $$SuggestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detector => $composableBuilder(
    column: $table.detector,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasonCode => $composableBuilder(
    column: $table.reasonCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanationFacts => $composableBuilder(
    column: $table.explanationFacts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get surfacedAt => $composableBuilder(
    column: $table.surfacedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuggestionsTableOrderingComposer
    extends Composer<_$LifeDatabase, $SuggestionsTable> {
  $$SuggestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detector => $composableBuilder(
    column: $table.detector,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasonCode => $composableBuilder(
    column: $table.reasonCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanationFacts => $composableBuilder(
    column: $table.explanationFacts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get surfacedAt => $composableBuilder(
    column: $table.surfacedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuggestionsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $SuggestionsTable> {
  $$SuggestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get detector =>
      $composableBuilder(column: $table.detector, builder: (column) => column);

  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get reasonCode => $composableBuilder(
    column: $table.reasonCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get explanationFacts => $composableBuilder(
    column: $table.explanationFacts,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<DateTime> get surfacedAt => $composableBuilder(
    column: $table.surfacedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dismissedAt => $composableBuilder(
    column: $table.dismissedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => column,
  );
}

class $$SuggestionsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $SuggestionsTable,
          Suggestion,
          $$SuggestionsTableFilterComposer,
          $$SuggestionsTableOrderingComposer,
          $$SuggestionsTableAnnotationComposer,
          $$SuggestionsTableCreateCompanionBuilder,
          $$SuggestionsTableUpdateCompanionBuilder,
          (
            Suggestion,
            BaseReferences<_$LifeDatabase, $SuggestionsTable, Suggestion>,
          ),
          Suggestion,
          PrefetchHooks Function()
        > {
  $$SuggestionsTableTableManager(_$LifeDatabase db, $SuggestionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuggestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuggestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuggestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> detector = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> reasonCode = const Value.absent(),
                Value<String> explanationFacts = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<DateTime> surfacedAt = const Value.absent(),
                Value<DateTime?> dismissedAt = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuggestionsCompanion(
                id: id,
                detector: detector,
                subjectId: subjectId,
                reasonCode: reasonCode,
                explanationFacts: explanationFacts,
                dueAt: dueAt,
                surfacedAt: surfacedAt,
                dismissedAt: dismissedAt,
                snoozedUntil: snoozedUntil,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String detector,
                required String subjectId,
                required String reasonCode,
                required String explanationFacts,
                Value<DateTime?> dueAt = const Value.absent(),
                required DateTime surfacedAt,
                Value<DateTime?> dismissedAt = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuggestionsCompanion.insert(
                id: id,
                detector: detector,
                subjectId: subjectId,
                reasonCode: reasonCode,
                explanationFacts: explanationFacts,
                dueAt: dueAt,
                surfacedAt: surfacedAt,
                dismissedAt: dismissedAt,
                snoozedUntil: snoozedUntil,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SuggestionsTable, Suggestion>(table),
                  BaseReferences<_$LifeDatabase, $SuggestionsTable, Suggestion>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuggestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $SuggestionsTable,
      Suggestion,
      $$SuggestionsTableFilterComposer,
      $$SuggestionsTableOrderingComposer,
      $$SuggestionsTableAnnotationComposer,
      $$SuggestionsTableCreateCompanionBuilder,
      $$SuggestionsTableUpdateCompanionBuilder,
      (
        Suggestion,
        BaseReferences<_$LifeDatabase, $SuggestionsTable, Suggestion>,
      ),
      Suggestion,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableCreateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  required String actor,
  required String action,
  Value<String?> targetType,
  Value<String?> targetId,
  required String outcome,
  required DateTime at,
});
typedef $$AuditLogsTableUpdateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  Value<String> actor,
  Value<String> action,
  Value<String?> targetType,
  Value<String?> targetId,
  Value<String> outcome,
  Value<DateTime> at,
});

class $$AuditLogsTableFilterComposer
    extends Composer<_$LifeDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$LifeDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get actor =>
      $composableBuilder(column: $table.actor, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetId =>
      $composableBuilder(column: $table.targetId, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $AuditLogsTable,
          AuditEntry,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (
            AuditEntry,
            BaseReferences<_$LifeDatabase, $AuditLogsTable, AuditEntry>,
          ),
          AuditEntry,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$LifeDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> actor = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String?> targetType = const Value.absent(),
                Value<String?> targetId = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                actor: actor,
                action: action,
                targetType: targetType,
                targetId: targetId,
                outcome: outcome,
                at: at,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String actor,
                required String action,
                Value<String?> targetType = const Value.absent(),
                Value<String?> targetId = const Value.absent(),
                required String outcome,
                required DateTime at,
              }) => AuditLogsCompanion.insert(
                id: id,
                actor: actor,
                action: action,
                targetType: targetType,
                targetId: targetId,
                outcome: outcome,
                at: at,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditLogsTable, AuditEntry>(table),
                  BaseReferences<_$LifeDatabase, $AuditLogsTable, AuditEntry>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $AuditLogsTable,
      AuditEntry,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditEntry, BaseReferences<_$LifeDatabase, $AuditLogsTable, AuditEntry>),
      AuditEntry,
      PrefetchHooks Function()
    >;
typedef $$EmergencyFieldsTableCreateCompanionBuilder =
    EmergencyFieldsCompanion Function({
      required String key,
      required String value,
      Value<bool> showOnCard,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$EmergencyFieldsTableUpdateCompanionBuilder =
    EmergencyFieldsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<bool> showOnCard,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$EmergencyFieldsTableFilterComposer
    extends Composer<_$LifeDatabase, $EmergencyFieldsTable> {
  $$EmergencyFieldsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showOnCard => $composableBuilder(
    column: $table.showOnCard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmergencyFieldsTableOrderingComposer
    extends Composer<_$LifeDatabase, $EmergencyFieldsTable> {
  $$EmergencyFieldsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showOnCard => $composableBuilder(
    column: $table.showOnCard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmergencyFieldsTableAnnotationComposer
    extends Composer<_$LifeDatabase, $EmergencyFieldsTable> {
  $$EmergencyFieldsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<bool> get showOnCard => $composableBuilder(
    column: $table.showOnCard,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EmergencyFieldsTableTableManager
    extends
        RootTableManager<
          _$LifeDatabase,
          $EmergencyFieldsTable,
          EmergencyField,
          $$EmergencyFieldsTableFilterComposer,
          $$EmergencyFieldsTableOrderingComposer,
          $$EmergencyFieldsTableAnnotationComposer,
          $$EmergencyFieldsTableCreateCompanionBuilder,
          $$EmergencyFieldsTableUpdateCompanionBuilder,
          (
            EmergencyField,
            BaseReferences<
              _$LifeDatabase,
              $EmergencyFieldsTable,
              EmergencyField
            >,
          ),
          EmergencyField,
          PrefetchHooks Function()
        > {
  $$EmergencyFieldsTableTableManager(
    _$LifeDatabase db,
    $EmergencyFieldsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmergencyFieldsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmergencyFieldsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmergencyFieldsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<bool> showOnCard = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmergencyFieldsCompanion(
                key: key,
                value: value,
                showOnCard: showOnCard,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<bool> showOnCard = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => EmergencyFieldsCompanion.insert(
                key: key,
                value: value,
                showOnCard: showOnCard,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EmergencyFieldsTable, EmergencyField>(table),
                  BaseReferences<
                    _$LifeDatabase,
                    $EmergencyFieldsTable,
                    EmergencyField
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmergencyFieldsTableProcessedTableManager =
    ProcessedTableManager<
      _$LifeDatabase,
      $EmergencyFieldsTable,
      EmergencyField,
      $$EmergencyFieldsTableFilterComposer,
      $$EmergencyFieldsTableOrderingComposer,
      $$EmergencyFieldsTableAnnotationComposer,
      $$EmergencyFieldsTableCreateCompanionBuilder,
      $$EmergencyFieldsTableUpdateCompanionBuilder,
      (
        EmergencyField,
        BaseReferences<_$LifeDatabase, $EmergencyFieldsTable, EmergencyField>,
      ),
      EmergencyField,
      PrefetchHooks Function()
    >;

class $LifeDatabaseManager {
  final _$LifeDatabase _db;
  $LifeDatabaseManager(this._db);
  $$MemoriesTableTableManager get memories =>
      $$MemoriesTableTableManager(_db, _db.memories);
  $$MemoryVersionsTableTableManager get memoryVersions =>
      $$MemoryVersionsTableTableManager(_db, _db.memoryVersions);
  $$EntitiesTableTableManager get entities =>
      $$EntitiesTableTableManager(_db, _db.entities);
  $$EntityRelationshipsTableTableManager get entityRelationships =>
      $$EntityRelationshipsTableTableManager(_db, _db.entityRelationships);
  $$EntityDatesTableTableManager get entityDates =>
      $$EntityDatesTableTableManager(_db, _db.entityDates);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$DocumentExtractionsTableTableManager get documentExtractions =>
      $$DocumentExtractionsTableTableManager(_db, _db.documentExtractions);
  $$DocumentChunksTableTableManager get documentChunks =>
      $$DocumentChunksTableTableManager(_db, _db.documentChunks);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$CommitmentsTableTableManager get commitments =>
      $$CommitmentsTableTableManager(_db, _db.commitments);
  $$PermissionsTableTableManager get permissions =>
      $$PermissionsTableTableManager(_db, _db.permissions);
  $$AgentRunsTableTableManager get agentRuns =>
      $$AgentRunsTableTableManager(_db, _db.agentRuns);
  $$AgentActionsTableTableManager get agentActions =>
      $$AgentActionsTableTableManager(_db, _db.agentActions);
  $$SuggestionsTableTableManager get suggestions =>
      $$SuggestionsTableTableManager(_db, _db.suggestions);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$EmergencyFieldsTableTableManager get emergencyFields =>
      $$EmergencyFieldsTableTableManager(_db, _db.emergencyFields);
}
