package com.svalero.retrocomputer.servlet;

import com.svalero.retrocomputer.dao.Database;
import com.svalero.retrocomputer.dao.UserDao;
import com.svalero.retrocomputer.domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            Database.connect();
            User user = Database.jdbi.withExtension(UserDao.class,
                    dao -> dao.getUser(username, password));
            //Si llego aqui suponemos que es el usuario correcto, entonces...creo la sesion,
            //pero antes tengo que pregunatar si el usuario existe
            if (user != null) {
                HttpSession session = request.getSession();
                //la sesion se puede recuperar desde cualquier sitio,
                // y le añadimos un atributo, el username y role, que son los permisos que tiene segun tipo de usuario
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());
                session.setAttribute("id_user", user.getId_user());
                //es decir guardo informacion en la sesion y esta la puedo recuperar en cualquier parte de la web
                //simplemete llamando a HttpSession
                response.getWriter().print("ok");

            } else {
                response.getWriter().println("<div class='alert alert-danger' role='alert'>" +
                        "El usuario no existe</div>");
            }
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            response.getWriter().println("<div class='alert alert-danger' role='alert'>" +
                    "Internal Server Error</div>");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            response.getWriter().println("<div class='alert alert-danger' role='alert'>" +
                    "Error conectando con la base de datos</div>");
        }



    }
}

