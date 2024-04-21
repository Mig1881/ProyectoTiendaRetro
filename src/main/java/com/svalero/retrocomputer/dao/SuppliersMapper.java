package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.Suppliers;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SuppliersMapper implements RowMapper<Suppliers> {
@Override
public Suppliers map(ResultSet rs, StatementContext ctx) throws SQLException {
    return new Suppliers(rs.getInt("id_supplier"),
            rs.getString("name"),
            rs.getString("tel"),
            rs.getString("address"),
            rs.getString("zip_code"),
            rs.getString("city"),
            rs.getString("country"),
            rs.getString("website"),
            rs.getString("email"));

    }

}
