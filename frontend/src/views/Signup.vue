<template>
  <div class="signup">
    <Header />
    <!--FORM-->
    <form @submit.prevent="signup">
      <h2>Inscription</h2>

      <!--FIRSTNAME-->
      <div class="mb-3">
        <label for="prenom" class="form-label">Prénom</label>
        <input
          v-model="prenom"
          type="text"
          class="form-control"
          id="prenom"
          aria-describedby="prenomHelp"
        />
      </div>

      <!--LASTNAME-->
      <div class="mb-3">
        <label for="nom" class="form-label">Nom</label>
        <input
          v-model="nom"
          type="text"
          class="form-control"
          id="nom"
          aria-describedby="nomHelp"
        />
      </div>

      <!--EMAIL-->
      <div class="mb-3">
        <label for="email" class="form-label">Adresse mail</label>
        <input
          v-model="email"
          type="email"
          class="form-control"
          id="email"
          aria-describedby="emailHelp"
        />
      </div>

      <!--PASSWORD-->
      <div class="mb-3">
        <label for="password" class="form-label">mot de passe</label>
        <input
          v-model="password"
          type="password"
          class="form-control"
          id="password"
        />
      </div>

      <!--IMAGE-->
      <div class="mb-3">
        <label for="image" class="form-label">Image du profile</label>
        <input class="form-control" type="file" id="image" />
      </div>

      <!--SUBMIT-->
      <button type="submit" class="btn btn-primary">Créer un compte</button>
      <!-- <b-button type="submit" :class="{ disabled: !validatedFields() }"
        >Se connecter</b-button> -->

      <!--LINK TO LOGIN-->
      <div class="login-link">
        <p>Déjà un inscrit ?</p>
        <!-- <b-link href="#foo">Créer un compte</b-link> -->
        <router-link to="/">Se connecter</router-link>
      </div>
    </form>
  </div>
</template>

<script>
import Header from "../components/Header";

export default {
  name: "signup",
  components: {
    Header,
  },

  data() {
    return {
      nom: "",
      prenom: "",
      email: "",
      password: "",
      image: "",
    };
  },

  methods: {
    /* Bind image function */

    signup() {
      this.image = document.getElementById("image").value;
      let data = {
        nom: this.nom,
        prenom: this.prenom,
        email: this.email,
        password: this.password,
        image: this.image,
      };

      const regexText = /^[a-zA-Z-\s]+$/;
      const regexEmail =
        /^[a-zA-Z0-9.-_]+[@]{1}[a-zA-Z0-9.-_]+[.]{1}[a-z]{2,10}$/; // eslint-disable-line
      const regexPassword = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{3,50}$/;

      if (this.nom === "") {
        alert("Nom requis");
      } else if (regexText.test(this.nom) === false) {
        alert("Caractères alphabétiques uniquement");
      }

      if (this.prenom === "") {
        alert("Prénom requis");
      } else if (regexText.test(this.prenom) === false) {
        alert("Caractères alphabétiques uniquement");
      }

      if (this.email === "") {
        alert("Email requis");
      } else if (regexEmail.test(this.email) === false) {
        alert("Adresse mail valide requise");
      }

      if (this.password === "") {
        alert("Mot de passe requis");
      } else if (regexPassword.test(this.password) === false) {
        alert(
          "Le mot de passe doit contenir au moins une majuscule, une minuscule ainsi qu'un chiffre"
        );
      } else if (
        regexText.test(this.nom) === true &&
        regexText.test(this.prenom) === true &&
        regexEmail.test(this.email) === true &&
        regexPassword.test(this.password) === true
      ) {
        fetch("http://localhost:3000/api/auth/signup", {
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
          .then(() => {
            alert("Inscription effectuée");
            this.$router.push("/");
          })
          .catch(alert);
      }
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
.login-link {
  display: flex;
  justify-content: space-between;
  margin: 10px auto;
}
.btn {
  margin: 10px auto;
}
</style>