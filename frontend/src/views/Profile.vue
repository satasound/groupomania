<template>
  <div>
    <HeaderAdmin />
    <div>
      <h1>Mon compte</h1>
      <form>
        <ul>
          <li>
            <label for="nom" aria-label="Nom de l'utilisateur">Nom</label>
            <input
              required
              type="text"
              v-model="user.nom"
              id="nom"
              placeholder="Nom"
              size="50"
              aria-label="Nom de l'utilisateur"
            />
          </li>
          <li>
            <label for="prenom" aria-label="Prénom de l'utilisateur"
              >Prénom</label
            >
            <input
              required
              type="text"
              v-model="user.prenom"
              id="prenom"
              placeholder="Prenom"
              size="50"
              aria-label="Prénom de l'utilisateur"
            />
          </li>
          <li>
            <label for="email" aria-label="Email de l'utilisateur">Email</label>
            <input
              required
              type="email"
              v-model="user.email"
              id="email"
              placeholder="Email"
              size="50"
              aria-label="Email de l'utilisateur"
            />
          </li>
          <li v-if="user.image">
            <img
              :src="user.image"
              alt="Photo du profile"
              class="file"
              width="200px"
              height="200px"
            />
          </li>
          <li>
            <label
              v-if="!user.image"
              for="file"
              class="label-file bouton-create-comment"
              aria-label="Choisir l'image du profile"
              >Choisir une image du profile</label
            >
            <button
              v-else
              @click="deletefile()"
              class="label-file"
              aria-label="Supprimer l'image du profile'"
            >
              Supprimer cette image
            </button>
            <input
              type="file"
              accept=".jpeg, .jpg, .png, .webp"
              v-on:change="uploadFile"
              id="file"
              class="input-file"
              aria-label="Image du profile"
            />
          </li>
        </ul>
        <div class="submit">
          <button
            @click="updateUser()"
            class="button modif"
            aria-label="Modifier mon compte"
          >
            Enregistrer les modification
            <i class="fas fa-edit"></i>
          </button>
          <button
            @click="deleteUser()"
            class="button bouton-supp"
            aria-label="Supprimer mon compte"
          >
            Supprimer mon compte
            <i class="far fa-trash-alt"></i>
          </button>
        </div>
      </form>
    </div>
    <router-link
      to="/allposts"
      class="button"
      aria-label="Retour au fil d'actualité"
      >Retour aux posts</router-link
    >
  </div>
</template>

<script>
import HeaderAdmin from "../components/HeaderAdmin";

