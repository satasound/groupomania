import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '../views/Home.vue';
import Signup from '../views/Signup.vue';
import Allposts from '../views/Allposts.vue';
import Profile from '../views/Profile.vue';
import Post from '../views/Post.vue';
import Createpost from '../views/Createpost.vue';
import Admin from '../views/Admin.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
  },
  {
    path: '/signup',
    name: 'Signup',
    component: Signup,
  },
  {
    path: '/allposts',
    name: 'Allposts',
    component: Allposts,
  },
  {
    path: '/profile',
    name: 'Profile',
    component: Profile,
  },
  {
    path: '/post/:id',
    name: 'Post',
    component: Post,
  },
  {
    path: '/createPost',
    name: 'CreatePost',
    component: Createpost,
  },
  {
    path: '/admin',
    name: 'Admin',
    component: Admin,
  },
];

const router = new VueRouter({
  mode: 'history',
  routes,
});

export default router;
