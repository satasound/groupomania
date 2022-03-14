<template>
  <header class="nav">
    <a href="/"
      ><img src="../assets/images/logo2.png" alt="Logo Groupomania"
    /></a>
    <nav>
      <router-link to="/signup" class="link" aria-label="Inscription"
        >Inscription</router-link
      >
    </nav>
  </header>
</template>

<script>
export default {
  name: "Header",
};
</script>

// <!-- Add "scoped" attribute to limit CSS to this component only -->
 <style scoped>
header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.nav {
  background: #daf3f2;
}
img {
  height: 60px;
}

.link {
  padding-left: 5vw;
  font-size: 1.2rem;
  text-decoration: none;
  cursor: pointer;
}

.link:hover {
  color: #8f8e8c;
}
.nav {
  padding: 20px 5vw;
  font-size: 1vw;
}

.nav a {
  font-weight: bold;
  color: #535353;
}

.nav a.router-link-exact-active {
  color: #d1634d;
}

@media screen and (max-width: 1024px) {
  header {
    flex-direction: column;
  }

  img {
    margin-bottom: 30px;
  }

  .link {
    padding: 0 30px;
  }
}

@media screen and (max-width: 768px) {
  header {
    flex-direction: column;
  }

  img {
    margin-bottom: 30px;
    height: 50px;
  }

  .link {
    padding: 0 30px;
    font-size: 15px;
  }
}
</style>
