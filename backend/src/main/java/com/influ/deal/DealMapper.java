package com.influ.deal;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.influ.deal.dto.DealResponse;
import com.influ.deal.dto.DealTermsResponse;
import com.influ.deal.dto.DeliverableResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import java.util.List;

@Mapper(componentModel = "spring")
public interface DealMapper {

    ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    @Mapping(target = "campaignId", source = "campaign.id")
    @Mapping(target = "campaignTitle", source = "campaign.title")
    @Mapping(target = "influencerId", source = "influencer.id")
    @Mapping(target = "influencerDisplayName", source = "influencer.profile.displayName")
    @Mapping(target = "clientId", source = "client.id")
    @Mapping(target = "clientDisplayName", source = "client.profile.displayName")
    @Mapping(target = "currentTerms", expression = "java(toTermsResponse(deal.getCurrentTerms()))")
    DealResponse toDealResponse(Deal deal);

    @Mapping(target = "dealId", source = "deal.id")
    @Mapping(target = "proposedById", source = "proposedBy.id")
    @Mapping(target = "proposedByDisplayName", source = "proposedBy.profile.displayName")
    @Mapping(target = "deliverables", source = "deliverables", qualifiedByName = "parseDeliverables")
    DealTermsResponse toTermsResponse(DealTerms terms);

    @Named("parseDeliverables")
    default JsonNode parseDeliverables(String deliverables) {
        if (deliverables == null || deliverables.isBlank()) {
            return OBJECT_MAPPER.createArrayNode();
        }
        try {
            return OBJECT_MAPPER.readTree(deliverables);
        } catch (Exception e) {
            return OBJECT_MAPPER.createArrayNode();
        }
    }

    DeliverableResponse toDeliverableResponse(Deliverable deliverable);

    List<DeliverableResponse> toDeliverableResponseList(List<Deliverable> deliverables);
}
