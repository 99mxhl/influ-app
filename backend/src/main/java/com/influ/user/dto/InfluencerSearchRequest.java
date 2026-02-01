package com.influ.user.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InfluencerSearchRequest {

    private String category;
    private Integer minFollowers;
    private Integer maxFollowers;
}
