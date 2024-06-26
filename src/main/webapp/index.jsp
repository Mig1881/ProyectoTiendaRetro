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
<%--Extra 2: Relaciones, se ha hecho relacion entre Productos y Proveedores en Listado de productos sin Stock(list-out-stock.jsp) y en tabla orders_done con usuarios y productos y proveedores--%>
<%--Extra 3: Uso de Imagenes en productos.--%>
<%--Extra 4: Funcionalidad Javascrip. Utilizacion de Ajax--%>
<%--Extra 5: Implementado Git desde Intellij, se suben los cambios directamente a repositorio local y a Github, inicio de rama retoque_html_index despues de practicas--%>
<%--Extra 6: Zona Privada de Usuarios no administradores  y zona privada de administradores.--%>
<%--Otras funciones implementadas: --%>
<%--            * Quinta Tabla, Historico de Productos, para guardar toda la informacion de los productos vendidos y poder relacionar con orders_done para obtener informacion del producto--%>
<%--            * En Alta y Modificacion de producto se introduce en el formulario listado de proveedores desplegable con datos de la BD de la tabla de Proveedores--%>
<%--            * Control de unidades de Stock, si no hay no deja comprar y da mensaje de sin stock habilitando boton para su consulta con tienda, se utiliza como booleano--%>
<%--            * Obliga a iniciar sesion para iniciar el proceso de compra, localiza si no hay ususario que no ha iniciado sesion, pero deja ver productos de tienda--%>
<%--            * No se borran productos sin stock para que cliente vea que productos ha habido y sondear posible  interes--%>
<%--            * El Listado de productos sin stock se deja al administrador que decida si borra o no el producto dependiendo del interes, tb se pueden borrar todos a la vez --%>
<%--            * Proteccion de acceso a paginas sensibles que solo puede entrar el administrador o el usuario en cada caso-%>
<%--            * Un usuario que es administrador no puede comprar--%>
<%--            * Listado de pedidos realizados para administrador, con filtros por 4 campos incluido fecha y sumatorio de importe total de datos seleccionados--%>
<%--            * Un administrador no puede ver la contraseña de ningun usuario, puede ver sus datos y eliminar, pero no ver su contraseña--%>
<%--            * Se permite modificar a cada usuario(administradores incluidos), modificar sus datos incluido el password --%>

<%--Nota: No estoy matriculado en Lenguaje de marcas ni en Cloud, de ahi que el diseño html sea muy sencillo y no haya implementado contenedores--%>




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
           <h4 class="text-danger"><%= username_init%></h4>
           <p><a href="register-user.jsp?id_user=<%=user_id%>" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">&nbsp;&nbsp;Modificar mi Usuario&nbsp;&nbsp;</a></p>
           <a href="logout" title="Cerrar sesión"><img src="icons/exit.png" height="50" width="50"/></a>
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
                    <a href="all-orders_done.jsp" class="btn btn-sm btn-outline-danger" type="button">Pedidos Realizados</a>
                <%
                } else {
                %>
                     <h3 class="text-success">---Productos Estrella---</h3>
                <br/>
                <%
                    if (role.equals("user")){
                %>
                    <a href="index-sales.jsp" class="btn btn-sm btn-outline-primary" type="button">Ver mis pedidos</a>
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


