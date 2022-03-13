<template>
  <header class="nav">
    <router-link to="/allposts"
      ><img src="../assets/images/logo2.png" alt="Logo Groupomania"
    /></router-link>
    <nav>
      <router-link to="/admin" v-if="role === 1" aria-label="Administration"
        ><i class="fas fa-user-lock link"></i
      ></router-link>
      <router-link to="/profile" aria-label="Profil"
        ><i class="fas fa-user-circle link"></i
      ></router-link>
      <a class="link disconnect" @click="disconnectUser()">Deconnexion</a>
    </nav>
  </header>
</template>


<script>
export default {
  name: "HeaderAdmin",
  data() {
    return {
      role: "",
    };
  },
  methods: {
    disconnectUser() {
      localStorage.clear();
      this.$router.push("/");
    },
    roleUser() {
      this.role = JSON.parse(localStorage.getItem("role"));
    },
  },
  mounted() {
    this.roleUser();
  },
};
</script>


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
    cursor: pointer;
  }
}
</style>
