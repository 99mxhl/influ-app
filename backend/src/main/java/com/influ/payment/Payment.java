package com.influ.payment;

import com.influ.common.entity.BaseEntity;
import com.influ.deal.Deal;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "payments")
@Getter
@Setter
@NoArgsConstructor
public class Payment extends BaseEntity {

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "deal_id", nullable = false, unique = true)
    private Deal deal;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal amount;

    @Column(name = "platform_fee", precision = 10, scale = 2)
    private BigDecimal platformFee;

    @Column(name = "influencer_payout", precision = 10, scale = 2)
    private BigDecimal influencerPayout;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PaymentStatus status = PaymentStatus.PENDING;

    @Column(name = "stripe_payment_intent_id")
    private String stripePaymentIntentId;

    @Column(name = "stripe_transfer_id")
    private String stripeTransferId;

    @Column(name = "failure_reason")
    private String failureReason;
}
