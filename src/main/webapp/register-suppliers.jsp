<%@ page import="com.svalero.retrocomputer.domain.User" %>
<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.dao.UserDao" %>
<%@ page import="com.svalero.retrocomputer.dao.SuppliersDao" %>
<%@ page import="com.svalero.retrocomputer.domain.Suppliers" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("edit-suppliers", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>
<%
    if (!role.equals("admin")){
        response.sendRedirect("/retrocomputer");
    }
    Suppliers suppliers=null;
    int id;
    //El id = 0 no es nunca un numero valido para un id, por eso ponemos 0, eso quiere decir que no existe
    //Asi ya tenemos una doble funcionalidad para este id
    if (request.getParameter("id_supplier") == null){
        // Se accede al formulario para crear una nueva actividad
        id = 0;
    } else {
        // Se accede al formulario para editar una actividad ya existente
        id=Integer.parseInt(request.getParameter("id_supplier"));
        try {
            Database.connect();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        suppliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getOneSuppliers(id));
    }
%>
<main>

    <section class="py-5 container">
        <% if (id==0) {%>
        <h3 class="text-danger">Registrar Nuevo Proveedor</h3>
        <% } else { %>
        <h3 class="text-danger">Modificar Proveedor</h3>
        <% } %>
        <br/>

        <form class="row g-3 needs-validation bg-dark border-dark" method="post" enctype="multipart/form-data" id="edit-form">
            <div class="col-md-6 text-white bg-dark">
                <label for="name" class="form-label">Nombre</label>
                <input type="text" name="name" class="form-control" id="name" placeholder="Ejemplo:  Miguel Angel"
                <% if (id !=0) {%> value="<%=suppliers.getName()%>"<% }%>>
            </div>
            <div class="col-md-6 text-white bg-dark">
                <label for="tel" class="form-label">Telefono</label>
                <input type="text" name="tel" class="form-control" id="tel" placeholder="+34605888888"
                <% if (id !=0) {%> value="<%=suppliers.getTel()%>"<% }%>>
            </div>
            <div class="mb-3 text-white bg-dark">
                <label for="address" class="form-label">Direccion</label>
                <input type="text" name ="address" class="form-control" id="address" placeholder="Ejemplo Calle...."
                <% if (id !=0) {%> value="<%=suppliers.getAddress()%>"<% }%>>
            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="zip_code" class="form-label">Codigo Postal</label>
                <input type="text" name ="zip_code" class="form-control" id="zip_code" placeholder="50500"
                <% if (id !=0) {%> value="<%=suppliers.getZip_code()%>"<% }%>>
            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="city" class="form-label">Ciudad</label>
                <input type="text" name="city" class="form-control" id="city" placeholder="Zaragoza"
                <% if (id !=0) {%> value="<%=suppliers.getCity()%>"<% }%>>

            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="country" class="form-label">Pais</label>
                <input type="text" name ="country" class="form-control" id="country" placeholder="España"
                <% if (id !=0) {%> value="<%=suppliers.getCountry()%>"<% }%>>

            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="website" class="form-label">Website</label>
                <input type="text" name ="website" class="form-control" id="website" placeholder="www.ejemplo.com"
                    <% if (id !=0) {%> value="<%=suppliers.getWebsite()%>"<% }%>>

            </div>

            <div class="col-md-2 text-white bg-dark">
                <label for="email" class="form-label">Email</label>
                <input type="email" name ="email" class="form-control" id="email" placeholder="name@example.com"
                <% if (id !=0) {%> value="<%=suppliers.getEmail()%>"<% }%>>
            </div>

            <div class="col-12">
                <button class="btn btn-danger" type="submit">Enviar Proveedor</button>
            </div>
            <input type="hidden" name="id_supplier" value="<%=id%>"/>
        </form>
        <br/>
        <div id="result"></div>
        <br/>
        <p><a href="index-suppliers.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver a Proveedores</a></p>
    </section>
</main>

<%@include file="includes/footer.jsp"%>