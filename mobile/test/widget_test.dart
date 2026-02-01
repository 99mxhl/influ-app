import 'package:flutter_test/flutter_test.dart';

import 'package:influ_app/shared/models/enums.dart';

void main() {
  group('DealStatus', () {
    test('cancelled status has correct displayName', () {
      expect(DealStatus.cancelled.displayName, 'Cancelled');
    });

    test('active status has correct displayName', () {
      expect(DealStatus.active.displayName, 'Active');
    });

    test('isActive returns true for active statuses', () {
      expect(DealStatus.active.isActive, true);
      expect(DealStatus.negotiating.isActive, true);
      expect(DealStatus.termsAccepted.isActive, true);
      expect(DealStatus.contentSubmitted.isActive, true);
    });

    test('isActive returns false for inactive statuses', () {
      expect(DealStatus.cancelled.isActive, false);
      expect(DealStatus.completed.isActive, false);
      expect(DealStatus.idle.isActive, false);
    });
  });

  group('DealTermsStatus', () {
    test('proposed status has correct displayName', () {
      expect(DealTermsStatus.proposed.displayName, 'Proposed');
    });

    test('accepted status has correct displayName', () {
      expect(DealTermsStatus.accepted.displayName, 'Accepted');
    });
  });

  group('Platform', () {
    test('all platforms have displayName', () {
      for (final platform in Platform.values) {
        expect(platform.displayName, isNotEmpty);
      }
    });
  });

  group('ContentType', () {
    test('all content types have displayName', () {
      for (final contentType in ContentType.values) {
        expect(contentType.displayName, isNotEmpty);
      }
    });
  });
}
