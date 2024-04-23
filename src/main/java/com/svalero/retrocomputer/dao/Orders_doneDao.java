package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.Orders_done;
import com.svalero.retrocomputer.domain.Products;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.sql.Date;
import java.util.List;

public interface Orders_doneDao {

    @SqlQuery("SELECT * FROM orders_done WHERE id_user = ?")
    @UseRowMapper(Orders_doneMapper.class)
    List<Orders_done> getOrders_doneByUser(int id_user);

    @SqlQuery("SELECT * FROM orders_done WHERE id_order = ?")
    @UseRowMapper(Orders_doneMapper.class)
    Orders_done getOrders_done(int id_order);

    @SqlUpdate("INSERT INTO orders_done (order_date, total_price, id_user, id_product) VALUES (?, ?, ?, ?)")
    int addOrders_done(Date order_date,float total_price, int id_user,int id_product);

}
