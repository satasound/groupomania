import Vue from 'vue';
import App from './App.vue';
import router from './router';
import dotenv from 'dotenv';

import 'bootstrap/dist/css/bootstrap.min.css';

dotenv.config();

Vue.config.productionTip = false;

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
