package com.svalero.retrocomputer.servlet;

import com.svalero.retrocomputer.dao.Database;
import com.svalero.retrocomputer.dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import static com.svalero.retrocomputer.util.ErrorUtils.sendError;


@WebServlet("/edit-user")

public class EditUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");


        try {
            // Si el id es = 0 sera crear uno nuevo sino es modificacion
            int id =0;
            if (request.getParameter("id_user") != null){
              id = Integer.parseInt(request.getParameter("id_user"));
            }


            //Validaciones de los campos del formulario register-product
            if (hasValidationErrors(request, response, id))
                return;
            //Si ha ido bien, pasamos los valores para que se puedan grabar en la BD
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String password="";
            if (request.getParameter("password") != null) {
                password = request.getParameter("password");
            }
            String tel = request.getParameter("tel");
            String address = request.getParameter("address");
            String zip_code = request.getParameter("zip_code");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            String role = "user";
            //solo el administrador es capaz de crear administradores
            HttpSession currentSession = request.getSession();
            if (currentSession.getAttribute("role") != null) {
                if (currentSession.getAttribute("role").equals("admin")) {
                    if (!request.getParameter("role").isBlank()) {
                        role = request.getParameter("role");
                    }
                }
            }


            Database.connect();
            final String finalrole = role;
            final String finalpassword=password;
            if (id ==0) {
                int affectedRows = Database.jdbi.withExtension(UserDao.class,
                        dao -> dao.addUser(name, username, finalpassword, finalrole, tel, address,
                                zip_code, city, country));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                        "Bienvenido¡¡¡ Ya eres un usuario registrado de RetroByte</div>");
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", finalrole);
            } else {
                final int finalid = id;
                int affectedRows = Database.jdbi.withExtension(UserDao.class,
                        dao -> dao.updateUser(name, username, finalrole, tel, address,
                                zip_code, city, country, finalid));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                        "Modificacion de usuario realizada correctamente</div>");

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
    private boolean hasValidationErrors(HttpServletRequest request, HttpServletResponse response,int id) throws IOException {
        boolean hasErrors = false;
        if (request.getParameter("name").isBlank()) {
            sendError("Nombre del ususrio es un campo obligatorio", response);
            hasErrors = true;
        }

        if (request.getParameter("username").isBlank()) {
            sendError("Username es un campo obligatorio", response);
            hasErrors = true;
        }
        //Password solo se valida si es nuevo
        if (id ==0) {
            if (request.getParameter("password").isBlank()) {
                sendError("Password es un campo obligatorio", response);
                hasErrors = true;
            }
        }
        if (request.getParameter("tel").isBlank()) {
            sendError("Telefono es un campo obligatorio", response);
            hasErrors = true;
        }
        if (request.getParameter("address").isBlank()) {
            sendError("Direccion es un campo obligatorio", response);
            hasErrors = true;
        }

        if (request.getParameter("zip_code").isBlank()) {
            sendError("Codigo Postal es un campo obligatorio", response);
            hasErrors = true;
        }
        if (request.getParameter("city").isBlank()) {
            sendError("Ciudad es un campo obligatorio", response);
            hasErrors = true;
        }

        if (request.getParameter("zip_code").isBlank()) {
            sendError("Pais es un campo obligatorio", response);
            hasErrors = true;
        }

        return hasErrors;
    }
}

