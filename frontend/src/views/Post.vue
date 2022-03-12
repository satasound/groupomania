<template>
  <div>
    <HeaderProfile />
    <section>
      <div class="header">
        <div>
          <div class="info">
            <p>
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
              le <b>{{ dateFormat(post.created_date) }}</b> à
              <b>{{ hourFormat(post.created_date) }}</b
              ><br />
            </p>
            <p v-if="post.created_date != post.updated_date">
              Modifié le <b>{{ dateFormat(post.updated_date) }}</b> à
              <b>{{ hourFormat(post.updated_date) }}</b>
            </p>
            <hr />
            <h1>{{ post.title }}</h1>
          </div>
        </div>
      </div>

      <div class="content">
        <p class="modif">
          <button
            @click="deletePost()"
            v-if="post.user_id === id || role === 1"
            class="button espacement"
            aria-label="Supprimer ce post"
          >
            <i class="far fa-trash-alt"></i> Supprimer
          </button>
        </p>
        <hr v-if="post.user_id === id || role === 1" />
        <img v-if="post.image" :src="post.image" alt="Image du post" />
        <p>{{ post.content }}</p>
      </div>
      <!---------------------------Comments----->
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
        class="button bouton-create-comment"
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
          class="bouton-create-comment"
          aria-label="Envoyer le commentaire"
        >
          Envoyer le commentaire
        </button>
      </article>
    </section>
    <router-link
      to="/allposts"
      class="button link bouton-create-comment"
      aria-label="Retour au post"
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
  width: 60%;
  margin: 50px auto;
}
article {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  margin: 50px auto;
}
h1 {
  font-size: 2vw;
  margin: 30px 0 10px 0;
}

textarea {
  font-size: 1.2rem;
}

.header {
  width: 100%;
  background: #daf3f2;
  border-radius: 8px 8px 0 0;
  border: 2px solid #b4b3b2;
}

.content {
  width: 100%;
  background: #eff8f8;
  border: 2px solid #b4b3b2;
  margin-bottom: 30px;
  border-radius: 0 0 8px 8px;
}

.info {
  margin-top: 5px;
  font-size: 1vw;
}
.info p {
  margin-bottom: 5px;
  font-size: 1vw;
}
hr {
  margin: 0;
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
  border: 2px solid #f68c76;
  border-radius: 6px;
  background: #f7dddd;
  font-size: 1rem;
  cursor: pointer;
}

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
  border: 2px solid #f68c76;
  border-radius: 6px;
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
  border: 2px solid #b4b3b2;
  border-radius: 6px;
  margin-bottom: 20px;
  width: 100%;
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
  border: 2px solid #94c9c7;
  border-radius: 10px;
  margin-left: 5px;
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