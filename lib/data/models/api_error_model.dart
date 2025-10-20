import '../../../core/resources/base_model.dart';

class ApiErrorModel extends BaseModel {
  double? cdErro;
  String? json;
  String? msgErro;
  String? processo;
  String? sistema;

  ApiErrorModel({
    this.cdErro,
    this.json,
    this.msgErro,
    this.processo,
    this.sistema,
  });

  ApiErrorModel.fromJson(Map<String, dynamic> map) {
    cdErro = map['cd_erro'];
    json = map['json'].toString();
    msgErro = map['msg_erro'];
    processo = map['processo'];
    sistema = map['sistema'];
  }

  String? get serverError {
    String erro = '';

    if (cdErro != null) {
      erro = 'ERRO ${cdErro!.toInt()}';
    }

    if (processo != null) {
      erro += '\n$processo';
    }

    return erro.isNotEmpty ? erro : null;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cd_erro'] = cdErro;
    data['json'] = json?.toString();
    data['msg_erro'] = msgErro;
    data['processo'] = processo;
    data['sistema'] = sistema;
    return data;
  }

  @override
  String toString() {
    return 'ApiErrorModel{'
        'cdErro: $cdErro, '
        'json: $json, '
        'msgErro: $msgErro, '
        'processo: $processo, '
        'sistema: $sistema'
        '}';
  }
}
