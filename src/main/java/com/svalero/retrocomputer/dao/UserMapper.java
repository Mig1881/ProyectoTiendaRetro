package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.User;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserMapper implements RowMapper<User> {

    @Override
    public User map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new User(rs.getInt("id_user"),
                rs.getString("name"),
                rs.getString("username"),
                rs.getString("password"),
                rs.getString("role"),
                rs.getString("tel"),
                rs.getString("address"),
                rs.getString("zip_code"),
                rs.getString("city"),
                rs.getString("country"));

    }


}
