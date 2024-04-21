<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.domain.Products" %>
<%@ page import="com.svalero.retrocomputer.dao.ProductsDao" %>
<%@ page import="com.svalero.retrocomputer.domain.Products" %>
<%@ page import="com.svalero.retrocomputer.util.CurrencyUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.retrocomputer.util.DateUtils" %>
<%@include file="includes/header.jsp"%>
<main>
    <%
        try {
            Database.connect();
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            } catch (SQLException e) {
                throw new RuntimeException(e);
         }
        int id_product = Integer.parseInt(request.getParameter("id_product"));
        Products products = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getOneProducts(id_product));
    %>
    <div class="py-5 container">
        <div class="d-grid gap-2 d-md-flex justify-content-md-end ">
            <%
                if (!role.equals("anonymous")) {
            %>
                <p class="text-danger"><%= username_init%></p>
            <%
                }
            %>
        </div>
    </div>

    <div class="container my-3">
        <div class="row">
            <div class="col-sm-12  col-md-4 col-lg-4 col-xl-4 py-4 bg-image2">
                <h3 class="text-danger">Foto del producto</h3>
                <div class="card shadow-sm">
                    <img src="../retro_pictures/<%=products.getImage()%>"  alt="<%= products.getDescription() %>"/>
                    <div class="btn-group">
                        <%if (products.getStock_units() == 0) { %>
                            <a href="mailto:retrobyte@retrobyte.com" type="button" class="btn btn-sm btn-outline-danger">Consultar Disponibilidad</a>
                        <%} else {%>
                            <%
                                if (role.equals("anonymous")) {
                            %>
                                <a href="login.jsp"  type="button" class="btn btn-sm btn-outline-danger">Inicia sesion para comprar</a>
                            <% } else {%>
                                <a href="index-sales.jsp"  type="button" class="btn btn-sm btn-outline-danger">Comprar</a>
                            <%
                                }
                            %>

                        <%}%>
                    </div>
                </div>
            </div>
            <div class="col-sm-12  col-md-8 col-lg-8 col-xl-8 py-4 bg-image2">
                <h3 class="text-danger">Datos del Producto</h3>
                <table class="table table-dark table-striped">
                    <tr>
                        <td class="centrado">Nombre</td>
                        <td class="centrado"><%=products.getProduct_name()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Descripcion</td>
                        <td class="centrado"><%=products.getDescription()%></td>
                    </tr>

                    <tr>
                        <td class="centrado">Fecha de Lanzamiento</td>
                        <td class="centrado"><%=DateUtils.formatUser(products.getRelease_date())%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Estado del producto</th>
                        <td class="centrado"><%=products.getProduct_status()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Precio</td>
                        <td class="centrado"><%=CurrencyUtils.format(products.getSale_price())%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Nº Unidades en Stock</th>
                        <%
                            String mensaje_stock_units;
                            if (products.getStock_units() == 0) {
                                mensaje_stock_units = "Producto temporalmente sin Stock";
                            } else {
                                mensaje_stock_units = String.valueOf(products.getStock_units());
                            }
                        %>
                        <td class="centrado"><%=mensaje_stock_units%></td>
                    </tr>
                </table>

            </div>
        </div>
        <br/>
        <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver al inicio</a></p>
    </div>
</main>

<%@include file="includes/footer.jsp"%>