export default {
  name: "Profile",
  components: {
    HeaderAdmin,
  },
  data() {
    return {
      user: {
        id: "",
        nom: "",
        prenom: "",
        email: "",
        image: "",
      },
      preview: null,
      posts: [],
      button: false,
    };
  },
  mounted() {
    this.getUser();
  },
  methods: {
    // show: function () {
    //   return (this.button = true);
    // },
    /*************************************************
     ****************   GET USER      **************
     *************************************************/
    getUser() {
      const Id = JSON.parse(localStorage.getItem("userId"));
      const token = JSON.parse(localStorage.getItem("userToken"));

      fetch(`http://localhost:3000/api/auth/${Id}`, {
        method: "GET",
        headers: {
          authorization: `Bearer ${token}`,
        },
      })
        .then((response) => response.json())
        .then((data) => (this.user = data))
        .catch(alert);
    },
    /*************************************************
     ****************   UPDATE USER      **************
     *************************************************/
    updateUser() {
      const Id = JSON.parse(localStorage.getItem("userId"));
      const token = JSON.parse(localStorage.getItem("userToken"));
      const fileField = document.querySelector('input[type="file"]');

      const regexText = /^[a-zA-Z-\s]+$/;
      const regexEmail =
        /^[a-zA-Z0-9.-_]+[@]{1}[a-zA-Z0-9.-_]+[.]{1}[a-z]{2,10}$/;

      if (regexText.test(this.user.nom) === false) {
        alert("Champ requis! Caractères alphabétiques uniquement");
      }

      if (regexText.test(this.user.prenom) === false) {
        alert("Champ requis! Caractères alphabétiques uniquement");
      }

      if (regexEmail.test(this.user.email) === false) {
        alert("Champ requis! Adresse mail valide requise");
      } else if (
        regexText.test(this.user.nom) === true &&
        regexText.test(this.user.prenom) === true &&
        regexEmail.test(this.user.email) === true &&
        this.user.image === ""
      ) {
        let data = new FormData();
        data.append("nom", this.user.nom);
        data.append("prenom", this.user.prenom);
        data.append("email", this.user.email);
        data.append("image", "");

        fetch(`http://localhost:3000/api/auth/${Id}`, {
          method: "PUT",
          headers: {
            authorization: `Bearer ${token}`,
          },
          body: data,
        })
          .then((response) => response.json())
          .then((data) => (this.user = data))
          .then(() => {
            alert("Modifications enregistrées");
            this.$router.go();
          })
          .catch((error) => console.log(error));
      } else if (
        regexText.test(this.user.nom) === true &&
        regexText.test(this.user.prenom) === true &&
        regexEmail.test(this.user.email) === true &&
        this.user.image != ""
      ) {
        let fileName = document.getElementById("file").value;
        let idxDot = fileName.lastIndexOf(".") + 1;
        let extFile = fileName.substr(idxDot, fileName.length).toLowerCase();

        if (
          extFile === "jpg" ||
          extFile === "jpeg" ||
          extFile === "png" ||
          extFile === "webp" ||
          extFile === ""
        ) {
          let data = new FormData();
          data.append("nom", this.user.nom);
          data.append("prenom", this.user.prenom);
          data.append("email", this.user.email);
          data.append("image", fileField.files[0]);

          fetch(`http://localhost:3000/api/auth/${Id}`, {
            method: "PUT",
            headers: {
              authorization: `Bearer ${token}`,
            },
            body: data,
          })
            .then((response) => response.json())
            .then(() => {
              alert("Modifications enregistrées");
              this.$router.go();
            })
            .catch((error) => console.log(error));
        } else {
          alert("Fichiers acceptés: jpg, jpeg, png, webp");
        }
      }
    },
    /*************************************************
     ****************   DELETE USER      **************
     *************************************************/
    deleteUser() {
      if (confirm("Confirmer la suppression du compte") == true) {
        const Id = JSON.parse(localStorage.getItem("userId"));
        const token = JSON.parse(localStorage.getItem("userToken"));
        /*******  FETCH des posts de l'utilisateur ********/
        fetch(`http://localhost:3000/api/posts/${Id}/posts`, {
          method: "GET",
          headers: {
            authorization: `Bearer ${token}`,
          },
        })
          .then((response) => response.json())
          .then((data) => (this.posts = data))
          .then(() => {
            let userPosts = this.posts;
            /******** Boucle pour retrouver les posts concernés  *********/
            for (let i = 0; i < userPosts.length; i++) {
              if (userPosts[i].image) {
                /********  suppression des posts  ********/
                fetch(`http://localhost:3000/api/posts/${userPosts[i].id}`, {
                  method: "DELETE",
                  headers: {
                    authorization: `Bearer ${token}`,
                  },
                })
                  .then((response) => response.json())
                  .catch((error) => console.log(error));
              }
            }
          })
          /******** suppression du user ********/
          .then(() => {
            fetch(`http://localhost:3000/api/auth/${Id}`, {
              method: "DELETE",
              headers: {
                authorization: `Bearer ${token}`,
              },
            })
              .then((response) => response.json())
              .then(() => {
                alert("Confirmer la suppression du compte");
              })
              .catch((error) => console.log(error));
          })
          .catch((error) => console.log(error));
      }
      /*******  Redirection vers Accueil/login  *******/
      this.$router.push("/");
      localStorage.clear();
    },
    /*************************************************
     ****************   UPLOAD FILE      **************
     *************************************************/
    uploadFile(e) {
      if (e.target.files) {
        let reader = new FileReader();
        reader.onload = (event) => {
          this.preview = event.target.result;
          this.user.image = event.target.result;
        };
        reader.readAsDataURL(e.target.files[0]);
      }
    },
    // DELETE FILE
    deletefile() {
      this.user.image = "";
    },
  },
};
</script>

<style scoped>
h1 {
  width: 60%;
  margin: 20px auto;
  font-size: 1.7vw;
  background: #e8e8e8;
  border: 2px solid #b4b3b2;
  border-radius: 5px;
  padding: 8px;
}

ul {
  display: flex;
  flex-direction: column;
  align-items: center;
  list-style: none;
  padding: 0;
}

label {
  font-size: 1.3rem;
}

li {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 50%;
}

input {
  font-size: 1.2rem;
}

.file {
  width: 200px;
  height: 200px;
  margin-top: 10px;
  border: 2px solid #377e7d;
  border-radius: 100px;
}

.input-file {
  display: none;
}

.button,
.label-file {
  margin: 10px 10px;
  padding: 5px 30px;
  border: 2px solid #b4b3b2;
  border-radius: 6px;
  text-decoration: none;
  color: #000000;
  background: #e8e8e8;
  font-size: 1rem;
  cursor: pointer;
}
.modif {
  margin: 10px 10px;
  padding: 5px 30px;
  border: 2px solid #b4b3b2;
  border-radius: 6px;
  text-decoration: none;
  color: #000000;
  background: #daf3f2;
  font-size: 1rem;
  cursor: pointer;
}
.label-file {
  margin-bottom: 30px;
}

.espacement {
  margin-left: 10px;
}
.bouton-supp {
  margin: 10px 10px;
  padding: 5px 30px;
  border: 2px solid #f68c76;
  border-radius: 6px;
  background: #ffd7d7;
  font-size: 1rem;
  cursor: pointer;
}
.submit {
  margin-bottom: 30px;
}

@media screen and (max-width: 1024px) {
  h1 {
    width: 98%;
    font-size: 1.5rem;
  }

  input,
  label {
    font-size: 1rem;
  }
}

@media screen and (max-width: 768px) {
  h1 {
    font-size: 1.2rem;
  }

  input,
  label {
    font-size: 0.8rem;
  }

  .submit {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .button {
    width: 50%;
    margin-bottom: 0;
  }

  .espacement {
    margin-left: 0;
  }
  .bouton-create-comment {
    margin: 50px 0 20px 0;
    padding: 5px;
    border: 2px solid #b4b3b2;
    border-radius: 10px;
    background: #daf3f2;
    font-size: 15px;
    width: 50%;
    cursor: pointer;
  }
}
</style>