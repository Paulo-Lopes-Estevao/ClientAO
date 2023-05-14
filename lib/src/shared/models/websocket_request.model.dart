import 'package:client_ao/src/shared/constants/enums.dart';
import 'package:client_ao/src/shared/models/base_request.interface.dart';
import 'package:client_ao/src/shared/models/key_value_row.model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'websocket_request.model.g.dart';

@HiveType(typeId: 7)
class WebSocketRequest extends Equatable implements BaseRequestModel {
  @HiveField(0)
  @override
  final String? url;

  @HiveField(1)
  @override
  final String? body;

  @HiveField(2)
  @override
  final HttpVerb method;

  @HiveField(3)
  @override
  final List<KeyValueRow>? headers;

  @HiveField(4)
  @override
  final List<KeyValueRow>? urlParams;

  @HiveField(5)
  @override
  final String? name;

  @HiveField(6)
  @override
  final String? folderId;

  const WebSocketRequest({
    this.url,
    this.body,
    this.method = HttpVerb.get,
    this.headers,
    this.urlParams,
    this.name,
    this.folderId,
  });
  @override
  WebSocketRequest copyWith({
    Uri? uri,
    String? url,
    String? body,
    HttpVerb? method,
    List<KeyValueRow>? headers,
    List<KeyValueRow>? urlParams,
    String? name,
    String? folderId,
  }) {
    return WebSocketRequest(
      url: url ?? this.url,
      body: body ?? this.body,
      name: name ?? this.name,
      folderId: folderId ?? this.folderId,
      method: method ?? this.method,
      headers: headers ?? this.headers,
      urlParams: urlParams ?? this.urlParams,
    );
  }

  @override
  List<Object?> get props => [url, body, name, folderId, method, headers, urlParams];
}
