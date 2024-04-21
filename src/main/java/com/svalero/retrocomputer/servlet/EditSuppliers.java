package com.svalero.retrocomputer.servlet;

import com.svalero.retrocomputer.dao.Database;
import com.svalero.retrocomputer.dao.SuppliersDao;
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


@WebServlet("/edit-suppliers")

public class EditSuppliers extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");


        try {
            // Si el id es = 0 sera crear uno nuevo sino es modificacion
            int id =0;
            if (request.getParameter("id_supplier") != null){
              id = Integer.parseInt(request.getParameter("id_supplier"));
            }


            //Validaciones de los campos del formulario register-product
            if (hasValidationErrors(request, response))
                return;
            //Si ha ido bien, pasamos los valores para que se puedan grabar en la BD
            String name = request.getParameter("name");
            String tel = request.getParameter("tel");
            String address = request.getParameter("address");
            String zip_code = request.getParameter("zip_code");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            String website = request.getParameter("website");
            String email = request.getParameter("email");



            Database.connect();

            if (id ==0) {
                int affectedRows = Database.jdbi.withExtension(SuppliersDao.class,
                        dao -> dao.addSupliers(name, tel, address, zip_code, city, country,
                        website,email));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                        "Proveedor registrado correctamente</div>");
            } else {
                final int finalid = id;
                int affectedRows = Database.jdbi.withExtension(SuppliersDao.class,
                        dao -> dao.updateSuppliers(name, tel, address,
                                zip_code, city, country,website,email, finalid));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                        "Modificacion de Proveedor realizada correctamente</div>");
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
    private boolean hasValidationErrors(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean hasErrors = false;
        if (request.getParameter("name").isBlank()) {
            sendError("Nombre del proveedor es un campo obligatorio", response);
            hasErrors = true;
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

        if (request.getParameter("website").isBlank()) {
            sendError("Website es un campo obligatorio", response);
            hasErrors = true;
        }

        if (request.getParameter("email").isBlank()) {
            sendError("Email es un campo obligatorio", response);
            hasErrors = true;
        }


        return hasErrors;
    }
}

