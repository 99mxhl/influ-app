package com.influ.user;

import com.influ.common.dto.ApiResponse;
import com.influ.common.dto.PageResponse;
import com.influ.user.dto.InfluencerProfileUpdateRequest;
import com.influ.user.dto.ProfileUpdateRequest;
import com.influ.user.dto.UserResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
@Tag(name = "Users", description = "User management endpoints")
public class UserController {

    private final UserService userService;

    @GetMapping("/users/{id}")
    @Operation(summary = "Get user by ID")
    public ApiResponse<UserResponse> getUserById(@PathVariable UUID id) {
        return ApiResponse.success(userService.getUserById(id));
    }

    @PutMapping("/users/me")
    @Operation(summary = "Update current user's profile")
    public ApiResponse<UserResponse> updateProfile(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody ProfileUpdateRequest request) {
        return ApiResponse.success(userService.updateProfile(currentUser, request));
    }

    @PutMapping("/users/me/influencer")
    @Operation(summary = "Update current user's influencer profile")
    public ApiResponse<UserResponse> updateInfluencerProfile(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody InfluencerProfileUpdateRequest request) {
        return ApiResponse.success(userService.updateInfluencerProfile(currentUser, request));
    }

    @GetMapping("/influencers")
    @Operation(summary = "Search influencers")
    public ApiResponse<PageResponse<UserResponse>> searchInfluencers(
            @RequestParam(required = false) String category,
            @PageableDefault(size = 20) Pageable pageable) {
        return ApiResponse.success(userService.searchInfluencers(category, pageable));
    }
}
