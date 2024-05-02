package com.svalero.retrocomputer.domain;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@NoArgsConstructor
@Data
@AllArgsConstructor
public class Products_history {
    private int id_product;
    private String product_name;
    private String description;
    private float sale_price;
    private String image;
    private Date release_date;
    private String product_status;
    private int id_supplier;
}

