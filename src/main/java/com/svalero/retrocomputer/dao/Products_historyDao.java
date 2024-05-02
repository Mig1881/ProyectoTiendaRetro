package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.Products;
import com.svalero.retrocomputer.domain.Products_history;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.sql.Date;
import java.util.List;

public interface Products_historyDao {
    @SqlQuery("SELECT * FROM products_history order by id_product")
    @UseRowMapper(Products_historyMapper.class)
    List<Products_history> getAllProducts_history();


    @SqlUpdate("INSERT INTO products_history (id_product,product_name,description,sale_price," +
            "image,release_date,product_status,id_supplier) VALUES (?,?,?,?,?,?,?,?)")
    int addProducts_history(int id_product,String product_name, String description, float sale_price,
           String image, Date release_date, String product_status, int id_supplier);


    @SqlQuery("SELECT * FROM products_history WHERE id_product = ?")
    @UseRowMapper(Products_historyMapper.class)
    Products_history getOneProducts_history(int id_product);


}
