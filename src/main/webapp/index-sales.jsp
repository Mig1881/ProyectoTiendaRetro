<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.domain.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.retrocomputer.dao.ProductsDao" %>
<%@ page import="com.svalero.retrocomputer.dao.UserDao" %>
<%@ page import="com.svalero.retrocomputer.domain.Products" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        final int user_idfinal=user_id;
        User user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getOneUser(user_idfinal));

    %>

    <br/>
    <div class="container bg-dark">
        <h1 class="text-danger">Pagina en Construccion</h1>
        <br/>

    </div>

    <div class="container my-6 bg-dark">

        <br/>
        <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver al Inicio</a></p>
    </div>

</main>
<%@include file="includes/footer.jsp"%>
