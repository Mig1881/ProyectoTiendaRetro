
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header-login.jsp"%>

 <div class="py-5 container">
     <div class="d-grid gap-2 d-md-flex justify-content-md-end">
         <a href="register-user.jsp" class="btn btn-outline-danger me-md-2" type="button">Registrarse en RetroByte</a>
     </div>
 </div>

<div class="d-flex align-items-center py-4 bg-body-tertiary bg-image2">


    <main class="form-signin w-100 m-auto ">
        <form>
            <h2 class="h3 mb-3 fw-normal text-danger">Iniciar Sesion</h2>
            <div class="form-floating">
                <input type="text" name="username" class="form-control" id="floatingInput" placeholder="Usuario">
                <label for="floatingInput">Usuario</label>
            </div>
            <div class="form-floating">
                <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Contraseña">
                <label for="floatingPassword">Contraseña</label>
            </div>

            <button class="btn btn-danger w-100 py-2" type="submit">Iniciar sesion</button>
            <p class="mt-5 mb-3 text-body-secondary">  </p>
        </form>
        <br/>
        <div id="result"></div>
    </main>
</div>
<footer class="text-body-secondary py-5">
    <div class="container">
        <p class="mb-1">&copy; 2024 RetroByte</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</body>
</html>
