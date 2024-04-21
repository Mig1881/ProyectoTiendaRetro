package com.svalero.retrocomputer.servlet;

import com.svalero.retrocomputer.dao.Database;
import com.svalero.retrocomputer.dao.ProductsDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/remove-products")
public class RemoveProducts extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_product = Integer.parseInt(request.getParameter("id_product"));

        try {
            Database.connect();
            int affectedRows = Database.jdbi.withExtension(ProductsDao.class,
                    dao -> dao.removeProducts(id_product));
            response.sendRedirect("index.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
}