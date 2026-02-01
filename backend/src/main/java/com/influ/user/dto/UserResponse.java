package com.influ.user.dto;

import com.influ.user.UserType;
import lombok.Builder;
import lombok.Getter;

import java.util.UUID;

@Getter
@Builder
public class UserResponse {

    private UUID id;
    private String email;
    private UserType type;
    private ProfileResponse profile;
    private InfluencerProfileResponse influencerProfile;
}
