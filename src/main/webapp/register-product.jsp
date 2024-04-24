<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.retrocomputer.domain.Products" %>
<%@ page import="com.svalero.retrocomputer.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.retrocomputer.dao.ProductsDao" %>
<%@ page import="com.svalero.retrocomputer.util.DateUtils" %>
<%@ page import="com.svalero.retrocomputer.util.CurrencyUtils" %>
<%@include file="includes/header.jsp"%>

<script>
    $(document).ready(function () {
        $("#edit-button").click(function (event) {
            event.preventDefault();
            const form = $("#edit-form")[0];
            const data = new FormData(form);

            $("#edit-button").prop("disabled", true);

            $.ajax({
                type: "POST",
                enctype: "multipart/form-data",
                url: "edit-products",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    $("#result").html(data);
                    $("#edit-button").prop("disabled", false);
                },
                error: function (error) {
                    $("#result").html(error.responseText);
                    $("#edit-button").prop("disabled", false);
                }
            });
        });
    });
</script>

<%
    if (!role.equals("admin")){
        response.sendRedirect("/retrocomputer");
    }
    //Si no eres el administrador no puedes entrar a esta pagina
    Products products=null;
    int id;
    //El id = 0 no es nunca un numero valido para un id, por eso ponemos 0, eso quiere decir que no existe
    //Asi ya tenemos una doble funcionalidad para este id
    if (request.getParameter("id_product") == null){
        // Se accede al formulario para crear una nueva actividad
        id = 0;
    } else {
        // Se accede al formulario para editar una actividad ya existente
        id=Integer.parseInt(request.getParameter("id_product"));
        try {
            Database.connect();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        products = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getOneProducts(id));
    }
%>
<main>
    <%--        con este section consigo un centrado de todos los textos que estan en medio, queda mal--%>
    <section class="py-5 container">
        <% if (id==0) {%>
        <h3 class="text-danger">Registrar Nuevo Producto</h3>
        <% } else { %>
        <h3 class="text-danger">Modificar Producto</h3>
        <% } %>
        <br/>
        <form class="row g-3 needs-validation bg-dark border-dark" method="post" enctype="multipart/form-data" id="edit-form">
            <div class="mb-3  text-white bg-dark">
                <label for="product_name" class="form-label">Nombre</label>
                <input type="text" name="product_name" class="form-control" id="product_name" placeholder="Ejemplo:  Commodore 64"
                    <% if (id !=0) {%> value="<%=products.getProduct_name()%>"<% }%>>
            </div>
            <div class="mb-3  text-white bg-dark">
                <label for="description" class="form-label">Descripcion</label>
                <input type="text" name="description" class="form-control" id="description" placeholder="Ejemplo:  Microordenador de 8 bits"
                    <% if (id !=0) {%> value="<%=products.getDescription()%>"<% }%>>
            </div>
            <div class="mb-3  text-white bg-dark">
                <label for="product_status" class="form-label">Estado del Producto</label>
                <input type="text" name ="product_status" class="form-control" id="product_status" placeholder="Bueno, con.."
                    <% if (id !=0) {%> value="<%=products.getProduct_status()%>"<% }%>>
            </div>
            <div class="col-md-2  text-white bg-dark">
                <label for="sale_price" class="form-label">Precio de Venta</label>
                <input type="text" name ="sale_price" class="form-control" id="sale_price" placeholder="18,00"
                <% if (id !=0) {%> value="<%= CurrencyUtils.format(products.getSale_price()) %>"<% }%>>
            </div>
            <div class="col-md-2  text-white bg-dark">
                <label for="release_date" class="form-label">Fecha de lanzamiento</label>
                <input type="date" name="release_date" class="form-control" id="release_date" placeholder="dd/mm/yyyy"
                <% if (id !=0) {%> value="<%=DateUtils.format(products.getRelease_date())%>"<% }%>>
            </div>
            <div class="col-md-2  text-white bg-dark">
                <label for="id_supplier" class="form-label">Codigo del proveedor</label>
                <input type="text" name ="id_supplier" class="form-control" id="id_supplier" placeholder="7, codigo proveedor principal"
                <% if (id !=0) {%> value="<%=products.getId_supplier()%>"<% }%>>
            </div>
            <div class="col-md-4  text-white bg-dark">
                <label for="image" class="form-label">Imagen Producto</label>
                <input type="file" name="image" class="form-control" id="image">
            </div>

            <div class="col-12  text-white bg-dark">
                    <input type="submit" value="Enviar" id="edit-button"/>
            </div>
            <input type="hidden" name="id_product" value="<%=id%>"/>
        </form>
        <br/>
        <div id="result"></div>
        <br/>
        <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Volver al inicio</a></p>
    </section>
</main>

<%@include file="includes/footer.jsp"%>