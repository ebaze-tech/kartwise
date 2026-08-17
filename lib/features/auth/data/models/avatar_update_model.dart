import 'package:campus_cart/features/auth/domain/entities/avatar_update_entity.dart';

class AvatarUpdateModel extends AvatarUpdateEntity {
  AvatarUpdateModel({required super.message});

  factory AvatarUpdateModel.fromJson(Map<String, dynamic> json) {
    return AvatarUpdateModel(message: json['message'] as String);
  }
}
