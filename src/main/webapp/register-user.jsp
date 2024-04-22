<%@ page import="com.svalero.retrocomputer.domain.User" %>
<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("edit-user", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>
<%
    User user=null;
    int id;
    //El id = 0 no es nunca un numero valido para un id, por eso ponemos 0, eso quiere decir que no existe
    //Asi ya tenemos una doble funcionalidad para este id
    if (request.getParameter("id_user") == null){
        // Se accede al formulario para crear una nueva actividad
        id = 0;
    } else {
        // Se accede al formulario para editar una actividad ya existente
        id=Integer.parseInt(request.getParameter("id_user"));
        try {
            Database.connect();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getOneUser(id));
    }
%>
<main>

    <section class="py-5 container">
        <% if (id==0) {%>
        <h3 class="text-danger">Registrar Nuevo Usuario</h3>
        <% } else { %>
        <h3 class="text-danger">Modificar Usuario</h3>
        <% } %>
        <br/>

        <form class="row g-3 needs-validation bg-dark border-dark" method="post" enctype="multipart/form-data" id="edit-form">
            <div class="col-md-6 text-white bg-dark">
                <label for="name" class="form-label">Nombre</label>
                <input type="text" name="name" class="form-control" id="name" placeholder="Ejemplo:  Miguel Angel"
                <% if (id !=0) {%> value="<%=user.getName()%>"<% }%>>
            </div>
            <div class="col-md-6 text-white bg-dark">
                <label for="username" class="form-label">Username</label>
                <input type="text" name="username" class="form-control" id="username" placeholder="Ejemplo:  Mig12876"
                <% if (id !=0) {%> value="<%=user.getUsername()%>"<% }%>>
            </div>
            <% if (id==0) {%>
                <div class="mb-3 text-white bg-dark">
                    <label for="password" class="form-label">Password</label>
                     <input type="text" name ="password" class="form-control" id="password" placeholder="Ejemplo Labcdef1B">
                </div>
            <% } %>
            <div class="mb-3 text-white bg-dark">
                <label for="address" class="form-label">Direccion</label>
                <input type="text" name ="address" class="form-control" id="address" placeholder="Ejemplo Calle...."
                <% if (id !=0) {%> value="<%=user.getAddress()%>"<% }%>>
            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="tel" class="form-label">Teléfono</label>
                <input type="text" name ="tel" class="form-control" id="tel" placeholder="+34605888888"
                <% if (id !=0) {%> value="<%=user.getTel()%>"<% }%>>
            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="zip_code" class="form-label">Codigo Postal</label>
                <input type="text" name ="zip_code" class="form-control" id="zip_code" placeholder="50500"
                <% if (id !=0) {%> value="<%=user.getZip_code()%>"<% }%>>
            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="city" class="form-label">Ciudad</label>
                <input type="text" name="city" class="form-control" id="city" placeholder="Zaragoza"
                <% if (id !=0) {%> value="<%=user.getCity()%>"<% }%>>

            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="country" class="form-label">Pais</label>
                <input type="text" name ="country" class="form-control" id="country" placeholder="España"
                <% if (id !=0) {%> value="<%=user.getCountry()%>"<% }%>>

            </div>

            <%
                if (role.equals("admin")) {
            %>
            <div class="col-md-2 text-white bg-dark">
                <label for="role" class="form-label">Role</label>
                <input type="text" name ="role" class="form-control" id="role" placeholder="user"
                <% if (id !=0) {%> value="<%=user.getRole()%>"<% }%>>
            </div>
            <%
                }
            %>
            <div class="col-12">
                <button class="btn btn-danger" type="submit">Enviar Usuario</button>
            </div>
            <input type="hidden" name="id_user" value="<%=id%>"/>
        </form>
        <br/>
        <div id="result"></div>
        <br/>
        <%if (role.equals("admin")) {%>
            <p><a href="index-user.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver a Usuarios</a></p>
        <% } else { %>
            <p><a href="logout" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver a Inicio</a></p>
        <%}%>

    </section>
</main>

<%@include file="includes/footer.jsp"%>