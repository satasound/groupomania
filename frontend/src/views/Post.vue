<template>
  <div>
    <HeaderProfile />
    <section>
      <div class="card" id="cardGlobale" style="width: 50rem">
        <div class="card-header">
          <!--User infos-->
          <div class="card" id="userInfos">
            <div class="card-body" id="infos">
              Posté par <b>{{ post.user.prenom }} {{ post.user.nom }}</b>

              <img
                class="photo-profile"
                v-if="post.user.image"
                :src="post.user.image"
                alt="photo de profile"
              />
              <img
                class="photo-profile"
                v-else
                src="../assets/images/photo-profile.jpg"
                alt="photo de profile"
              /><br />
              <span class="card-text"
                >le {{ dateFormat(post.created_date) }}</span
              >&nbsp;
              <span class="card-text"
                >à {{ hourFormat(post.updated_date) }}</span
              >
              <p v-if="post.created_date != post.updated_date" class="info">
                Modifié le <b>{{ dateFormat(post.updated_date) }}</b> à
                <b>{{ hourFormat(post.updated_date) }}</b>
              </p>
            </div>
            <h3 class="card-title" id="titre">{{ post.title }}</h3>
          </div>
          <!--END User infos-->
        </div>

        <div class="card-body" id="article">
          <p class="card-text">
            {{ post.content }}
          </p>
          <img :src="post.imageUrl" class="card-img-top imageUrl" alt="..." />
        </div>
      </div>

      <article>
        <div
          v-bind:key="index"
          v-for="(comment, index) in comments"
          class="comment"
        >
          <div>
            <p class="info">
              Posté par
              <b>{{ comment.user.prenom }} {{ comment.user.nom }}</b>
              <img
                class="photo-profile"
                v-if="comment.user.image"
                :src="comment.user.image"
                alt="photo de profile"
              />
              <img
                class="photo-profile"
                v-else
                src="../assets/images/photo-profile.jpg"
                alt="photo de profile"
              /><br />
              le <b>{{ dateFormat(comment.date) }}</b> à
              <b>{{ hourFormat(comment.date) }}</b>
            </p>
            <p>
              <button
                v-if="comment.user_id === id || role === 1"
                @click="deleteComment(index)"
                class="button-comment"
                aria-label="Supprimer ce commentaire"
              >
                <i class="far fa-trash-alt"></i>
              </button>
            </p>
          </div>
          <hr />
          <p class="comment-content">{{ comment.content }}</p>
        </div>
      </article>

      <button
        v-if="displayCreateComment === false"
        v-on:click="show"
        class="button"
        aria-label="Ecrire un commentaire"
      >
        Ecrire un commentaire
      </button>
      <article v-if="displayCreateComment" class="createcomment">
        <textarea
          v-model="commentaire"
          placeholder="Commentaire"
          cols="60"
          rows="5"
          aria-label="Message du commentaire"
        ></textarea>
        <button
          @click="createComment()"
          class="buttonenvoyer"
          aria-label="Envoyer le commentaire"
        >
          Envoyer le commentaire
        </button>
      </article>
    </section>
    <router-link to="/allposts" class="button link" aria-label="Retour au post"
      >Retour aux posts</router-link
    >
  </div>
</template>

<script>
import HeaderProfile from "../components/HeaderProfile";

