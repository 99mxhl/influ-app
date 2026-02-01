package com.influ.campaign;

import com.influ.campaign.dto.CampaignResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CampaignMapper {

    @Mapping(target = "clientId", source = "client.id")
    @Mapping(target = "clientDisplayName", source = "client.profile.displayName")
    CampaignResponse toCampaignResponse(Campaign campaign);
}
