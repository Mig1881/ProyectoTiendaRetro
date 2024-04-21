package com.svalero.retrocomputer.servlet;

import com.svalero.retrocomputer.dao.Database;
import com.svalero.retrocomputer.dao.ProductsDao;
import com.svalero.retrocomputer.util.CurrencyUtils;
import com.svalero.retrocomputer.util.DateUtils;
import org.apache.commons.lang3.math.NumberUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.UUID;

import static com.svalero.retrocomputer.util.ErrorUtils.sendError;

@WebServlet("/edit-products")
@MultipartConfig

public class EditProducts extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");


        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") != null) {
            if (!currentSession.getAttribute("role").equals("admin")) {
                response.sendRedirect("/retrocomputer");
            }
        }

        try {
            //Validaciones de los campos del formulario register-product
            if (hasValidationErrors(request, response))
                return;
            //Si ha ido bien, pasamos los valores para que se puedan grabar en la BD
            String product_name = request.getParameter("product_name");
            String description = request.getParameter("description");
            String product_status = request.getParameter("product_status");
            Date release_date = DateUtils.parse(request.getParameter("release_date"));
            float sale_price = CurrencyUtils.parse(request.getParameter("sale_price"));
            int stock_units = Integer.parseInt(request.getParameter("stock_units"));
            int id_supplier = Integer.parseInt(request.getParameter("id_supplier"));

            //gestion de la imagen
            Part picturePart = request.getPart("image");
            // Guardar la imagen en disco
            String imagePath = request.getServletContext().getInitParameter("image-path");
            String filename = null;
            if (picturePart.getSize() == 0) {
                filename = "no_image.jpg";
            } else {
                filename = UUID.randomUUID() + ".jpg";
                InputStream fileStream = picturePart.getInputStream();
                Files.copy(fileStream, Path.of(imagePath + File.separator + filename));
            }
            // Si el id es = 0 sera crear uno nuevo sino es modificacion
            int id =0;
            if (request.getParameter("id_product") != null){
                id = Integer.parseInt(request.getParameter("id_product"));
            }


            Database.connect();
            final String finalFilename = filename;
            if (id ==0) {
                int affectedRows = Database.jdbi.withExtension(ProductsDao.class,
                dao -> dao.addProducts(product_name, description, sale_price, stock_units, finalFilename,
                       release_date,product_status,id_supplier));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                    "Producto Registrado correctamente</div>");
            } else {
                final int finalId=id;
                int affectedRows = Database.jdbi.withExtension(ProductsDao.class,
                dao -> dao.updateProducts(product_name, description, sale_price, stock_units, finalFilename,
                       release_date,product_status,id_supplier,finalId));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                        "Producto modificado correctamente</div>");
            }
        } catch (ParseException pe) {
            pe.printStackTrace();
            response.getWriter().println("<div class='alert alert-danger' role='alert'>" +
                    "El formato de fecha o de precio es no válido</div>");
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
        if (request.getParameter("product_name").isBlank()) {
            sendError("El nombre del producto es un campo obligatorio", response);
            hasErrors = true;
        }

        if (!NumberUtils.isCreatable(request.getParameter("stock_units"))) {
            sendError("Formato de unidades en Stock ha de ser númerico", response);
            hasErrors = true;
        }

        if (!NumberUtils.isCreatable(request.getParameter("id_supplier"))) {
            sendError("Formato del codigo de proveedor no valido, ha de ser numerico", response);
            hasErrors = true;
        }

        try {
            DateUtils.parse(request.getParameter("release_date"));
        } catch (ParseException pe) {
            sendError("Formato de Fecha de lancamiento del producto no valida", response);
            hasErrors = true;
        }
        try {
            float priceValue = CurrencyUtils.parse(request.getParameter("sale_price"));
        } catch (ParseException pe) {
            sendError("Formato de precio no valido", response);
            hasErrors = true;
        }

        return hasErrors;
    }
}



