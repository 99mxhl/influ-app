package com.influ.config;

import com.influ.user.User;
import com.influ.user.UserRepository;
import com.influ.user.UserType;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    // Dummy hash for constant-time comparison when user not found (BCrypt hash of random string)
    // This prevents timing attacks that could reveal whether an email exists
    private static final String DUMMY_PASSWORD_HASH =
            "$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZRGYNJKtvCE9PJaCjW7xBRWlZzVGu";

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<User> userOpt = userRepository.findByEmailWithProfiles(email.toLowerCase());

        // Return a dummy user when not found to ensure password comparison still happens,
        // preventing timing attacks that reveal email existence.
        // Spring Security will fail authentication after BCrypt comparison.
        return userOpt.orElseGet(this::createDummyUser);
    }

    private User createDummyUser() {
        User dummy = new User();
        dummy.setId(UUID.randomUUID());
        dummy.setEmail("nonexistent@dummy.local");
        dummy.setPasswordHash(DUMMY_PASSWORD_HASH);
        dummy.setType(UserType.CLIENT);
        return dummy;
    }
}
