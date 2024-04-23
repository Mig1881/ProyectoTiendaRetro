<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.domain.Products" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.retrocomputer.dao.ProductsDao" %>
<%@ page import="com.svalero.retrocomputer.util.CurrencyUtils" %>
<%@ page import="com.svalero.retrocomputer.util.DateUtils" %>
<%@include file="includes/header.jsp"%>
<script>
    $(document).ready(function () {
        $("#search-input").focus();
    });
</script>

<%--1ª Entrega--%>
<%--Realizado todos los 5 puntos Obligatorios(DAO completo de 3 tablas con Busquedas, Listados, vista detalle, modificacion y baja)--%>
<%--Las Busquedas se han hecho con 3 y 4 campos al mismo tiempo, y se han validado todos los campos--%>

<%--+++ Otras funcionalidades--%>
<%--Extra 1: Login de Usuarios--%>
<%--Extra 2: Relaciones, se ha hecho relacion entre Usuarios y Proveedores en Listado de productos sin Stock(list-out-stock.jsp) y en tabla orders_done con usuarios y productos--%>
<%--Extra 3: Uso de Imagenes en productos.--%>
<%--Extra 4: Funcionalidad Javascrip. Utilizacion de Ajax--%>
<%--Extra 5: Implementado Git desde Intellij, se suben versiones directamente a repositorio local y a Github--%>
<%--Extra 6: trabajo con informacion de una 4 tabla, tabla de Ordes_dones, utilizacion de Objetos en la misma--%>
<%--Extra 7: Zona Privada de Usuarios no administradores  y zona privada de administradores.--%>
<%--Otras funciones implementadas: --%>
<%--            * Control de unidades de Stock, si no hay no deja comprar y da mensaje de sin stock habilitando boton para su consulta con tienda--%>
<%--            * Obliga a iniciar sesion para iniciar el proceso de compra, localiza si no hay ususario que no ha iniciado sesion, pero deja ver productos de tienda--%>
<%--            * Proteccion de acceso a paginas sensibles que solo puede entrar el administrador o el usuario en cada caso-%>
<%--            * Un usuario que es administrador no puede comprar--%>





<main>

   <div class="py-5 container">
       <div class="d-grid gap-2 d-md-flex justify-content-md-end ">
           <%
               if (role.equals("anonymous")) {
           %>
           <a href="login.jsp" title="Iniciar sesión"><img src="icons/user1.png" height="50" width="50"/></a>
           <%
           } else {
           %>
           <a href="logout" title="Cerrar sesión"><img src="icons/exit.png" height="50" width="50"/></a>
           <p class="text-danger"><%= username_init%></p>

           <%
               }
           %>
       </div>
   </div>

    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="text-success"><strong>RetroByte</strong></h1>

                <%
                    if (role.equals("admin")){
                %>
                    <h3 class="text-success">---Modo Administrador---</h3>
                    <br/>
                    <a href="register-product.jsp" class="btn btn-sm btn-outline-primary" type="button">Alta Producto</a>
                    <a href="index-user.jsp" class="btn btn-sm btn-outline-danger" type="button">Usuarios</a>
                    <a href="index-suppliers.jsp" class="btn btn-sm btn-outline-primary" type="button">Proveedores</a>
                <%
                } else {
                %>
                     <h3 class="text-success">---Productos Estrella---</h3>
                <br/>
                <%
                    if (role.equals("user")){
                %>
                    <a href="index-sales.jsp" class="btn btn-sm btn-outline-primary" type="button">Ver mis pedidos</a>
                    <a href="register-user.jsp?id_user=<%=user_id%>" class="btn btn-sm btn-outline-danger" type="button">Cambiar datos de mi Usuario</a>
                <%
                        }
                %>
                <%
                    }
                %>
            </div>
        </div>
    </section>

        <div class="album py-5 bg-body-tertiary bg-image2">
            <div class="container">
                <form class="row g-2" id="search-form" method="GET">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Buscar en Productos" name="search" id="search-input">
                        <button type="submit" class="btn btn-outline-danger"  id="search-button">Buscar</button>
                    </div>
                </form>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                    <%
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
                        List<Products> listaproductos = null;
                        if (search.isEmpty()) {
                            listaproductos = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getAllProducts());
                        } else {
                            final String searchTerm = search;
                            listaproductos = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getProducts(searchTerm));
                        }
                        for (Products products : listaproductos) {
                    %>
                    <div class="col">
                        <div class="card shadow-sm">

                            <img src="../retro_pictures/<%=products.getImage()%>" style="max-width: 480px;max-height: 360px;"/>
                            <div class="card-body">
                                <p class="card-text"><strong><%= products.getProduct_name() %></strong>&nbsp;&nbsp;&nbsp;Lanzamiento:&nbsp;<strong><%=DateUtils.formatUser(products.getRelease_date())%></strong></p>
                                <p class="card-text"><%= products.getDescription() %> </p>

                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <a href="view-product.jsp?id_product=<%= products.getId_product()%>" type="button" class="btn btn-sm btn-outline-primary">Ver</a>
                                        <%
                                            if (role.equals("admin")){
                                        %>
                                        <a href="register-product.jsp?id_product=<%=products.getId_product()%>"  type="button" class="btn btn-sm btn-outline-primary">Editar</a>
                                        <a href="remove-products?id_product=<%= products.getId_product()%>" type="button" class="btn btn-sm btn-outline-danger">Eliminar</a>
                                        <%
                                            }
                                        %>
                                    </div>
                                    <small class="text-body-secondary">Precio: <%= CurrencyUtils.format(products.getSale_price()) %> </small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>

            </div>
        </div>

</main>

<%@include file="includes/footer.jsp"%>


