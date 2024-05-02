import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

const store = createStore({
  state: {
    authenticated: false,
    user: null,
    tokenExpiration: null
  },
  mutations: {
    setAuthentication(state, status) {
      state.authenticated = status
    },
    setUser(state, userData) {
      state.user = userData;
    },
    setTokenExpiration(state, expiration) {
      state.tokenExpiration = expiration
    }
  },
  plugins: [createPersistedState()]
})

export default store
