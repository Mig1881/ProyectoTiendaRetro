<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.domain.User" %>
<%@ page import="com.svalero.retrocomputer.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<main>
    <%
        if (!role.equals("admin")){
            response.sendRedirect("/retrocomputer");
        }
        //Si no eres el administrador no puedes entrar a esta pagina
        try {
            Database.connect();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        int id_user = Integer.parseInt(request.getParameter("id_user"));
        User user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getOneUser(id_user));
    %>


    <div class="container my-3">

        <div class="row">
            <div class="col-sm-12  col-md-8 col-lg-8 col-xl-8 py-4 bg-dark">
                <table class="table table-dark table-striped">
                    <tr>
                        <td class="centrado"><h2 class="text-danger">Ver Usuario</h2></td>
                        <td class="centrado"></td>
                    </tr>
                    <tr>
                        <td class="centrado">Nombre</td>
                        <td class="centrado"><%=user.getName()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Username</td>
                        <td class="centrado"><%=user.getUsername()%></td>
                    </tr>

                    <tr>
                        <td class="centrado">Role</td>
                        <td class="centrado"><%=user.getRole()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Telefono</th>
                        <td class="centrado"><%=user.getTel()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Direccion</td>
                        <td class="centrado"><%=user.getAddress()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Codigo Postal</th>
                        <td class="centrado"><%=user.getZip_code()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Ciudad</th>
                        <td class="centrado"><%=user.getCity()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Pais</th>
                        <td class="centrado"><%=user.getCountry()%></td>
                    </tr>

                </table>

            </div>
        </div>
        <br/>
        <p><a href="index-user.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver a Usuarios</a></p>
    </div>

</main>

<%@include file="includes/footer.jsp"%>

