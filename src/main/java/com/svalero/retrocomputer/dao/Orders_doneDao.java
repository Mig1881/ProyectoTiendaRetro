package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.Orders_done;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;


import java.sql.Date;
import java.util.List;

public interface Orders_doneDao {

    @SqlQuery("SELECT * FROM orders_done WHERE id_user = ? order by id_order,order_date")
    @UseRowMapper(Orders_doneMapper.class)
    List<Orders_done> getOrders_doneByUser(int id_user);

    @SqlQuery("SELECT * FROM orders_done order by order_date, total_price")
    @UseRowMapper(Orders_doneMapper.class)
    List<Orders_done> getAllOrders();

    @SqlQuery("SELECT * FROM orders_done WHERE id_order = ?")
    @UseRowMapper(Orders_doneMapper.class)
    Orders_done getOrders_done(int id_order);
// En Oracle serian asi las busquedas
//    @SqlQuery("SELECT * FROM orders_done WHERE product_name LIKE '%'||:searchTerm||'%'" +
//            "OR supplier_name LIKE '%'||:searchTerm||'%' OR username LIKE '%'||:searchTerm||'%'" +
//            "OR TO_CHAR(order_date, 'DD-MM-YYYY') LIKE '%'||:searchTerm||'%' order by order_date, total_price")
//    @UseRowMapper(Orders_doneMapper.class)
//    List<Orders_done> getOrders(@Bind("searchTerm") String searchTerm);

    @SqlQuery("SELECT * FROM orders_done WHERE product_name LIKE CONCAT ('%',:searchTerm,'%') " +
            "OR supplier_name LIKE CONCAT('%',:searchTerm,'%') OR username LIKE CONCAT('%',:searchTerm,'%') " +
//            "OR TO_CHAR(order_date, 'DD-MM-YYYY') LIKE CONCAT('%',:searchTerm,'%') order by order_date, total_price")
            "OR DATE_FORMAT(order_date,'%d-%m-%Y') LIKE CONCAT('%',:searchTerm,'%') order by order_date, total_price")
    @UseRowMapper(Orders_doneMapper.class)
    List<Orders_done> getOrders(@Bind("searchTerm") String searchTerm);

    @SqlUpdate("INSERT INTO orders_done (order_date, total_price, id_product,product_name," +
            "supplier_name,id_user,username) VALUES (?, ?, ?, ?, ?, ?, ?)")
    int addOrders_done(Date order_date, float total_price, int id_product, String product_name,
                       String supplier_name, int id_user, String username);


}

