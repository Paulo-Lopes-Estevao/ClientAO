import 'dart:convert';
import 'package:client_ao/src/shared/constants/enums.dart';
import 'package:client_ao/src/shared/models/pop_up.model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

const bodyMenuOptions = [
  PopupMenuModel(label: 'JSON', method: BodyType.json),
  PopupMenuModel(label: 'XML', method: BodyType.xml),
  PopupMenuModel(label: 'Multipart Form', method: BodyType.multipartForm),
  PopupMenuModel(label: 'Body', method: BodyType.none),
];

const authMethodsOptions = [
  PopupMenuModel(label: 'API Key Auth', displayName: 'API Key', method: AuthMethod.apiKeyAuth),
  PopupMenuModel(label: 'Bearer Token', displayName: 'Bearer', method: AuthMethod.bearerToken),
  PopupMenuModel(label: 'Basic Auth', displayName: 'Basic', method: AuthMethod.basic),
  PopupMenuModel(label: 'No Authentication', displayName: 'Auth', method: AuthMethod.noAuthentication),
];

const collectionMenuOptions = [
  PopupMenuModel(label: 'Add request', displayName: 'New HTTP Request', method: CollectionPopUpItem.addRequest),
  PopupMenuModel(label: 'WebSocket Request', displayName: 'WebSocket Request', method: CollectionPopUpItem.webSocketRequest),
  PopupMenuModel(label: 'Delete', displayName: 'Delete', method: CollectionPopUpItem.delete),
];

const sendMethodsOptions = [
  PopupMenuModel(
    label: 'Send',
    displayName: 'Send',
    icon: Icons.send,
    method: SendPopUpItem.send,
  ),
  PopupMenuModel(
    label: 'Generate code',
    displayName: 'Generate code',
    icon: Icons.code_rounded,
    method: SendPopUpItem.generateCode,
    dividerAfterItem: true,
    dividerLabel: 'Advanced',
  ),
  PopupMenuModel(
    label: 'Send after delay',
    displayName: 'Send after delay',
    icon: Icons.timer_outlined,
    method: SendPopUpItem.sendAfterDelay,
  ),
  PopupMenuModel(
    label: 'Repeat on interval',
    displayName: 'Repeat on interval',
    icon: Icons.replay,
    method: SendPopUpItem.repeatRequest,
  ),
];

const defaultResponseCodeReasons = {
  100: 'Continue',
  101: 'Switching Protocols',
  102: 'Processing',
  103: 'Early Hints',
  200: 'OK',
  201: 'Created',
  202: 'Accepted',
  203: 'Non-Authoritative Information',
  204: 'No Content',
  205: 'Reset Content',
  206: 'Partial Content',
  207: 'Multi-Status',
  208: 'Already Reported',
  226: 'IM Used',
  300: 'Multiple Choices',
  301: 'Moved Permanently',
  302: 'Found',
  303: 'See Other',
  304: 'Not Modified',
  305: 'Use Proxy',
  306: 'Switch Proxy',
  307: 'Temporary Redirect',
  308: 'Permanent Redirect',
  400: 'Bad Request',
  401: 'Unauthorized',
  402: 'Payment Required',
  403: 'Forbidden',
  404: 'Not Found',
  405: 'Method Not Allowed',
  406: 'Not Acceptable',
  407: 'Proxy Authentication Required',
  408: 'Request Timeout',
  409: 'Conflict',
  410: 'Gone',
  411: 'Length Required',
  412: 'Precondition Failed',
  413: 'Payload Too Large',
  414: 'URI Too Long',
  415: 'Unsupported Media Type',
  416: 'Range Not Satisfiable',
  417: 'Expectation Failed',
  418: "I'm a Teapot",
  421: 'Misdirected Request',
  422: 'Unprocessable Entity',
  423: 'Locked',
  424: 'Failed Dependency',
  425: 'Too Early',
  426: 'Upgrade Required',
  428: 'Precondition Required',
  429: 'Too Many Requests',
  431: 'Request Header Fields Too Large',
  451: 'Unavailable For Legal Reasons',
  500: 'Internal Server Error',
  501: 'Not Implemented',
  502: 'Bad Gateway',
  503: 'Service Unavailable',
  504: 'Gateway Timeout',
  505: 'HTTP Version Not Supported',
  506: 'Variant Also Negotiates',
  507: 'Insufficient Storage',
  508: 'Loop Detected',
  510: 'Not Extended',
  511: 'Network Authentication Required',
};

int defaultParamsPadding = 20;
int defaultNodejsHeadersPadding = 8;
const jsonEncoder = JsonEncoder.withIndent(' ');
