package com.icafe.demo.service.UserService;


import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.dto.UserResponseDTO;
import com.icafe.demo.mapper.PagingMapper;
import com.icafe.demo.models.User;
import com.icafe.demo.repository.IUserRepository;
import com.icafe.demo.security.UserPrincipal;
import com.icafe.demo.specification.UserSpecification;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserRepository userRepository;

    @Override
    public User createUser(User user) {
        return userRepository.saveAndFlush(user);
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

}
