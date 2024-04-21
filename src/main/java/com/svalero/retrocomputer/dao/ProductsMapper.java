package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.Products;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;


public class ProductsMapper implements RowMapper<Products> {

    @Override
    public Products map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Products(rs.getInt("id_product"),
                rs.getString("product_name"),
                rs.getString("description"),
                rs.getFloat("sale_price"),
                rs.getInt("stock_units"),
                rs.getString("image"),
                rs.getDate("release_date"),
                rs.getString("product_status"),
                rs.getInt("id_supplier"));
    }


}

