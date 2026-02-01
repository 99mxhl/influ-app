package com.influ.payment;

import com.influ.payment.dto.PaymentResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface PaymentMapper {

    @Mapping(target = "dealId", source = "deal.id")
    PaymentResponse toPaymentResponse(Payment payment);
}
