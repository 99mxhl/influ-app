// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DealImpl _$$DealImplFromJson(Map<String, dynamic> json) => _$DealImpl(
      id: json['id'] as String,
      campaignId: json['campaignId'] as String,
      influencerId: json['influencerId'] as String,
      clientId: json['clientId'] as String,
      status: $enumDecode(_$DealStatusEnumMap, json['status']),
      agreedAmount: (json['agreedAmount'] as num?)?.toDouble(),
      platformFee: (json['platformFee'] as num?)?.toDouble(),
      campaignTitle: json['campaignTitle'] as String?,
      influencerName: json['influencerDisplayName'] as String?,
      clientName: json['clientDisplayName'] as String?,
      currentTerms: json['currentTerms'] == null
          ? null
          : DealTerms.fromJson(json['currentTerms'] as Map<String, dynamic>),
      termsHistory: (json['termsHistory'] as List<dynamic>?)
              ?.map((e) => DealTerms.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DealImplToJson(_$DealImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaignId': instance.campaignId,
      'influencerId': instance.influencerId,
      'clientId': instance.clientId,
      'status': _$DealStatusEnumMap[instance.status]!,
      'agreedAmount': instance.agreedAmount,
      'platformFee': instance.platformFee,
      'campaignTitle': instance.campaignTitle,
      'influencerDisplayName': instance.influencerName,
      'clientDisplayName': instance.clientName,
      'currentTerms': instance.currentTerms,
      'termsHistory': instance.termsHistory,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$DealStatusEnumMap = {
  DealStatus.idle: 'IDLE',
  DealStatus.invited: 'INVITED',
  DealStatus.applied: 'APPLIED',
  DealStatus.negotiating: 'NEGOTIATING',
  DealStatus.termsAccepted: 'TERMS_ACCEPTED',
  DealStatus.active: 'ACTIVE',
  DealStatus.contentSubmitted: 'CONTENT_SUBMITTED',
  DealStatus.completed: 'COMPLETED',
  DealStatus.disputed: 'DISPUTED',
  DealStatus.cancelled: 'CANCELLED',
};

_$DealTermsImpl _$$DealTermsImplFromJson(Map<String, dynamic> json) =>
    _$DealTermsImpl(
      id: json['id'] as String,
      dealId: json['dealId'] as String,
      version: (json['version'] as num).toInt(),
      proposedById: json['proposedById'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$DealTermsStatusEnumMap, json['status']),
      deliverables: (json['deliverables'] as List<dynamic>?)
              ?.map((e) => DeliverableSpec.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DealTermsImplToJson(_$DealTermsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dealId': instance.dealId,
      'version': instance.version,
      'proposedById': instance.proposedById,
      'amount': instance.amount,
      'status': _$DealTermsStatusEnumMap[instance.status]!,
      'deliverables': instance.deliverables,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$DealTermsStatusEnumMap = {
  DealTermsStatus.proposed: 'PROPOSED',
  DealTermsStatus.accepted: 'ACCEPTED',
  DealTermsStatus.rejected: 'REJECTED',
  DealTermsStatus.superseded: 'SUPERSEDED',
};

_$DeliverableSpecImpl _$$DeliverableSpecImplFromJson(
        Map<String, dynamic> json) =>
    _$DeliverableSpecImpl(
      platform: $enumDecode(_$PlatformEnumMap, json['platform']),
      contentType: $enumDecode(_$ContentTypeEnumMap, json['contentType']),
      quantity: (json['quantity'] as num).toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$DeliverableSpecImplToJson(
        _$DeliverableSpecImpl instance) =>
    <String, dynamic>{
      'platform': _$PlatformEnumMap[instance.platform]!,
      'contentType': _$ContentTypeEnumMap[instance.contentType]!,
      'quantity': instance.quantity,
      'description': instance.description,
    };

const _$PlatformEnumMap = {
  Platform.instagram: 'INSTAGRAM',
  Platform.tiktok: 'TIKTOK',
  Platform.youtube: 'YOUTUBE',
  Platform.twitter: 'TWITTER',
  Platform.facebook: 'FACEBOOK',
};

const _$ContentTypeEnumMap = {
  ContentType.post: 'POST',
  ContentType.story: 'STORY',
  ContentType.reel: 'REEL',
  ContentType.video: 'VIDEO',
};

_$ProposeTermsRequestImpl _$$ProposeTermsRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ProposeTermsRequestImpl(
      amount: (json['amount'] as num).toDouble(),
      deliverables: (json['deliverables'] as List<dynamic>)
          .map((e) => DeliverableSpec.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ProposeTermsRequestImplToJson(
        _$ProposeTermsRequestImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'deliverables': instance.deliverables,
      'notes': instance.notes,
    };

_$ApplyToCampaignRequestImpl _$$ApplyToCampaignRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplyToCampaignRequestImpl(
      campaignId: json['campaignId'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ApplyToCampaignRequestImplToJson(
        _$ApplyToCampaignRequestImpl instance) =>
    <String, dynamic>{
      'campaignId': instance.campaignId,
      'message': instance.message,
    };

_$InviteInfluencerRequestImpl _$$InviteInfluencerRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$InviteInfluencerRequestImpl(
      campaignId: json['campaignId'] as String,
      influencerId: json['influencerId'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$InviteInfluencerRequestImplToJson(
        _$InviteInfluencerRequestImpl instance) =>
    <String, dynamic>{
      'campaignId': instance.campaignId,
      'influencerId': instance.influencerId,
      'message': instance.message,
    };
