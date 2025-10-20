import 'package:equatable/equatable.dart';

class RefreshToken extends Equatable {
  final String accessToken;

  const RefreshToken({required this.accessToken});

  factory RefreshToken.fromJson(Map<String, dynamic> json) {
    return RefreshToken(accessToken: json['access_token']);
  }

  @override
  String toString() {
    return 'RefreshToken{accessToken: $accessToken}';
  }

  @override
  List<Object?> get props => [accessToken];
}
