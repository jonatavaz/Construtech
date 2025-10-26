class WebResult<T> {
  //Armazena os dados que retornam da API
  T? data;
  //Armazena uma mensagem
  String? message;
  //Armazena se a requisição retornou com
  //sucesso ou não
  bool isSuccess = false;
  //Status Code da requisição Http
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
    bool issuccess = map["isSuccess"] as bool;
    int statuscode = map["statusCode"] as int;
    String message = map["message"] as String;
    if (issuccess) {
      //Chama a função callback para realizar a conversão
      T? data = fromJson != null ? fromJson(map["data"]) : null;

      return WebResult.success(data, message: message, statusCode: statuscode);
    }
    return WebResult.failure(message: message, statusCode: statuscode);
  }
}
