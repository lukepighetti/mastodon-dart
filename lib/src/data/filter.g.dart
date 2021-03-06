// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return Filter(
    id: json['id'] as String,
    phrase: json['phrase'] as String,
    context: (json['context'] as List)
        .map((e) => _$enumDecode(_$FilterContextEnumMap, e))
        .toList(),
    expiresAt: json['expires_at'] == null
        ? null
        : DateTime.parse(json['expires_at'] as String),
    irreversible: json['irreversible'] as bool,
    wholeWord: json['whole_word'] as bool,
  );
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$FilterContextEnumMap = {
  FilterContext.home: 'home',
  FilterContext.notifications: 'notifications',
  FilterContext.public: 'public',
  FilterContext.thread: 'thread',
};
