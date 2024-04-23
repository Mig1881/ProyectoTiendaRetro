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
    //    Products products = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getOneProducts(rs.getInt("id_product")));
    //Atencion
    //Va muy bien hasta que se borra un producto de la BD, muy habitual en mi BD de mi tienda online, puesto son productos de 2ª mano
    //y suelen ser unicos, cada producto tiene un estado y precio que puede ser distinto dependiendo de ese estado.
    //Si borro un producto relacionado con un pedido de la BD da problemas porque no lo encuentra y lo rellena con nulo, asi que para
    //evitar esto y poder guardar informacion de cual fue el producto del pedido que se realizo, lo guardo en campos separados
    //Con el Ususario lo puedo hacer, ya que si no exite no podra acceder
        return new Orders_done(rs.getInt("id_order"),
                rs.getDate("order_date"),
                rs.getFloat("total_price"),
                rs.getInt("id_product"),
                rs.getString("product_name"),
                user);
    }
}
