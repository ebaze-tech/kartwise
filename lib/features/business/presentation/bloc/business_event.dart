import 'dart:io';

abstract class BusinessEvent {}

class CreateBusinessEvent extends BusinessEvent {
  final String name;
  final String description;
  final String businessCategoryName;
  final String address;
  final String emailAddress;
  final String phoneNumber;
  final File? bannerImage;
  final bool isActive;

  CreateBusinessEvent({
    required this.name,
    required this.description,
    required this.businessCategoryName,
    required this.address,
    required this.emailAddress,
    required this.phoneNumber,
    required this.bannerImage,
    required this.isActive,
  });
}

class UpdateBusinessEvent extends BusinessEvent {
  final String id;
  final String name;
  final String description;
  final String address;
  final String emailAddress;
  final String phoneNumber;
  final File? bannerImage;
  final bool isActive;
  final String? categoryName;

  UpdateBusinessEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.emailAddress,
    required this.phoneNumber,
    required this.bannerImage,
    required this.isActive,
    this.categoryName,
  });
}


class GetLocalBusinessEvent extends BusinessEvent {}

class GetBusinessProductsEvent extends BusinessEvent {}

class GetBusinessEvent extends BusinessEvent {}
