<template>
  <div>
    <nav class="navbar">
      <RouterLink to="/" class="navbar-logo">ReEncontrar!</RouterLink>
      <div class="navbar-nav">
        <span v-if="isLoggedIn" class="user-greeting">Ol&aacute;, {{ userFullName }}.</span>
        <RouterLink v-if="isLoggedIn" to="/dashboard" class="dashboard-link">Dashboard</RouterLink>
        <RouterLink v-else to="/auth/signin" class="signin-link">Entrar</RouterLink>
        <button v-if="isLoggedIn" class="exit-route" @click="logOut()">
          <i class="bi bi-box-arrow-in-right"></i>
        </button>
      </div>
    </nav>
  </div>
</template>

<script setup>
import axios from 'axios'
import { computed } from 'vue';
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'

const router = useRouter()
const store = useStore()

const isLoggedIn = store.state.authenticated;
const userFullName = computed(() => {
  return store.state.user ? store.state.user.full_name : '';
});

const logOut = () => {
  try {
    axios
      .post('/user/logout')
      .then((res) => {
        if (res.status === 200 || res.status === 204 || res.status === 401) {
          store.commit('setAuthentication', false);
          store.commit('setUser', null);
          store.commit('setTokenExpiration', null);

          router.push({ name: 'signin' });
          console.log('Session ended successfully.');

        }else {
          // Unexpected response status
          console.log('Unexpected response:', res.status);
        }
      })
      .catch((err) => {
          
          store.commit('setAuthentication', false);
          store.commit('setUser', null);
          store.commit('setTokenExpiration', null);
          
          router.push({ name: 'signin' });

        console.log('Error during logout:', err.response.data.message);
      });
  } catch (error) {
    console.log('Error:', error);
  }
};

</script>

<style scoped>
div:first-child {
  --primary: #53a86c;
}

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 7%;
  background-color: rgba(1, 1, 1, 0.8);
  border-bottom: 1px solid #272727;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 9999;
}
.navbar .navbar-logo {
  font-size: 2rem;
  font-weight: 700;
  color: #fff;
}
.navbar .navbar-logo span {
  color: var(--primary);
}
.navbar .navbar-nav .exit-route {
  color: #fff;
  background: none;
  margin: 0 0.5rem;
  font-size: 1.5rem;
}
.signin-link, .user-greeting {
  color: #fff;
  background: none;
  margin: 0 0.5rem;
  font-size: 1.2rem;
}

.dashboard-link {
  color: var(--primary);
  background: none;
  margin: 0 0.5rem;
  font-size: 1.2rem;
}
.navbar .navbar-nav .exit-route:hover {
  color: var(--primary);
}

/* Mobile Phone */
@media only screen and (min-device-width: 320px) and (max-device-width: 480px) and (-webkit-min-device-pixel-ratio: 2) and (orientation: portrait) {
  .navbar .navbar-nav .exit-route {
    font-size: 1.8rem;
  }
}
</style>
