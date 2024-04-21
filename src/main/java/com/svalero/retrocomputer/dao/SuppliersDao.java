package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.Suppliers;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface SuppliersDao {
    @SqlQuery("SELECT * FROM suppliers order by id_supplier")
    @UseRowMapper(SuppliersMapper.class)
    List<Suppliers> getAllSuppliers();

    @SqlQuery("SELECT * FROM suppliers WHERE id_supplier = ?")
    @UseRowMapper(SuppliersMapper.class)
    Suppliers getOneSuppliers(int id_supllier);

    @SqlQuery("SELECT * FROM suppliers WHERE name LIKE '%'||:searchTerm||'%'" +
            "OR city LIKE '%'||:searchTerm||'%' OR email LIKE '%'||:searchTerm||'%'")
    @UseRowMapper(SuppliersMapper.class)
    List<Suppliers> getSuppliers(@Bind("searchTerm") String searchTerm);

    //Updates
    @SqlUpdate("INSERT INTO suppliers (name, tel, address,zip_code,city,country,website,email) VALUES (?,?,?,?,?,?,?,?)")
    int addSupliers(String name,String tel, String address, String zip_code, String city,String country ,String website,String email);
    @SqlUpdate("DELETE FROM suppliers WHERE id_supplier = ?")
    int removeSuppliers(int id_supplier);
    @SqlUpdate("UPDATE suppliers set name =?, tel=?, address = ?,zip_code = ?,city= ?,country= ?,website= ?,email= ? WHERE id_supplier = ?")
    int updateSuppliers(String name,String tel,String address,String zip_code,String city,String country,String website,String email, int id_supplier);

}
