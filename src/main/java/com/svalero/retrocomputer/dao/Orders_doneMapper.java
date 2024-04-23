package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.Orders_done;
import com.svalero.retrocomputer.domain.Products;
import com.svalero.retrocomputer.domain.User;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Orders_doneMapper implements RowMapper<Orders_done> {
    @Override
    public Orders_done map(ResultSet rs, StatementContext ctx) throws SQLException {
        User user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getOneUser(rs.getInt("id_user")));
        Products products = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getOneProducts(rs.getInt("id_product")));

        return new Orders_done(rs.getInt("id_order"),
                rs.getDate("order_date"),
                rs.getFloat("total_price"),
                user,
                products);
    }
}
