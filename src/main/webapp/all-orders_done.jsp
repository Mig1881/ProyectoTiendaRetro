<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.domain.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.retrocomputer.dao.ProductsDao" %>
<%@ page import="com.svalero.retrocomputer.dao.UserDao" %>
<%@ page import="com.svalero.retrocomputer.domain.Products" %>
<%@ page import="com.svalero.retrocomputer.domain.Orders_done" %>
<%@ page import="com.svalero.retrocomputer.dao.Orders_doneDao" %>
<%@ page import="com.svalero.retrocomputer.util.CurrencyUtils" %>
<%@ page import="com.svalero.retrocomputer.util.DateUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<script>
    $(document).ready(function () {
        $("#search-input").focus();
    });
</script>

    <main>
            <br/>
            <div class="container bg-dark">
                <h2 class="text-danger">Listado de Pedidos Realizados por Usuarios</h2>

                <br/>
                <form class="row g-2" id="search-form" method="GET">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Buscar en Pedidos" name="search" id="search-input">
                        <button type="submit" class="btn btn-outline-danger"  id="search-button">Buscar</button>
                    </div>
                </form>
            </div>

            <div class="container my-6 bg-dark">

                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Id del Pedido</th>
                        <th>Fecha del Pedido</th>
                        <th>Nombre del Usuario</th>
                        <th>Id del Producto</th>
                        <th>Nombre Producto</th>
                        <th>Nombre del Proveedor</th>
                        <th>Precio Total</th>
                    </tr>
                    </thead>
                    <tbody>

                    <%
                        if (!role.equals("admin")){
                            response.sendRedirect("/retrocomputer");
                        }
                        //Si no eres el administrador no puedes entrar a esta pagina
                        String search = "";
                        if (request.getParameter("search") != null)
                            search = request.getParameter("search");

                        try {
                            Database.connect();
                        } catch (ClassNotFoundException e) {
                            throw new RuntimeException(e);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        List<Orders_done> orders_dones = null;
                        if (search.isEmpty()) {
                            orders_dones = Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.getAllOrders());
                        } else {
                            final String searchTerm = search;
                            orders_dones = Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.getOrders(searchTerm));
                        }

                        for (Orders_done orders_done : orders_dones) {
                    %>

                    <tr>
                        <td><%=orders_done.getId_order()%></td>
                        <td><%=DateUtils.formatUser(orders_done.getOrder_date())%></td>
                        <td><%=orders_done.getUsername()%></td>
                        <td><%=orders_done.getId_product()%></td>
                        <td><%=orders_done.getProduct_name()%></td>
                        <td><%=orders_done.getSupplier_name()%></td>
                        <td><%= CurrencyUtils.format(orders_done.getTotal_price()) %></td>

                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

                <br/>
                <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver al Menu Inicial</a></p>
            </div>

        </main>

        <%@include file="includes/footer.jsp"%>

