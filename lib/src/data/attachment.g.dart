// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return Attachment(
    id: json['id'] as String,
    type: _$enumDecode(_$AttachmentTypeEnumMap, json['type']),
    url: Uri.parse(json['url'] as String),
    remoteUrl: json['remote_url'] == null
        ? null
        : Uri.parse(json['remote_url'] as String),
    previewUrl: Uri.parse(json['preview_url'] as String),
    textUrl:
        json['text_url'] == null ? null : Uri.parse(json['text_url'] as String),
    meta: json['meta'],
    description: json['description'] as String,
    blurhash: json['blurhash'] as String,
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

const _$AttachmentTypeEnumMap = {
  AttachmentType.unknown: 'unknown',
  AttachmentType.image: 'image',
  AttachmentType.gifv: 'gifv',
  AttachmentType.video: 'video',
  AttachmentType.audio: 'audio',
};
