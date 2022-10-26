
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'dateOfBirth') required String dateOfBirth,
}) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
			_$UserFromJson(json);
}
