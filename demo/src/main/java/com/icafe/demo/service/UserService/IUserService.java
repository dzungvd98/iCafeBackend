package com.icafe.demo.service.UserService;


import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.dto.UserResponseDTO;
import com.icafe.demo.models.User;
import com.icafe.demo.security.UserPrincipal;

public interface IUserService {
    public User createUser(User user);
    public UserPrincipal findByUsername(String username);
    public PagingDataDTO<UserResponseDTO> getListUsers(String keyword, int page, int size); 
}
