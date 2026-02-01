package com.influ.user;

import com.influ.user.dto.InfluencerProfileResponse;
import com.influ.user.dto.ProfileResponse;
import com.influ.user.dto.UserResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {

    @Mapping(target = "profile", source = "profile")
    @Mapping(target = "influencerProfile", source = "influencerProfile")
    UserResponse toUserResponse(User user);

    ProfileResponse toProfileResponse(Profile profile);

    InfluencerProfileResponse toInfluencerProfileResponse(InfluencerProfile influencerProfile);
}
