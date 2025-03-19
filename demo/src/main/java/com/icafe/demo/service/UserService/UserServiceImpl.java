package com.icafe.demo.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icafe.demo.models.User;
import com.icafe.demo.repository.IUserRepository;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private IUserRepository userRepository;

    @Override
    public User createUser(User user) {
        return userRepository.saveAndFlush(user);
    }

    // @Override
    // public UserPrincipal findByUsername(String username) {
    //     User user = userRepository.findByUsername(username);
    //     UserPrincipal userPrincipal = new UserPrincipal();
    //     if (null != user) {
    //         Set<String> authorities = new HashSet<>();
    //         if (null != user.getRoles()) user.getRoles().forEach(r -> {
    //             authorities.add(r.getRoleKey());
    //         });

    //         userPrincipal.setUserId(user.getId());
    //         userPrincipal.setUsername(user.getUsername());
    //         userPrincipal.setPassword(user.getPassword());
    //         userPrincipal.setAuthorities(authorities);
    //     }
    //     return userPrincipal;
    // }

}
