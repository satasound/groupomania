<template>
  <div>
    <Header />
    <Login />
  </div>
</template>

<script>
import Header from "../components/Header";
import Login from "../components/Login";

export default {
  name: "home",
  components: {
    Header,
    Login,
  },
};
</script>

<style scoped>
</style>