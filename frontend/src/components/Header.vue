<template>
  <!--topNavbar-->
  <div class="topNavbar">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="container-fluid">
        <!--LOGO-->
        <router-link to="/" class="navbar-brand" href="#">
          <img alt="Logo Groupomania" src="../assets/images/logo2.png" />
        </router-link>
        <!--MOBILE MENU TOGGLER-->
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <!--MENU-->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <!--INSCRIPTION-->
            <li class="nav-item">
              <!-- <a class="nav-link" href="#">Signup</a> -->
              <router-link to="/signup" class="nav-link"
                >Inscription</router-link
              >
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </div>
  <!--END topNavbar-->
</template>

<script>
export default {
  name: "Header",
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.navbar {
  background-color: #daf3f2 !important;
}
/* .bg-info {
  background-color: #f0f1fc !important;
} */
.navbar-brand img {
  max-width: 100%;
  height: auto;
}

.navbar-expand-lg {
  padding: 1rem 10rem;
}
.navbar-nav .nav-item img {
  max-width: 100%;
  height: 25px;
}
.nav-item {
  margin: 0rem 1.5rem;
}
.navbar-toggle {
  border-color: #ddd;
  top: 37px;
}

.navbar-toggle .icon-bar {
  background-color: #888;
}
.navbar-expand-lg[data-v-41458b80] {
  padding: 1rem;
}
</style>
