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





        <main>
            <%
                if (request.getSession().getAttribute("id_user") == null) {
                    response.sendRedirect("index.jsp");
                }
                        //Si no eres un usuario registrado no puedes entrar a esta pagina
            %>
            <br/>
            <div class="container bg-dark">
                <h2 class="text-danger">Listado de Productos comprados por "<%=username_init%></h2>

                <br/>

            </div>

            <div class="container my-6 bg-dark">

                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Id del Pedido</th>
                        <th>Nombre Usuario</th>
                        <th>Fecha del Pedido</th>
                        <th>Id del Producto</th>
                        <th>Nombre Producto</th>
                        <th>Precio Total</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Database.connect();
                        } catch (ClassNotFoundException e) {
                            throw new RuntimeException(e);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        final int finaluser_id = user_id;
                        List<Orders_done> orders_dones = Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.getOrders_doneByUser(finaluser_id));

                    %>
                    <%
                        for (Orders_done orders_done : orders_dones) {

                    %>
                    <tr>
                        <td><%=orders_done.getId_order()%></td>
                        <td><%=orders_done.getUser().getName()%></td>
                        <td><%=DateUtils.formatUser(orders_done.getOrder_date())%></td>
                        <td><%=orders_done.getProducts().getId_product()%></td>
                        <td><%=orders_done.getProducts().getProduct_name()%></td>
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

