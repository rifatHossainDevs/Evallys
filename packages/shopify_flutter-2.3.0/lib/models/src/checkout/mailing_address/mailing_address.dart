import 'package:freezed_annotation/freezed_annotation.dart';

part 'mailing_address.freezed.dart';
part 'mailing_address.g.dart';

@freezed

/// The mailing address
class MailingAddress with _$MailingAddress {
  /// The mailing address constructor
  factory MailingAddress({
    required String id,
    required String address1,
    required String city,
    required String country,
    String? zip,
    String? lastName,
    String? name,
    String? firstName,
    String? address2,
    String? company,
    String? countryCodeV2,
    String? formattedArea,
    double? latitude,
    double? longitude,
    String? phone,
    String? province,
    String? provinceCode,
  }) = _MailingAddress;

  /// The mailing address from json
  factory MailingAddress.fromJson(Map<String, dynamic> json) =>
      _$MailingAddressFromJson(json);
}
