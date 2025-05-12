package com.icafe.demo.service.UserService;

import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.dto.UserDTO;
import com.icafe.demo.dto.UserRequestDTO;
import com.icafe.demo.dto.UserResponseDTO;
import com.icafe.demo.mapper.PagingMapper;
import com.icafe.demo.models.Role;
import com.icafe.demo.models.User;
import com.icafe.demo.repository.IRoleRepository;
import com.icafe.demo.repository.IUserRepository;
import com.icafe.demo.security.UserPrincipal;
import com.icafe.demo.service.MailService.MailService;
import com.icafe.demo.specification.UserSpecification;

import jakarta.mail.MessagingException;
import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserServiceImpl implements IUserService {

    private final IUserRepository userRepository;
    private final IRoleRepository roleRepository;
    private final MailService mailService;
    private final String ROLE_STAFF = "STAFF";

    @Override
    public int createUser(UserDTO user) throws UnsupportedEncodingException, MessagingException  {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new EntityExistsException("Username already exists!");
        }
        
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new EntityExistsException("Email have been used!");
        }

        User newUser = new User();
        newUser.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
        newUser.setUsername(user.getUsername());
        Role staffRole = roleRepository.findByRoleName(ROLE_STAFF).get();
        newUser.setRole(staffRole);
        newUser.setCreatedAt(LocalDateTime.now());
        newUser.setUpdatedAt(LocalDateTime.now());
        newUser = userRepository.saveAndFlush(newUser);
        newUser.setCreatedBy(newUser.getId());
        newUser.setUpdatedBy(newUser.getId());
        newUser.setEmail(user.getEmail());
        userRepository.save(newUser);

        
        if(newUser.getId() != null) {
            mailService.sendConfirmLink(newUser.getEmail(), newUser.getId(), "secretCode");
        }

        log.info("User has save!");

        return newUser.getId();
    }

    @Override
    public UserPrincipal findByUsername(String username) {
        User user = userRepository.findByUsername(username);
        UserPrincipal userPrincipal = new UserPrincipal();
        if (null != user) {
            userPrincipal.setUserId(user.getId());
            userPrincipal.setUsername(user.getUsername());
            userPrincipal.setPassword(user.getPassword());
            userPrincipal.setRole(user.getRole().getRoleName());
            userPrincipal.setEmail(user.getEmail());
            userPrincipal.setStatus(user.getStatus());
        }
        return userPrincipal;
    }

    @Override
    public PagingDataDTO<UserResponseDTO> getListUsers(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        Specification<User> spec = UserSpecification.hasSearchKeyWord(keyword);
        Page<User> userPage = userRepository.findAll(spec, pageable);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy");

        return PagingMapper.map(userPage, user -> {
            String usernameCreated = Optional.ofNullable(user.getCreatedBy())
                    .flatMap(userRepository::findById)
                    .map(User::getUsername)
                    .orElse(null);

                    String usernameUpdated = Optional.ofNullable(user.getCreatedBy())
                    .flatMap(userRepository::findById)
                    .map(User::getUsername)
                    .orElse(null);
            return UserResponseDTO.builder()
                    .username(user.getUsername())
                    .role(user.getRole().getRoleName().toString())
                    .timeCreated(user.getCreatedAt().format(formatter))
                    .updatedAt(user.getUpdatedAt().format(formatter))
                    .createdBy(usernameCreated)
                    .updatedBy(usernameUpdated)
                    .build();
        });
    }

    public User createUserByAdmin(UserRequestDTO userRequestDTO) {
        User found = userRepository.findByUsername(userRequestDTO.getUsername());
        if (found != null) throw new EntityExistsException("Username already exist!");
        User newUser = new User();
        newUser.setPassword(new BCryptPasswordEncoder().encode(userRequestDTO.getPassword()));
        newUser.setUsername(userRequestDTO.getUsername());
        Role role = roleRepository.findByRoleName(userRequestDTO.getRole()).get();
        newUser.setRole(role);
        return userRepository.save(newUser);
    }

    @SuppressWarnings("null")
    @Override
    public User updateUserByAdmin(UserRequestDTO dto) {
        User user = userRepository.findByUsername(dto.getUsername());
        if (user == null) throw new EntityExistsException("User not found!");
        if(!dto.getPassword().isBlank() && dto.getPassword() != null) {
            user.setPassword(new BCryptPasswordEncoder().encode(dto.getPassword()));
        }
        Role role = roleRepository.findByRoleName(dto.getRole()).get();
        user.setRole(role);
        return userRepository.save(user);
    }

    @Override
    public void deleteUserByAdmin(String username) {
        User user = userRepository.findByUsername(username);
        if (user == null) throw new EntityExistsException("User not found!");
        user.setDeleted(true);
        userRepository.save(user);
    }

    @Override
    public void confirmUser(int userId, String secretCode) {
        log.info("Confirmed!");
    }

    @Override
    public User getByUserName(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public UserPrincipal getUserByEmail(String email) {
        User user = userRepository.findByEmail(email)
            .orElseThrow(() -> new EntityNotFoundException("Email not found!"));
        UserPrincipal userPrincipal = new UserPrincipal();
        if (null != user) {
            userPrincipal.setUserId(user.getId());
            userPrincipal.setUsername(user.getUsername());
            userPrincipal.setPassword(user.getPassword());
            userPrincipal.setRole(user.getRole().getRoleName());
            userPrincipal.setEmail(user.getEmail());
            userPrincipal.setStatus(user.getStatus());
        }
        return userPrincipal;
    }

}
