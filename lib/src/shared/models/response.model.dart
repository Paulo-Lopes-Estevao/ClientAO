import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:client_ao/src/shared/models/base_response.interface.dart';
import 'package:client_ao/src/shared/utils/functions.utils.dart';
import 'package:collection/collection.dart' show mergeMaps;
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
part 'response.model.g.dart';

@HiveType(typeId: 1)
class ResponseModel extends Equatable implements BaseResponseModel {
  const ResponseModel({
    this.statusCode,
    this.headers,
    this.requestUri,
    this.requestHeaders,
    this.contentType,
    this.mediaType,
    this.body,
    this.formattedBody,
    this.bodyBytes,
    this.responseSize,
    this.requestDuration,
  });

  @HiveField(0)
  final int? statusCode;

  @HiveField(1)
  final Map<String, String>? headers;

  @HiveField(2)
  final Map<String, String>? requestHeaders;

  @HiveField(3)
  final String? contentType;

  @HiveField(4)
  final String? mediaType;

  @HiveField(5)
  final String? body;

  @HiveField(6)
  final String? formattedBody;

  @HiveField(7)
  final Uint8List? bodyBytes;

  @HiveField(8)
  final String? requestDuration;

  @HiveField(9)
  final String? requestUri;

  @HiveField(10)
  final String? responseSize;

  factory ResponseModel.fromResponse({
    required Response response,
    Duration? requestDuration,
  }) {
    MediaType? mediaType;
    var contentType = response.headers[HttpHeaders.contentTypeHeader];
    try {
      mediaType = MediaType.parse(contentType!);
    } catch (e) {
      mediaType = null;
    }
    final responseHeaders = mergeMaps(
      {HttpHeaders.contentLengthHeader: response.contentLength.toString()},
      response.headers,
    );

    final body = (mediaType?.subtype == 'json') ? utf8.decode(response.bodyBytes) : response.body;

    int? responseSize = response.contentLength;

    /// If contentLength header was not set
    responseSize ??= response.bodyBytes.length;

    return ResponseModel(
      statusCode: response.statusCode,
      headers: responseHeaders,
      requestUri: response.request?.url.toString(),
      requestHeaders: response.request?.headers,
      contentType: contentType,
      mediaType: mediaType?.subtype,
      body: body,
      formattedBody: formatBody(body, mediaType),
      bodyBytes: response.bodyBytes,
      requestDuration: toHumanizeDuration(requestDuration),
      responseSize: toHumanizeResponseSize(responseSize),
    );
  }

  @override
  List<Object?> get props => [
        statusCode,
        headers,
        requestHeaders,
        contentType,
        mediaType,
        body,
        formattedBody,
        bodyBytes,
        requestDuration,
      ];
}
