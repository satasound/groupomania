<template>
  <div>
    <HeaderAdmin />
    <section>
      <h1>Création d'un post</h1>
      <form>
        <ul>
          <li>
            <input
              type="text"
              v-model="titre"
              placeholder="Titre"
              size="50"
              required
              aria-label="Titre du post"
            />
          </li>
          <li v-if="image">
            <img :src="image" alt="Image du post" class="file" />
          </li>
          <li>
            <label
              v-if="!image"
              for="file"
              class="label-file"
              aria-label="Choisir une photo pour ce post"
              >Choisir une image</label
            >
            <button
              v-else
              @click="deletefile()"
              class="label-file"
              aria-label="Supprimer cette photo du post"
            >
              Supprimer cette image
            </button>
            <input
              type="file"
              accept=".jpeg, .jpg, .png, .webp, .gif"
              v-on:change="uploadFile"
              id="file"
              class="input-file"
              aria-label="Image du post"
            />
          </li>
          <li>
            <textarea
              v-model="contenu"
              placeholder="Contenu"
              rows="10"
              cols="60"
              required
              aria-label="Message du post"
            ></textarea>
          </li>
        </ul>
      </form>
      <button @click="createPost()" class="button" aria-label="Créer ce post">
        Créer le post
      </button>
      <div>
        <router-link
          to="/allposts"
          class="button lien"
          aria-label="Retour au fil d'actualité"
          >Retour aux posts</router-link
        >
      </div>
    </section>
  </div>
</template>


<script>
import HeaderAdmin from "../components/HeaderAdmin";

export default {
  name: "createpost",
  components: {
    HeaderAdmin,
  },
  data() {
    return {
      titre: "",
      contenu: "",
      image: "",
      preview: null,
    };
  },
  methods: {
    createPost() {
      const Id = JSON.parse(localStorage.getItem("userId"));
      const fileField = document.querySelector('input[type="file"]');
      const token = JSON.parse(localStorage.getItem("userToken"));

      if (this.titre === "") alert("Veuillez saisir le titre");
      if (this.contenu === "") alert("Veuillez saisir le message");
      if (this.image === "" /* && this.titre != "" && this.contenu != ""*/) {
        let data = new FormData();
        data.append("title", this.titre);
        data.append("content", this.contenu);
        data.append("user_id", Id);

        fetch("http://localhost:3000/api/posts", {
          method: "POST",
          headers: {
            authorization: 'Bearer ' + token,
          },
          body: data,
        })
          .then((response) => {
            return response.json();
          })
          .then(() => {
            this.$router.push("/allposts");
          })
          .catch(alert);
      } /*else if (this.titre != "" && this.contenu != "")*/ else {
        var fileName = document.getElementById("file").value;
        var idxDot = fileName.lastIndexOf(".") + 1;
        var extFile = fileName.substr(idxDot, fileName.length).toLowerCase();

        if (
          extFile === "jpg" ||
          extFile === "jpeg" ||
          extFile === "png" ||
          extFile === "webp" ||
          extFile === "gif"
        ) {
          let data = new FormData();
          data.append("image", fileField.files[0]);
          data.append("title", this.titre);
          data.append("content", this.contenu);
          data.append("user_id", Id);

          fetch("http://localhost:3000/api/posts", {
            method: "POST",
            headers: {
              authorization: 'Bearer ' + token,
            },
            body: data,
          })
            .then((response) => response.json())
            .then(() => {
              this.$router.push("/allposts");
            })
            .catch(alert);
        } else {
          alert("Fichiers acceptés: jpg, jpeg, png, webp");
        }
      }
    },
    uploadFile(e) {
      if (e.target.files) {
        let reader = new FileReader();
        reader.onload = (event) => {
          this.preview = event.target.result;
          this.image = event.target.result;
        };
        reader.readAsDataURL(e.target.files[0]);
      }
    },
    deletefile() {
      this.image = "";
    },
  },
};
</script>


<style scoped>
h1 {
  margin: 50px auto;
  padding: 10px;
  border: 2px solid #b4b3b2;
  background: #e8e8e8;
  font-size: 15px;
  cursor: pointer;
  width: 55%;
}

ul {
  padding: 0;
}

li {
  margin: 30px 0;
  list-style-type: none;
}

input {
  height: 30px;
  font-size: 1.5rem;
}

.file {
  width: 300px;
  height: 300px;
  margin-top: 10px;
  border: 2px solid #69bdba;
  border-radius: 10px;
  padding: 5px;
}

.input-file {
  display: none;
}

textarea {
  font-size: 1.3rem;
}

.button,
.label-file {
  margin: 10px 0 30px 0;
  padding: 5px 30px;
  border: 2px solid #b4b3b2;
  border-radius: 10px;
  background: #daf3f2;
  font-size: 1rem;
  cursor: pointer;
}

.lien {
  text-decoration: none;
  color: #000000;
}

@media screen and (max-width: 1024px) {
  h1 {
    font-size: 1.5rem;
  }

  input {
    font-size: 1rem;
  }

  textarea {
    font-size: 1rem;
  }

  ::placeholder {
    font-size: 1.5rem;
  }

  .file {
    height: 300px;
  }
}

@media screen and (max-width: 768px) {
  h1 {
    font-size: 1.2rem;
  }

  input {
    font-size: 0.6rem;
  }

  textarea {
    font-size: 0.6rem;
  }

  .file {
    height: 200px;
  }

  ::placeholder {
    font-size: 1.2rem;
  }
}
</style>