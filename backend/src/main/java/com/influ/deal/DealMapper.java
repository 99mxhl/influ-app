package com.influ.deal;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.influ.deal.dto.DealResponse;
import com.influ.deal.dto.DealTermsResponse;
import com.influ.deal.dto.DeliverableResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Mapper(componentModel = "spring")
public abstract class DealMapper {

    @Autowired
    protected ObjectMapper objectMapper;

    @Mapping(target = "campaignId", source = "campaign.id")
    @Mapping(target = "campaignTitle", source = "campaign.title")
    @Mapping(target = "influencerId", source = "influencer.id")
    @Mapping(target = "influencerDisplayName", source = "influencer.profile.displayName")
    @Mapping(target = "clientId", source = "client.id")
    @Mapping(target = "clientDisplayName", source = "client.profile.displayName")
    @Mapping(target = "currentTerms", expression = "java(toTermsResponse(deal.getCurrentTerms()))")
    public abstract DealResponse toDealResponse(Deal deal);

    @Mapping(target = "dealId", source = "deal.id")
    @Mapping(target = "proposedById", source = "proposedBy.id")
    @Mapping(target = "proposedByDisplayName", source = "proposedBy.profile.displayName")
    @Mapping(target = "deliverables", source = "deliverables", qualifiedByName = "parseDeliverables")
    public abstract DealTermsResponse toTermsResponse(DealTerms terms);

    @Named("parseDeliverables")
    protected JsonNode parseDeliverables(String deliverables) {
        if (deliverables == null || deliverables.isBlank()) {
            return objectMapper.createArrayNode();
        }
        try {
            return objectMapper.readTree(deliverables);
        } catch (Exception e) {
            return objectMapper.createArrayNode();
        }
    }

    @Mapping(target = "dealId", source = "deal.id")
    public abstract DeliverableResponse toDeliverableResponse(Deliverable deliverable);

    public abstract List<DeliverableResponse> toDeliverableResponseList(List<Deliverable> deliverables);
}
