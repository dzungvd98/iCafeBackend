package com.icafe.demo.service.UserService;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.icafe.demo.specification.UserSpecification;

import jakarta.persistence.EntityExistsException;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private IRoleRepository roleRepository;

    private final String ROLE_STAFF = "STAFF";

    @Override
    public User createUser(UserDTO user) {
        User found = userRepository.findByUsername(user.getUsername());
        if (found != null) throw new EntityExistsException("Username already exist!");
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
        return userRepository.save(newUser);
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
            User userCreated = userRepository.findById(user.getCreatedBy()).get();
            User userUpdated = userRepository.findById(user.getUpdatedBy()).get();
            return UserResponseDTO.builder()
                    .username(user.getUsername())
                    .role(user.getRole().getRoleName().toString())
                    .timeCreated(user.getCreatedAt().format(formatter))
                    .updatedAt(user.getUpdatedAt().format(formatter))
                    .createdBy(userCreated.getUsername())
                    .updatedBy(userUpdated.getUsername())
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

}