export default {
  name: "Post",
  components: {
    HeaderProfile,
  },
  data() {
    return {
      id_param: this.$route.params.id,
      post: {
        content: "",
        created_date: "",
        updated_date: "",
        id: "",
        image: "",
        title: "",
        user: {},
        user_id: "",
      },
      comments: [],
      displaycomments: false,
      displayCreateComment: false,
      commentaire: "",
      id: "",
      role: "",
    };
  },
  methods: {
    show: function () {
      return (this.displayCreateComment = true);
    },
    User() {
      this.id = JSON.parse(localStorage.getItem("userId"));
      this.role = JSON.parse(localStorage.getItem("role"));
    },

    getPost() {
      const token = JSON.parse(localStorage.getItem("userToken"));

      fetch(`http://localhost:3000/api/posts/${this.id_param}`, {
        method: "GET",
        headers: {
          authorization: `Bearer ${token}`,
        },
      })
        .then((response) => response.json())
        .then((data) => (this.post = data))
        .catch(alert);
    },

    getComments() {
      const token = JSON.parse(localStorage.getItem("userToken"));

      fetch(`http://localhost:3000/api/comments/${this.id_param}`, {
        method: "GET",
        headers: {
          authorization: `Bearer ${token}`,
        },
      })
        .then((response) => response.json())
        .then((data) => (this.comments = data))
        .catch(alert);
    },
    dateFormat(createdDate) {
      const date = new Date(createdDate);
      const options = {
        weekday: "long",
        day: "numeric",
        month: "long",
        year: "numeric",
      };
      return date.toLocaleDateString("fr-FR", options);
    },
    hourFormat(createdHour) {
      const hour = new Date(createdHour);
      const options = { hour: "numeric", minute: "numeric", second: "numeric" };
      return hour.toLocaleTimeString("fr-FR", options);
    },
    deletePost() {
      const token = JSON.parse(localStorage.getItem("userToken"));

      if (confirm("Voulez-vous vraiment supprimer le post") === true) {
        fetch(`http://localhost:3000/api/posts/${this.id_param}`, {
          method: "DELETE",
          headers: {
            authorization: `Bearer ${token}`,
          },
        })
          .then((response) => response.json())
          .then(() => {
            this.$router.push("/allposts");
          })
          .catch(alert);
      }
    },
    createComment() {
      if (this.commentaire === "") {
        alert("Veuillez remplir votre commentaire");
      } else {
        const Id = JSON.parse(localStorage.getItem("userId"));
        const token = JSON.parse(localStorage.getItem("userToken"));

        let data = {
          content: this.commentaire,
          post_id: this.id_param,
          user_id: Id,
        };

        fetch("http://localhost:3000/api/comments", {
          method: "POST",
          headers: {
            Accept: "application/json",
            "Content-Type": "application/json",
            authorization: `Bearer ${token}`,
          },
          body: JSON.stringify(data),
        })
          .then((response) => {
            return response.json();
          })
          .then(() => {
            this.$router.go();
          })
          .catch((error) => console.log(error));
      }
    },
    deleteComment(index) {
      const token = JSON.parse(localStorage.getItem("userToken"));

      if (confirm("Voulez-vous vraiment supprimer ce commentaire") === true) {
        fetch(`http://localhost:3000/api/comments/${this.comments[index].id}`, {
          method: "DELETE",
          headers: {
            authorization: `Bearer ${token}`,
          },
        })
          .then((response) => response.json())
          .then(() => {
            alert("La suppression du commentaire est bien prise en compte");
            this.$router.go();
          })
          .catch(alert);
      }
    },
  },
  mounted() {
    this.User();
    this.getPost();
    this.getComments();
  },
};
</script>

<style scoped>
section {
  display: flex;
  flex-direction: column;
  align-items: center;
}

h1 {
  font-size: 1.5rem;
  margin: 30px 0 10px 0;
}

textarea {
  font-size: 1.2rem;
}

.header,
.content {
  width: 50%;
  background: #ffd7d7;
  border: 2px solid #fd2d01;
}

.header {
  display: flex;
  flex-direction: column;
  justify-content: center;
  border-radius: 20px 20px 0 0;
}

.content {
  border-radius: 0 0 20px 20px;
}

.info {
  font-size: 0.8rem;
}

.modif {
  margin: 0;
}

.content {
  margin-bottom: 30px;
}

.createcomment {
  display: flex;
  flex-direction: column;
}

.button {
  margin: 10px 0 30px 0;
  padding: 5px 25px;
  border: 2px solid #fd2d01;
  border-radius: 10px;
  background: #ffd7d7;
  font-size: 1rem;
  cursor: pointer;
}

.buttonenvoyer,
.buttonannuler {
  margin: 10px 0 10px 0;
  padding: 5px 30px;
  border: 2px solid #fd2d01;
  border-radius: 10px;
  background: #ffd7d7;
  font-size: 1rem;
  cursor: pointer;
}

.buttonannuler {
  margin-bottom: 40px;
}

.button-comment {
  margin: 10px 0 0 0;
  padding: 5px 5px;
  border: 2px solid #fd2d01;
  border-radius: 10px;
  background: #ffd7d7;
  font-size: 1rem;
  cursor: pointer;
}

.espacement {
  margin: 5px 0 0 10px;
}

.link {
  text-decoration: none;
  color: #000000;
}

.comment-button {
  margin: 10px 0 30px 0;
  padding: 5px 30px;
  border: 2px solid #fd2d01;
  border-radius: 10px;
  background: #ffd7d7;
  font-size: 1rem;
  cursor: pointer;
}

.comment {
  border: 2px solid #000000;
  border-radius: 20px;
  margin-bottom: 20px;
}

.comment-info,
.comment-content {
  padding: 0 30px 0 30px;
}

img {
  width: 70%;
  border-radius: 30px;
}

.content img {
  margin-top: 10px;
}

.photo-profile {
  width: 50px;
  height: 50px;
  border: 2px solid #fd2d01;
  border-radius: 30px;
}

@media screen and (max-width: 1024px) {
  .header,
  .content {
    width: 90%;
  }
}

@media screen and (max-width: 768px) {
  .header,
  .content {
    width: 98%;
  }

  .modif {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .espacement {
    margin: 0;
  }

  .button {
    width: 50%;
  }

  .createcomment {
    width: 100%;
  }
}
</style>