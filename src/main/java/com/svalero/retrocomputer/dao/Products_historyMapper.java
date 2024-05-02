package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.Products;
import com.svalero.retrocomputer.domain.Products_history;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;


public class Products_historyMapper implements RowMapper<Products_history> {

    @Override
    public Products_history map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Products_history(rs.getInt("id_product"),
                rs.getString("product_name"),
                rs.getString("description"),
                rs.getFloat("sale_price"),
                rs.getString("image"),
                rs.getDate("release_date"),
                rs.getString("product_status"),
                rs.getInt("id_supplier"));
    }


}
//Se elimina stock_units, ya no tiene sentido su uso en esta tabla.
