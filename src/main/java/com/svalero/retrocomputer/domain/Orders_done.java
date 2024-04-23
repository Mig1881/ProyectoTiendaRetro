package com.svalero.retrocomputer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Orders_done {
    private int id_order;
    private Date order_date;
    private float total_price;
    private User user;
    private Products products;
}













//CREATE TABLE orders_done (
//        id_order number(9) generated by default as identity,
//order_date date,
//total_price number(7,2),
//id_user number(9),
//id_product number(9),
//constraint orders_done_pk primary key(id_order),
//constraint orders_done_fk_id_user foreign key (id_user) references users,
//constraint orders_done_fk_id_product foreign key (id_product) references products
//);