import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';

part 'campaign.freezed.dart';
part 'campaign.g.dart';

@freezed
class Campaign with _$Campaign {
  const Campaign._();

  const factory Campaign({
    required String id,
    required String clientId,
    String? clientDisplayName,
    required String title,
    String? description,
    required double budgetMin,
    required double budgetMax,
    required CampaignStatus status,
    @Default([]) List<String> categories,
    @Default([]) List<Platform> platforms,
    DateTime? startDate,
    DateTime? endDate,
    String? imageUrl,
    String? requirements,
    String? targetAudience,
    @Default(0) int applicantCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Campaign;

  /// Alias for clientDisplayName
  String? get clientName => clientDisplayName;

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);
}

@freezed
class CreateCampaignRequest with _$CreateCampaignRequest {
  const factory CreateCampaignRequest({
    required String title,
    String? description,
    required double budgetMin,
    required double budgetMax,
    @Default([]) List<String> categories,
    @Default([]) List<Platform> platforms,
    DateTime? startDate,
    DateTime? endDate,
  }) = _CreateCampaignRequest;

  factory CreateCampaignRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCampaignRequestFromJson(json);
}

@freezed
class UpdateCampaignRequest with _$UpdateCampaignRequest {
  const factory UpdateCampaignRequest({
    String? title,
    String? description,
    double? budgetMin,
    double? budgetMax,
    CampaignStatus? status,
    List<String>? categories,
    List<Platform>? platforms,
    DateTime? startDate,
    DateTime? endDate,
  }) = _UpdateCampaignRequest;

  factory UpdateCampaignRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCampaignRequestFromJson(json);
}
