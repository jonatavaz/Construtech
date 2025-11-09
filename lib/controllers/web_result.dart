class WebResult<T> {
  T? data;
  String? message;
  bool isSuccess = false;
  int? statusCode;

  WebResult.success(this.data, {this.message, this.statusCode})
    : isSuccess = true;

  WebResult.failure({this.message, this.statusCode})
    : isSuccess = false,
      data = null;

  factory WebResult.fromMap(
    Map<String, dynamic> map, {
    T? Function(Object? data)? fromJson,
  }) {
    bool issuccess = map["isSuccess"] as bool? ?? false;
    int? statuscode = map["statusCode"] as int? ?? 0;
    String? message = map["message"] as String?;

    if (issuccess) {
      T? data;

      if (map["data"] != null) {
        if (fromJson != null) {
          data = fromJson(map["data"]);
        } else {
          data = map["data"] as T?;
        }
      } else {
        data = null;
      }
      return WebResult.success(data, message: message, statusCode: statuscode);
    }

    return WebResult.failure(message: message, statusCode: statuscode);
  }
}
