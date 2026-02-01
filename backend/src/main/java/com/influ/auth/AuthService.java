package com.influ.auth;

import com.influ.auth.dto.AuthResponse;
import com.influ.auth.dto.LoginRequest;
import com.influ.auth.dto.RegisterRequest;
import com.influ.common.exception.BusinessRuleViolationException;
import com.influ.common.exception.UnauthorizedException;
import com.influ.user.*;
import com.influ.user.dto.UserResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Locale;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final ProfileRepository profileRepository;
    private final InfluencerProfileRepository influencerProfileRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final UserMapper userMapper;

    @Transactional
    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new BusinessRuleViolationException("Email is already registered");
        }

        User user = new User();
        user.setEmail(request.getEmail().toLowerCase(Locale.ROOT));
        user.setPasswordHash(passwordEncoder.encode(request.getPassword()));
        user.setType(request.getType());
        user = userRepository.save(user);

        Profile profile = new Profile();
        profile.setUser(user);
        profile.setDisplayName(request.getDisplayName() != null ? request.getDisplayName() : "User");
        profileRepository.save(profile);

        if (request.getType() == UserType.INFLUENCER) {
            InfluencerProfile influencerProfile = new InfluencerProfile();
            influencerProfile.setUser(user);
            influencerProfileRepository.save(influencerProfile);
        }

        return generateAuthResponse(user);
    }

    @Transactional
    public AuthResponse login(LoginRequest request) {
        String normalizedEmail = request.getEmail().toLowerCase(Locale.ROOT);
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(normalizedEmail, request.getPassword())
        );

        User user = userRepository.findByEmail(normalizedEmail)
                .orElseThrow(() -> new UnauthorizedException("Invalid credentials"));

        return generateAuthResponse(user);
    }

    @Transactional
    public AuthResponse refresh(String refreshTokenValue) {
        RefreshToken refreshToken = refreshTokenRepository.findByToken(refreshTokenValue)
                .orElseThrow(() -> new UnauthorizedException("Invalid refresh token"));

        if (!refreshToken.isValid()) {
            throw new UnauthorizedException("Refresh token is expired or revoked");
        }

        refreshToken.revoke();
        refreshTokenRepository.save(refreshToken);

        return generateAuthResponse(refreshToken.getUser());
    }

    @Transactional
    public void logout(String refreshTokenValue) {
        refreshTokenRepository.findByToken(refreshTokenValue)
                .ifPresent(token -> {
                    token.revoke();
                    refreshTokenRepository.save(token);
                });
    }

    @Transactional
    public void logoutAll(User user) {
        refreshTokenRepository.revokeAllByUserId(user.getId());
    }

    public UserResponse getCurrentUser(User user) {
        return userMapper.toUserResponse(user);
    }

    private AuthResponse generateAuthResponse(User user) {
        String accessToken = jwtService.generateAccessToken(user.getId(), user.getEmail());
        String refreshTokenValue = jwtService.generateRefreshToken();

        RefreshToken refreshToken = new RefreshToken(
                refreshTokenValue,
                user,
                jwtService.getRefreshTokenExpiration()
        );
        refreshTokenRepository.save(refreshToken);

        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshTokenValue)
                .user(userMapper.toUserResponse(user))
                .build();
    }
}
