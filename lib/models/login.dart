import 'package:json_annotation/json_annotation.dart';
part 'login.g.dart';

@JsonSerializable()
class LoginRequest {
  final String login;
  final String password;
  @JsonKey(name: 'authenticity_token')
  final String authenticityToken;

  LoginRequest({
    required this.login,
    required this.password,
    required this.authenticityToken,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final String? token;
  final UserData? user;
  final String? error;

  LoginResponse({this.token, this.user, this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserData {
  final int id;
  final String username;
  final String? name;
  @JsonKey(name: 'avatar_template')
  final String? avatarTemplate;
  final String? email;
  @JsonKey(name: 'trust_level')
  final int trustLevel;
  final bool moderator;
  final bool admin;
  @JsonKey(name: 'can_create_topic')
  final bool canCreateTopic;

  UserData({
    required this.id,
    required this.username,
    this.name,
    this.avatarTemplate,
    this.email,
    required this.trustLevel,
    required this.moderator,
    required this.admin,
    required this.canCreateTopic,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
