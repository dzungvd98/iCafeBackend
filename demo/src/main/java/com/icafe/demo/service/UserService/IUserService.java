package com.icafe.demo.service.UserService;

import com.icafe.demo.models.User;
import com.icafe.demo.security.UserPrincipal;

public interface IUserService {
    public User createUser(User user);
    public UserPrincipal findByUsername(String username);
}
