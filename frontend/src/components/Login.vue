<template>
  <div class="signup">
    <!--FORM-->
    <form @submit.prevent="login">
      <h2>Connexion</h2>

      <!--EMAIL-->
      <div class="form-group">
        <label for="email">Addresse mail</label>
        <input
          v-model="email"
          type="email"
          class="form-control"
          id="email"
          aria-describedby="emailHelp"
        />
      </div>

      <!--PASSWORD-->
      <div class="form-group">
        <label for="password">Mot de passe</label>
        <input
          v-model="password"
          type="password"
          class="form-control"
          id="password"
        />
      </div>

      <!-----------------SUBMIT--------------->
      <button type="submit" class="btn btn-primary">Se connecter</button>
    </form>
  </div>
</template>

<script>
export default {
  name: "login",

  data() {
    return {
      email: "",
      password: "",
    };
  },

  methods: {
    login() {
      let data = {
        email: this.email,
        password: this.password,
      };

      fetch("http://localhost:3000/api/auth/login", {
        method: "POST",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      })
        .then((response) => {
          if (response.ok) {
            return response.json();
          } else {
            return response.text().then((text) => {
              throw new Error(text);
            });
          }
        })

        .then((value) => {
          const token = JSON.stringify(value.token);
          const userId = JSON.stringify(value.userId);
          const role = JSON.stringify(value.role);
          localStorage.setItem("userToken", token);
          localStorage.setItem("userId", userId);
          localStorage.setItem("role", role);
          this.$router.push("/allposts");
        })
        .catch(alert);
    },
  },
};
</script>

<style scoped>
form {
  background-color: #daf3f2 !important;
  margin: 40px auto;
  padding: 20px;
  width: 380px;
  text-align: left;
  border-radius: 20px;
}
form h2 {
  margin: 0 auto 30px;
  text-align: center;
}
.signup-link {
  display: flex;
  justify-content: space-between;
  margin: 10px auto;
}
.btn {
  margin: 10px auto;
}
</style>