package com.svalero.retrocomputer.servlet;

import com.svalero.retrocomputer.dao.Database;
import com.svalero.retrocomputer.dao.Orders_doneDao;
import com.svalero.retrocomputer.dao.ProductsDao;
import com.svalero.retrocomputer.domain.Products;

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

        try {
            Database.connect();

            Products products = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getOneProducts(id_product));
            Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.addOrders_done(new Date(System.currentTimeMillis()),
                    products.getSale_price(), id_user,id_product, products.getProduct_name()));

            final int stock_unitsfinal = 0;
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
