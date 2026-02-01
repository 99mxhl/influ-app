import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/enums.dart';

part 'deal.freezed.dart';
part 'deal.g.dart';

@freezed
class Deal with _$Deal {
  const factory Deal({
    required String id,
    required String campaignId,
    required String influencerId,
    required String clientId,
    required DealStatus status,
    double? agreedAmount,
    double? platformFee,
    String? campaignTitle,
    @JsonKey(name: 'influencerDisplayName') String? influencerName,
    @JsonKey(name: 'clientDisplayName') String? clientName,
    DealTerms? currentTerms,
    @Default([]) List<DealTerms> termsHistory,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Deal;

  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);
}

@freezed
class DealTerms with _$DealTerms {
  const factory DealTerms({
    required String id,
    required String dealId,
    required int version,
    required String proposedById,
    required double amount,
    required DealTermsStatus status,
    @Default([]) List<DeliverableSpec> deliverables,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DealTerms;

  factory DealTerms.fromJson(Map<String, dynamic> json) =>
      _$DealTermsFromJson(json);
}

@freezed
class DeliverableSpec with _$DeliverableSpec {
  const factory DeliverableSpec({
    required Platform platform,
    required ContentType contentType,
    required int quantity,
    String? description,
  }) = _DeliverableSpec;

  factory DeliverableSpec.fromJson(Map<String, dynamic> json) =>
      _$DeliverableSpecFromJson(json);
}

@freezed
class ProposeTermsRequest with _$ProposeTermsRequest {
  const factory ProposeTermsRequest({
    required double amount,
    required List<DeliverableSpec> deliverables,
    String? notes,
  }) = _ProposeTermsRequest;

  factory ProposeTermsRequest.fromJson(Map<String, dynamic> json) =>
      _$ProposeTermsRequestFromJson(json);
}

@freezed
class ApplyToCampaignRequest with _$ApplyToCampaignRequest {
  const factory ApplyToCampaignRequest({
    required String campaignId,
    String? message,
  }) = _ApplyToCampaignRequest;

  factory ApplyToCampaignRequest.fromJson(Map<String, dynamic> json) =>
      _$ApplyToCampaignRequestFromJson(json);
}

@freezed
class InviteInfluencerRequest with _$InviteInfluencerRequest {
  const factory InviteInfluencerRequest({
    required String campaignId,
    required String influencerId,
    String? message,
  }) = _InviteInfluencerRequest;

  factory InviteInfluencerRequest.fromJson(Map<String, dynamic> json) =>
      _$InviteInfluencerRequestFromJson(json);
}
