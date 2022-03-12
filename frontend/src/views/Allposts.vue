<template>
  <div class="container-fluid">
    <HeaderProfile />

    <!--ECRIRE ARTICLE-->
    <button @click="createPost()" class="button">Créer un post</button>

    <h2>Fil d'actualité</h2>

    <!--SI PAS D'ARTICLES-->
    <article v-if="posts.length == 0">
      <p>Désolé il n'y a aucune publication...</p>
    </article>
    <!--GOLBAL-->
    <div
      class="card"
      id="cardGlobale"
      style="width: 50rem"
      v-else
      v-bind:key="index"
      v-for="(post, index) in posts"
    >
      <router-link :to="`/post/${post.id}`" class="lien">
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

        <!------------------------------------------------------------------------------------>
        <!-- <p v-for="post in posts" :key="post.id">
        {{ post.title }}
      </p> -->

        <div class="card-body" id="article">
          <p class="card-text">
            {{ post.content }}
          </p>
          <img :src="post.imageUrl" class="card-img-top imageUrl" alt="..." />
          <p>{{ post.comments.length }} <i class="fas fa-comments link"></i></p>
        </div>
      </router-link>
    </div>
  </div>
</template>

<script>
import HeaderProfile from "../components/HeaderProfile";

export default {
  name: "allposts",
  components: {
    HeaderProfile,
  },
  data() {
    return {
      posts: [],
    };
  },
  methods: {
    getPosts() {
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
    createPost() {
      this.$router.push("/createpost");
    },
  },
  mounted() {
    this.getPosts();
  },
};
</script>

<style scoped>
.lien {
  padding-left: 30px;
  font-size: 1rem;
  text-decoration: none;
  cursor: pointer;
  color: #525151;
}
h3 {
}
.container-fluid {
  margin: 40px auto;
  padding: 20px;
}
form {
  width: 50rem;
  margin: 40px auto;
}
#article {
  background-color: #daf3f2 !important;
}
#cardGlobale {
  padding: 0;
  margin: 40px auto;
}
.card-header {
  padding: 0;
}
.card {
  margin: 0 auto;
}
#userInfos {
  flex-direction: column;
  background-color: #f7e6e6 !important;
}
#infos {
  font-size: 1vw;
  background-color: #e7e7e7;
}
#commentInfos {
  flex-direction: row;
}
.card-body {
  text-align: center;
  border-bottom: 2px solid rgb(185, 181, 181);
}
.photo-profile {
  width: 6%;
  margin: 0 5px 5px;
}
.likes {
  display: flex;
  justify-content: space-between;
}
/* .card .likes .link img {
  max-width: 100%;
  width: 80%;
} */

.card img {
  /* width: 80%; */
  /* max-width: 100%;
  height: auto;
  padding: 1.25rem; */
}
hr.style1 {
  border-top: 1px solid #000000;
}

/* .row {
  display: inline;
} */
</style>