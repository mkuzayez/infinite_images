// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_provider.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _DataProvider implements DataProvider {
  _DataProvider(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.unsplash.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<ImageObject>> getRandomImages() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<ImageObject>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'photos/random?count=10',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<ImageObject> _value;
    try {
      _value = _result.data!
          .map((dynamic i) => ImageObject.fromJson(i as Map<String, dynamic>))
          .toList();
    } on Object {
      rethrow;
    }
    return _value;
  }

  @override
  Future<List<TopicObject>> getTopics() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<TopicObject>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'topics',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<TopicObject> _value;
    try {
      _value = _result.data!
          .map((dynamic i) => TopicObject.fromJson(i as Map<String, dynamic>))
          .toList();
    } on Object {
      rethrow;
    }
    return _value;
  }

  @override
  Future<List<ImageObject>> getTopicImages(String topic) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<ImageObject>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'topics/${topic}/photos',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<ImageObject> _value;
    try {
      _value = _result.data!
          .map((dynamic i) => ImageObject.fromJson(i as Map<String, dynamic>))
          .toList();
    } on Object {
      rethrow;
    }
    return _value;
  }

  @override
Future<List<ImageObject>> searchImages(String query, int page) async {
  final _extra = <String, dynamic>{};
  final queryParameters = <String, dynamic>{r'query': query, r'page': page};
  final _headers = <String, dynamic>{};
  const Map<String, dynamic>? _data = null;

  final _options = _setStreamType<Map<String, dynamic>>(Options(
    method: 'GET',
    headers: _headers,
    extra: _extra,
  ).compose(
    _dio.options,
    'search/photos',
    queryParameters: queryParameters,
    data: _data,
  ).copyWith(
    baseUrl: _combineBaseUrls(
      _dio.options.baseUrl,
      baseUrl,
    ),
  ));

  final _result = await _dio.fetch<Map<String, dynamic>>(_options);

  List<dynamic> results = _result.data?['results'] ?? [];

  return results.map((dynamic i) => ImageObject.fromJson(i as Map<String, dynamic>)).toList();
}

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
