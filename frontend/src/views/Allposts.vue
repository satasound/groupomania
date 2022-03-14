<template>
  <div>
    <HeaderAdmin />

    <button @click="createPost()" class="button">Créer un post</button>

    <h1>Fil d'actualité</h1>

    <article v-if="posts.length == 0">
      <p>Désolé il n'y a aucune publication...</p>
    </article>
    <article v-else v-bind:key="index" v-for="(post, index) in posts">
      <router-link :to="`/post/${post.id}`" class="post">
        <div class="header">
          <div>
            <p class="info">
              Posté par
              <b
                >{{ post.user.nom }}
                <span v-if="post.user.role != 0"
                  >{{ post.user.prenom }}
                </span></b
              >
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
              le <b>{{ formatDate(post.created_date) }}</b> à
              <b>{{ formatTime(post.created_date) }}</b>
            </p>
            <p v-if="post.created_date != post.updated_date" class="info">
              Modifié le <b>{{ formatDate(post.updated_date) }}</b> à
              <b>{{ formatTime(post.updated_date) }}</b>
            </p>
            <hr />
            <h2>{{ post.title }}</h2>
          </div>
        </div>
        <div class="content">
          <p class="message"></p>
          <br />
          <p class="text">{{ post.content }}</p>
          <img
            class="post-image"
            v-if="post.image"
            :src="post.image"
            :alt="post.title"
          />
          <!-- <p>{{ post.comments.length }} <i class="fas fa-comments link"></i></p> -->
          <p>
            {{ post.comments.length }}
            <i class="fas fa-comments link"></i>Commentaires
          </p>
        </div>
      </router-link>
    </article>
  </div>
</template>

<script>
import HeaderAdmin from "../components/HeaderAdmin";

export default {
  name: "allposts",
  components: {
    HeaderAdmin,
  },
  data() {
    return {
      posts: [],
    };
  },
  methods: {
    /*************************************************
     ****************   GET ALL POSTS      **************
     *************************************************/
    getAllPosts() {
      const token = JSON.parse(localStorage.getItem("userToken"));

      fetch("http://localhost:3000/api/posts/", {
        method: "GET",
        headers: {
          authorization: `Bearer ${token}`,
        },
      })
        .then((response) => response.json())
        .then((data) => (this.posts = data))
        .catch((error) => console.log(error));
    },
    /*************************************************
     **********   FORMATDATE FORMATTIME      ********
     *************************************************/
    formatDate(createdDate) {
      const date = new Date(createdDate);
      const options = {
        day: "numeric",
        month: "numeric",
        year: "numeric",
      };
      return date.toLocaleDateString("fr-FR", options);
    },
    formatTime(createdTime) {
      const hour = new Date(createdTime);
      const options = { hour: "numeric", minute: "numeric", second: "numeric" };
      return hour.toLocaleTimeString("fr-FR", options);
    },
    /*************************************************
     **********   REDIRECTION CREATEPOST      ********
     *************************************************/
    createPost() {
      this.$router.push("/createpost");
    },
  },
  mounted() {
    this.getAllPosts();
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

h2 {
  font-size: 2vw;
  margin: 10px 0;
}

.info {
  margin: 5px 0 5px 0;
  font-size: 0.9vw;
}
hr {
  margin: 0;
}
.image {
  height: 15vw;
  border-radius: 30px;
}
.post-image {
  height: 20vw;
  border-radius: 6px;
}
article {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-decoration: none;
  color: #000000;
  width: 60%;
  margin: auto;
}
.post {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-decoration: none;
  color: #000000;
  width: 100%;
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

.button {
  margin: 50px 0 20px 0;
  padding: 5px 40%;
  border: 2px solid #b4b3b2;
  border-radius: 10px;
  background: #daf3f2;
  font-size: 15px;
  cursor: pointer;
}

::placeholder {
  text-align: center;
  font-size: 1.3vw;
}

.photo-profile {
  width: 50px;
  height: 50px;
  border: 2px solid #94c9c7;
  border-radius: 100px;
}

.text {
  font-size: 1.4vw;
}
.content p {
  margin: 1rem;
}

@media screen and (max-width: 1024px) {
  h1 {
    font-size: 1.7rem;
    width: 63%;
  }

  h2 {
    font-size: 1.5rem;
    margin: 20px 0 10px 0;
  }

  .info {
    font-size: 0.9rem;
  }

  .image {
    height: 30vw;
  }

  .header,
  .content {
    width: 70%;
  }

  .text {
    font-size: 2vw;
  }

  ::placeholder {
    font-size: 20px;
  }

  article {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-decoration: none;
    color: #000000;
    width: 90%;
    margin: auto;
  }

  .photo-profile {
    width: 50px;
  }
}

@media screen and (max-width: 768px) {
  h1 {
    width: 98%;
    margin-left: 5px;
    font-size: 1.2rem;
  }

  .button {
    font-size: 10px;
  }

  .header,
  .content {
    width: 98%;
  }

  .text {
    font-size: 1.3rem;
  }

  .image {
    height: 40vw;
  }

  ::placeholder {
    font-size: 1rem;
  }

  @media screen and (max-width: 360px) {
  }
}
</style>