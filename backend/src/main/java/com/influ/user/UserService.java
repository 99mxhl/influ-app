package com.influ.user;

import com.influ.common.dto.PageResponse;
import com.influ.common.exception.BusinessRuleViolationException;
import com.influ.common.exception.ResourceNotFoundException;
import com.influ.user.dto.InfluencerProfileUpdateRequest;
import com.influ.user.dto.ProfileUpdateRequest;
import com.influ.user.dto.UserResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final ProfileRepository profileRepository;
    private final InfluencerProfileRepository influencerProfileRepository;
    private final UserMapper userMapper;

    @Transactional(readOnly = true)
    public UserResponse getUserById(UUID id) {
        User user = userRepository.findByIdWithProfiles(id)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", id));
        return userMapper.toUserResponse(user);
    }

    @Transactional
    public UserResponse updateProfile(User currentUser, ProfileUpdateRequest request) {
        Profile profile = profileRepository.findByUserId(currentUser.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Profile", "userId", currentUser.getId()));

        if (request.getDisplayName() != null) {
            profile.setDisplayName(request.getDisplayName());
        }
        if (request.getAvatarUrl() != null) {
            profile.setAvatarUrl(request.getAvatarUrl());
        }
        if (request.getBio() != null) {
            profile.setBio(request.getBio());
        }

        profileRepository.save(profile);

        User user = userRepository.findByIdWithProfiles(currentUser.getId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", currentUser.getId()));
        return userMapper.toUserResponse(user);
    }

    @Transactional
    public UserResponse updateInfluencerProfile(User currentUser, InfluencerProfileUpdateRequest request) {
        if (currentUser.getType() != UserType.INFLUENCER) {
            throw new BusinessRuleViolationException("Only influencers can update influencer profile");
        }

        InfluencerProfile influencerProfile = influencerProfileRepository.findByUserId(currentUser.getId())
                .orElseThrow(() -> new ResourceNotFoundException("InfluencerProfile", "userId", currentUser.getId()));

        if (request.getCategories() != null) {
            influencerProfile.setCategories(request.getCategories());
        }
        if (request.getBaseRate() != null) {
            influencerProfile.setBaseRate(request.getBaseRate());
        }
        if (request.getInstagramHandle() != null) {
            influencerProfile.setInstagramHandle(request.getInstagramHandle());
        }
        if (request.getInstagramFollowers() != null) {
            influencerProfile.setInstagramFollowers(request.getInstagramFollowers());
        }
        if (request.getTiktokHandle() != null) {
            influencerProfile.setTiktokHandle(request.getTiktokHandle());
        }
        if (request.getTiktokFollowers() != null) {
            influencerProfile.setTiktokFollowers(request.getTiktokFollowers());
        }
        if (request.getYoutubeHandle() != null) {
            influencerProfile.setYoutubeHandle(request.getYoutubeHandle());
        }
        if (request.getYoutubeFollowers() != null) {
            influencerProfile.setYoutubeFollowers(request.getYoutubeFollowers());
        }
        if (request.getTwitterHandle() != null) {
            influencerProfile.setTwitterHandle(request.getTwitterHandle());
        }
        if (request.getTwitterFollowers() != null) {
            influencerProfile.setTwitterFollowers(request.getTwitterFollowers());
        }

        influencerProfileRepository.save(influencerProfile);

        User user = userRepository.findByIdWithProfiles(currentUser.getId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", currentUser.getId()));
        return userMapper.toUserResponse(user);
    }

    @Transactional(readOnly = true)
    public PageResponse<UserResponse> searchInfluencers(String category, Pageable pageable) {
        Page<InfluencerProfile> influencerProfiles;

        if (category != null && !category.isBlank()) {
            influencerProfiles = influencerProfileRepository.findByCategory(category, pageable);
        } else {
            influencerProfiles = influencerProfileRepository.findAllActiveInfluencers(pageable);
        }

        return PageResponse.from(
                influencerProfiles,
                influencerProfiles.getContent().stream()
                        .map(ip -> userMapper.toUserResponse(ip.getUser()))
                        .toList()
        );
    }
}
