package com.svalero.retrocomputer.servlet;

import com.svalero.retrocomputer.dao.*;
import com.svalero.retrocomputer.domain.Products;
import com.svalero.retrocomputer.domain.Suppliers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/place-an-order")
public class PlaceAnOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_product = Integer.parseInt(request.getParameter("id_product"));
        HttpSession session = request.getSession();
        int id_user = Integer.parseInt(session.getAttribute("id_user").toString());
        String username = session.getAttribute("username").toString();
        try {
            Database.connect();

            Products products = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getOneProducts(id_product));

            Suppliers suplliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getOneSuppliers(products.getId_supplier()));
            final int stock_unitsfinal = 0;
            Database.jdbi.withExtension(Products_historyDao.class, dao -> dao.addProducts_history(products.getId_product(), products.getProduct_name(),
                    products.getDescription(),products.getSale_price(),products.getImage(),products.getRelease_date(), products.getProduct_status(), products.getId_supplier()));

            Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.addOrders_done(new Date(System.currentTimeMillis()),
                    products.getSale_price(),id_product,products.getProduct_name(),suplliers.getName(),id_user,username));

            int affectedRows = Database.jdbi.withExtension(ProductsDao.class,
                    dao -> dao.updateProductsStock(stock_unitsfinal,id_product));

            response.sendRedirect("index-sales.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

}

