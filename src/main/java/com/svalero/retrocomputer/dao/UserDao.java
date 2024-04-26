package com.svalero.retrocomputer.dao;

import com.svalero.retrocomputer.domain.User;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface UserDao {
    @SqlQuery("SELECT * FROM users")
    @UseRowMapper(UserMapper.class)
    List<User> getAllUsers();

    @SqlQuery("SELECT * FROM users WHERE id_user = ?")
    @UseRowMapper(UserMapper.class)
    User getOneUser(int id_user);

    @SqlQuery("SELECT * FROM users WHERE username = ? AND password = standard_hash(?)")
    @UseRowMapper(UserMapper.class)
    User getUser(String username, String password);
    //Vamos a tener que hacer un acceso teniendo el username que debe se UNIQUE en BD y el password
    //Esto va devolver unicamente una fila unica , ya que el username es UNIQUE
    @SqlQuery("SELECT * FROM users WHERE name LIKE '%'||:searchTerm||'%'" +
            "OR username LIKE '%'||:searchTerm||'%' OR city LIKE '%'||:searchTerm||'%' OR role LIKE '%'||:searchTerm||'%'")
    @UseRowMapper(UserMapper.class)
    List<User> getUsers(@Bind("searchTerm") String searchTerm);

    //Updates
    @SqlUpdate("INSERT INTO users (name, username, password,role,tel,address,zip_code,city,country) VALUES (?,?,standard_hash(?),?,?,?,?,?,?)")
    //   @GetGeneratedKeys
    //La contraseña la cifro justo antes de grabarla en la BD
    int addUser(String name,String username, String password, String role, String tel,String address,String zip_code,String city,String country);
    @SqlUpdate("DELETE FROM users WHERE id_user = ?")
    int removeUser(int id_user);
    @SqlUpdate("UPDATE users set name =?, username=?, password=standard_hash(?), role = ?,tel = ?,address= ?,zip_code= ?,city= ?,country= ? WHERE id_user = ?")
    int updateUser(String name,String username,String password,String role,String tel,String address,String zip_code,String city,String country, int id_user);


}
