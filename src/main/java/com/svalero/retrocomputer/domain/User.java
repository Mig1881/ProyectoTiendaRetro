package com.svalero.retrocomputer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class User {
    private int id_user;
    private String name;
    private String username;
    private String password;
    private String role;
    private String tel;
    private String address;
    private String zip_code;
    private String city;
    private String country;

}






