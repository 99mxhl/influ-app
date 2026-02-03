import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum UserType {
  @JsonValue('INFLUENCER')
  influencer('INFLUENCER'),
  @JsonValue('CLIENT')
  client('CLIENT');

  final String value;
  const UserType(this.value);
}

@JsonEnum(valueField: 'value')
enum CampaignStatus {
  @JsonValue('DRAFT')
  draft('DRAFT'),
  @JsonValue('ACTIVE')
  active('ACTIVE'),
  @JsonValue('PAUSED')
  paused('PAUSED'),
  @JsonValue('COMPLETED')
  completed('COMPLETED'),
  @JsonValue('CANCELLED')
  cancelled('CANCELLED');

  final String value;
  const CampaignStatus(this.value);

  String get displayName {
    switch (this) {
      case CampaignStatus.draft:
        return 'Draft';
      case CampaignStatus.active:
        return 'Active';
      case CampaignStatus.paused:
        return 'Paused';
      case CampaignStatus.completed:
        return 'Completed';
      case CampaignStatus.cancelled:
        return 'Cancelled';
    }
  }
}

@JsonEnum(valueField: 'value')
enum Platform {
  @JsonValue('INSTAGRAM')
  instagram('INSTAGRAM'),
  @JsonValue('TIKTOK')
  tiktok('TIKTOK'),
  @JsonValue('YOUTUBE')
  youtube('YOUTUBE'),
  @JsonValue('TWITTER')
  twitter('TWITTER');

  final String value;
  const Platform(this.value);

  String get displayName {
    switch (this) {
      case Platform.instagram:
        return 'Instagram';
      case Platform.tiktok:
        return 'TikTok';
      case Platform.youtube:
        return 'YouTube';
      case Platform.twitter:
        return 'X';
    }
  }
}

@JsonEnum(valueField: 'value')
enum DealStatus {
  @JsonValue('IDLE')
  idle('IDLE'),
  @JsonValue('INVITED')
  invited('INVITED'),
  @JsonValue('APPLIED')
  applied('APPLIED'),
  @JsonValue('NEGOTIATING')
  negotiating('NEGOTIATING'),
  @JsonValue('TERMS_ACCEPTED')
  termsAccepted('TERMS_ACCEPTED'),
  @JsonValue('ACTIVE')
  active('ACTIVE'),
  @JsonValue('CONTENT_SUBMITTED')
  contentSubmitted('CONTENT_SUBMITTED'),
  @JsonValue('COMPLETED')
  completed('COMPLETED'),
  @JsonValue('DISPUTED')
  disputed('DISPUTED'),
  @JsonValue('CANCELLED')
  cancelled('CANCELLED');

  final String value;
  const DealStatus(this.value);

  String get displayName {
    switch (this) {
      case DealStatus.idle:
        return 'Idle';
      case DealStatus.invited:
        return 'Invited';
      case DealStatus.applied:
        return 'Applied';
      case DealStatus.negotiating:
        return 'Negotiating';
      case DealStatus.termsAccepted:
        return 'Terms Accepted';
      case DealStatus.active:
        return 'Active';
      case DealStatus.contentSubmitted:
        return 'Content Submitted';
      case DealStatus.completed:
        return 'Completed';
      case DealStatus.disputed:
        return 'Disputed';
      case DealStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive => this == DealStatus.active ||
                        this == DealStatus.contentSubmitted ||
                        this == DealStatus.negotiating ||
                        this == DealStatus.termsAccepted;
}

@JsonEnum(valueField: 'value')
enum DealTermsStatus {
  @JsonValue('PROPOSED')
  proposed('PROPOSED'),
  @JsonValue('ACCEPTED')
  accepted('ACCEPTED'),
  @JsonValue('REJECTED')
  rejected('REJECTED'),
  @JsonValue('SUPERSEDED')
  superseded('SUPERSEDED');

  final String value;
  const DealTermsStatus(this.value);

  String get displayName {
    switch (this) {
      case DealTermsStatus.proposed:
        return 'Proposed';
      case DealTermsStatus.accepted:
        return 'Accepted';
      case DealTermsStatus.rejected:
        return 'Rejected';
      case DealTermsStatus.superseded:
        return 'Superseded';
    }
  }
}

@JsonEnum(valueField: 'value')
enum ContentType {
  @JsonValue('POST')
  post('POST'),
  @JsonValue('STORY')
  story('STORY'),
  @JsonValue('REEL')
  reel('REEL'),
  @JsonValue('VIDEO')
  video('VIDEO');

  final String value;
  const ContentType(this.value);

  String get displayName {
    switch (this) {
      case ContentType.post:
        return 'Post';
      case ContentType.story:
        return 'Story';
      case ContentType.reel:
        return 'Reel';
      case ContentType.video:
        return 'Video';
    }
  }
}

@JsonEnum(valueField: 'value')
enum DeliverableStatus {
  @JsonValue('PENDING')
  pending('PENDING'),
  @JsonValue('SUBMITTED')
  submitted('SUBMITTED'),
  @JsonValue('APPROVED')
  approved('APPROVED'),
  @JsonValue('REJECTED')
  rejected('REJECTED'),
  @JsonValue('REVISION_REQUESTED')
  revisionRequested('REVISION_REQUESTED');

  final String value;
  const DeliverableStatus(this.value);

  String get displayName {
    switch (this) {
      case DeliverableStatus.pending:
        return 'Pending';
      case DeliverableStatus.submitted:
        return 'Submitted';
      case DeliverableStatus.approved:
        return 'Approved';
      case DeliverableStatus.rejected:
        return 'Rejected';
      case DeliverableStatus.revisionRequested:
        return 'Revision Requested';
    }
  }
}
