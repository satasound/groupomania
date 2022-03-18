<template>
  <div>
    <HeaderAdmin />
    <article>
      <table>
        <tr>
          <th>Image</th>
          <th>Nom</th>
          <th>Prénom</th>
          <th>Email</th>
          <th>Rôle</th>
          <th>Status</th>
        </tr>
        <tr v-bind:key="index" v-for="(user, index) in filterList">
          <td>
            <img v-if="user.image" :src="user.image" alt="Image du profile" />
          </td>
          <td>
            <input
              type="text"
              v-model="user.nom"
              required
              aria-label="Nom"
              disabled
            />
          </td>
          <td>
            <input
              type="text"
              v-model="user.prenom"
              required
              aria-label="Prénom"
              disabled
            />
          </td>
          <td>
            <input
              type="text"
              v-model="user.email"
              required
              aria-label="Email"
              disabled
            />
          </td>
          <td>
            <select
              v-model="user.role"
              name="role"
              id="role-select"
              aria-label="Role"
            >
              <option value="1" aria-label="Role administrateur">Admin</option>
              <option value="0" aria-label="Role Utilisateur">
                Utilisateur
              </option>
            </select>
          </td>

          <button
            @click="modifyUser(index)"
            aria-label="Modifier cet utilisateur"
          >
            <i class="fas fa-edit"></i>
          </button>
          <button
            @click="deleteUser(index)"
            aria-label="Supprimer cet utilisateur"
            class="buttonSupp"
            v-if="user.role !== 1"
          >
            <i class="far fa-trash-alt"></i>
          </button>
        </tr>
      </table>
      <router-link
        to="/allposts"
        class="button"
        aria-label="Retour au fil d'actualité"
        >Retour aux posts</router-link
      >
    </article>
  </div>
</template>

<script>
import HeaderAdmin from "../components/HeaderAdmin";

export default {
  name: "Admin",
  components: {
    HeaderAdmin,
  },
  data() {
    return {
      users: [],
      posts: [],
    };
  },
  computed: {
    filterList() {
      return this.users.filter((user) => {
        return user.nom.toLowerCase();
      });
    },
  },
  methods: {
    /**********************************************
     **************     GET USERS      ***********
     **********************************************/
    getUsers() {
      const token = JSON.parse(localStorage.getItem("userToken"));

      fetch("http://localhost:3000/api/auth/", {
        method: "GET",
        headers: {
          authorization: 'Bearer ' + token,
        },
      })
        .then((response) => response.json())
        .then((data) => (this.users = data))
        .catch(alert);
    },
    /*************************************************
     ***************   DELETE USER      *************
     *************************************************/
    deleteUser(index) {
      const token = JSON.parse(localStorage.getItem("userToken"));

      if (confirm("Confirmer la suppression de cet utilisateur") === true) {
        /*******  FETCH des posts de l'utilisateur ********/
        fetch(
          `http://localhost:3000/api/posts/${this.filterList[index].id}/posts`,
          {
            method: "GET",
            headers: {
              authorization: 'Bearer ' + token,
            },
          }
        )
          .then((response) => response.json())
          .then((data) => (this.posts = data))
          .then(() => {
            /******** Boucle pour retrouver les posts concernés  *********/
            let userPosts = this.posts;

            for (let i = 0; i < userPosts.length; i++) {
              if (userPosts[i].image) {
                /********  suppression des posts  ********/
                fetch(`http://localhost:3000/api/posts/${userPosts[i].id}`, {
                  method: "DELETE",
                  headers: {
                    authorization: 'Bearer ' + token,
                  },
                })
                  .then((response) => response.json())
                  .catch((error) => console.log(error));
              }
            }
          })
          .then(() => {
            /******** suppression du user ********/
            fetch(
              `http://localhost:3000/api/auth/${this.filterList[index].id}`,
              {
                method: "DELETE",
                headers: {
                  authorization: 'Bearer ' + token,
                },
              }
            )
              .then((response) => response.json())
              .then(() => {
                this.$router.go();
              })
              .catch((error) => console.log(error));
          })
          .catch((error) => console.log(error));
      }
    },
    /*************************************************
     ****************   MODIFY USER      **************
     *************************************************/
    modifyUser(index) {
      const token = JSON.parse(localStorage.getItem("userToken"));

      if (confirm("Confirmer la modification de cet utilisateur") === true) {
        fetch(
          `http://localhost:3000/api/auth/admin/${this.filterList[index].id}`,
          {
            method: "PUT",
            headers: {
              Accept: "application/json",
              "Content-Type": "application/json",
              authorization: 'Bearer ' + token,
            },
            body: JSON.stringify(this.filterList[index]),
          }
        )
          .then((response) => response.json())
          .then((data) => (this.filterList[index] = data))
          .then(() => {
            this.$router.go();
          })
          .catch((error) => console.log(error));
      }
    },
  },
  mounted() {
    this.getUsers();
  },
};
</script>

<style scoped>
table {
  width: 95%;
  font-size: 1vw;
  background: #daf3f2;
  border: 2px solid #90b9b8;
  border-radius: 10px;
  margin: 50px auto;
  padding: 10px;
}

button {
  margin: 10px 5px 0 0;
  padding: 5px 5px;
  border: 2px solid #90b9b8;
  border-radius: 5px;
  background: #bbeeec;
  font-size: 1vw;
  cursor: pointer;
  text-decoration: none;
  color: #000000;
}

.button {
  margin: 10px 0 30px 0;
  padding: 5px 3vw;
  border: 2px solid #90b9b8;
  border-radius: 6px;
  background: #daf3f2;
  font-size: 1vw;
  cursor: pointer;
  text-decoration: none;
  color: #000000;
}
.buttonSupp {
  margin: 10px 0 30px 0;
  padding: 5px;
  border: 2px solid #fd2d01;
  border-radius: 5px;
  background: #ffd7d7;
  font-size: 1vw;
  cursor: pointer;
  text-decoration: none;
  color: #000000;
}

input {
  font-size: 1vw;
}

hr {
  background-color: #fd2d01;
}

img {
  width: 50px;
  height: 50px;
  border: 2px solid #4b8d8c;
  border-radius: 30px;
}

select {
  background-color: white;
}

@media screen and (max-width: 1024px) {
  input {
    font-size: 1vw;
  }

  .search {
    font-size: 1rem;
    height: 30px;
  }
}
@media screen and (max-width: 768px) {
  input:not(.search) {
    width: 85vw;
    height: 5vw;
    font-size: 0.9rem;
  }
  select {
    width: 86vw;
    height: 5vw;
    font-size: 0.9rem;
  }

  button {
    margin: 0 0 5px 0;
    padding: 5px 10px;
  }

  i {
    font-size: 1rem;
  }

  .search {
    font-size: 3vw;
    height: 30px;
  }

  th {
    display: none;
  }

  tr {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .button {
    margin-bottom: 50px;
    font-size: 0.8rem;
  }
}
</style>