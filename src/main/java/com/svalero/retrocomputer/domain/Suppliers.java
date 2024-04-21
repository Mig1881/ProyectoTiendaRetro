package com.svalero.retrocomputer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Suppliers {
    private int id_supplier;
    private String name;
    private String tel;
    private String address;
    private String zip_code;
    private String city;
    private String country;
    private String website;
    private String email;
}
