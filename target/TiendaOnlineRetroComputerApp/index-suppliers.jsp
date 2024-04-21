<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.domain.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.retrocomputer.dao.ProductsDao" %>
<%@ page import="com.svalero.retrocomputer.dao.UserDao" %>
<%@ page import="com.svalero.retrocomputer.domain.Suppliers" %>
<%@ page import="com.svalero.retrocomputer.dao.SuppliersDao" %>
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
        <h2 class="text-danger">Listado de Proveedores</h2>
        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <a href="register-suppliers.jsp" type="button" class="btn btn-outline-danger">Alta de Nuevo Proveedor</a>
            <a href="list-out-stock.jsp" type="button" class="btn btn-outline-danger">Listado de productos sin Stock</a>
        </div>
        <br/>
        <br/>
        <form class="row g-2" id="search-form" method="GET">
            <div class="input-group mb-3">
                <input type="text" class="form-control" placeholder="Buscar en Proveedores" name="search" id="search-input">
                <button type="submit" class="btn btn-outline-danger"  id="search-button">Buscar</button>
            </div>
        </form>
    </div>

    <div class="container my-6 bg-dark">


                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Id proveedor</th>
                        <th>Nombre</th>
                        <th>Ciudad</th>
                        <th>Email</th>
                        <th></th>
                        <th></th>
                        <th></th>
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
                        List<Suppliers> listsuppliers = null;
                        if (search.isEmpty()) {
                            listsuppliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getAllSuppliers());
                        } else {
                            final String searchTerm = search;
                            listsuppliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getSuppliers(searchTerm));
                        }

                        for (Suppliers suppliers : listsuppliers) {
                    %>
                    <tr>
                        <td><%=suppliers.getId_supplier()%></td>
                        <td><%=suppliers.getName()%></td>
                        <td><%=suppliers.getCity()%></td>
                        <td><%=suppliers.getEmail()%></td>
                        <th><a href="view-suppliers.jsp?id_supplier=<%= suppliers.getId_supplier()%>" type="button" class="btn btn-sm btn-outline-success">Ver Proveedor</a></th>
                        <th><a href="register-suppliers.jsp?id_supplier=<%= suppliers.getId_supplier()%>" type="button" class="btn btn-sm btn-outline-primary">Editar Proveedor</a></th>
                        <th> <a href="remove-suppliers?id_supplier=<%= suppliers.getId_supplier()%>" type="button" class="btn btn-sm btn-outline-danger">Eliminar Proveedor</a></th>

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
