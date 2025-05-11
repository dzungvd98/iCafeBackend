package com.icafe.demo.service.UserService;


import java.io.UnsupportedEncodingException;

import com.icafe.demo.dto.PagingDataDTO;
import com.icafe.demo.dto.UserDTO;
import com.icafe.demo.dto.UserRequestDTO;
import com.icafe.demo.dto.UserResponseDTO;
import com.icafe.demo.models.User;
import com.icafe.demo.security.UserPrincipal;

import jakarta.mail.MessagingException;

public interface IUserService {
    public int createUser(UserDTO user) throws UnsupportedEncodingException, MessagingException;
    public UserPrincipal findByUsername(String username);
    public PagingDataDTO<UserResponseDTO> getListUsers(String keyword, int page, int size); 
    public User createUserByAdmin(UserRequestDTO userRequestDTO);
    public User updateUserByAdmin(UserRequestDTO dto);
    public void deleteUserByAdmin(String username);
}
