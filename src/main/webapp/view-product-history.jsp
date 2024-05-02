<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.domain.Products" %>
<%@ page import="com.svalero.retrocomputer.dao.ProductsDao" %>
<%@ page import="com.svalero.retrocomputer.domain.Products" %>
<%@ page import="com.svalero.retrocomputer.util.CurrencyUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.retrocomputer.util.DateUtils" %>
<%@ page import="com.svalero.retrocomputer.domain.Products_history" %>
<%@ page import="com.svalero.retrocomputer.dao.Products_historyDao" %>
<%@include file="includes/header.jsp"%>
<main>
    <%
        if (request.getSession().getAttribute("id_user") == null) {
            response.sendRedirect("index.jsp");
        }
        //Si no eres un usuario registrado no puedes entrar a esta pagina
        try {
            Database.connect();
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            } catch (SQLException e) {
                throw new RuntimeException(e);
         }
        int id_product = Integer.parseInt(request.getParameter("id_product"));
        Products_history products_history = Database.jdbi.withExtension(Products_historyDao.class, dao -> dao.getOneProducts_history(id_product));
    %>
    <div class="py-5 container">
        <div class="d-grid gap-2 d-md-flex justify-content-md-end ">
            <p class="text-danger"><%= username_init%></p>
        </div>
    </div>

    <div class="container my-3">
        <div class="row">
            <div class="col-sm-12  col-md-4 col-lg-4 col-xl-4 py-4 bg-image2">
                <h3 class="text-danger">Foto del producto</h3>
                <div class="card shadow-sm">
                    <img src="../retro_pictures/<%=products_history.getImage()%>"  alt="<%= products_history.getDescription() %>"/>
                </div>
            </div>
            <div class="col-sm-12  col-md-8 col-lg-8 col-xl-8 py-4 bg-image2">
                <h3 class="text-danger">Datos del Producto</h3>
                <table class="table table-dark table-striped">
                    <tr>
                        <td class="centrado">Nombre</td>
                        <td class="centrado"><%=products_history.getProduct_name()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Descripcion</td>
                        <td class="centrado"><%=products_history.getDescription()%></td>
                    </tr>

                    <tr>
                        <td class="centrado">Fecha de Lanzamiento</td>
                        <td class="centrado"><%=DateUtils.formatUser(products_history.getRelease_date())%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Estado del producto</th>
                        <td class="centrado"><%=products_history.getProduct_status()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Precio</td>
                        <td class="centrado"><%=CurrencyUtils.format(products_history.getSale_price())%></td>
                    </tr>
                </table>
            </div>
        </div>
        <br/>

        <% if (role.equals("admin")){ %>
            <p><a href="all-orders_done.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver a listado de pedidos</a></p>
        <% } else {%>
            <p><a href="index-sales.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver a Mi listado de pedidos</a></p>
        <% }%>
    </div>
</main>

<%@include file="includes/footer.jsp"%>


