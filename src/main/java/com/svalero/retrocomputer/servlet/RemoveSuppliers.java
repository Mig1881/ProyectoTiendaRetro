package com.svalero.retrocomputer.servlet;

import com.svalero.retrocomputer.dao.Database;
import com.svalero.retrocomputer.dao.ProductsDao;
import com.svalero.retrocomputer.dao.SuppliersDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/remove-suppliers")
public class RemoveSuppliers extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_supplier = Integer.parseInt(request.getParameter("id_supplier"));

        try {
            Database.connect();
            int affectedRows = Database.jdbi.withExtension(ProductsDao.class,
                    dao -> dao.removeProductsSuppliers(id_supplier));
            int affectedRows1 = Database.jdbi.withExtension(SuppliersDao.class,
                    dao -> dao.removeSuppliers(id_supplier));
            response.sendRedirect("index-suppliers.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

}
