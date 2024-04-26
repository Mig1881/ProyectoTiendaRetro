package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.Products;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.sql.Date;
import java.util.List;

public interface ProductsDao {
    @SqlQuery("SELECT * FROM products order by id_product")
    @UseRowMapper(ProductsMapper.class)
    List<Products> getAllProducts();

    @SqlQuery("SELECT * FROM products WHERE product_name LIKE '%'||:searchTerm||'%'" +
            "OR description LIKE '%'||:searchTerm||'%' OR product_status LIKE '%'||:searchTerm||'%'")
    @UseRowMapper(ProductsMapper.class)
    List<Products> getProducts(@Bind("searchTerm") String searchTerm);

    @SqlUpdate("INSERT INTO products (product_name,description,sale_price,image," +
            "release_date,product_status,id_supplier) VALUES (?,?,?,?,?,?,?)")
    int addProducts(String product_name, String description, float sale_price,
                    String image, Date release_date, String product_status, int id_supplier);
    @SqlUpdate("DELETE FROM products WHERE id_supplier = ?")
    int removeProductsSuppliers(int id_supplier);

    @SqlUpdate("DELETE FROM products WHERE id_product = ?")
    int removeProducts(int id_product);


    @SqlQuery("SELECT * FROM products WHERE id_product = ?")
    @UseRowMapper(ProductsMapper.class)
    Products getOneProducts(int id_product);

    @SqlUpdate("UPDATE products SET product_name =?, description=?, sale_price =?, image =?," +
            "release_date=?, product_status=?,id_supplier =? WHERE id_product = ?")
    int updateProducts(String product_name, String description, float sale_price, String image,
                       Date release_date, String product_status, int id_supplier, int id_product);

    @SqlUpdate("UPDATE products SET stock_units =? WHERE id_product = ?")
    int updateProductsStock(int stock_units, int id_product);
}
