<template>
  <div>
    <section>
      <div class="info-box">
        <div class="overlay-text">
          <p style="font-size: 1.5rem;">Inicie sess&atilde;o para reportar algu&eacute;m desaparecido ou enviar coment&aacute;rios no registo de uma pessoa desaparecida.</p><br/>
          <p style="font-size: 1.5rem;">N&atilde;o precisa iniciar sess&atilde;o para procurar por pessoas desaparecidas.</p>
        </div>
      </div>
      <div class="content-box">
        <div class="form-box">
          <h2>Iniciar sessão</h2>
          <p class="err-msg" v-if="error">{{ error }}</p>
          <form @submit.prevent="signIn">
            <div class="input-box">
              <input
                type="email"
                placeholder="E-mail"
                class="input-form"
                name="email"
                v-model="user.email"
              />
            </div>
            <div class="input-box">
              <input
                type="password"
                placeholder="Password"
                class="input-form"
                name="password"
                v-model="user.password"
              />
            </div>
            <div class="signin-box">
              <button type="submit" class="button">Entrar</button>
            </div>
            <div class="signup-box">
              <p>Caso n&atilde;o tenha uma conta e queira criar</p>
              <RouterLink to="/auth/signup" class="signup-link">Por favor, use este link</RouterLink>
            </div>
          </form>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import axios from 'axios'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'

const user = ref({
  email: null,
  password: null
})

const error = ref()
const router = useRouter()
const store = useStore()

const signIn = () => {
  try {
    axios
      .post('user/login', user.value, {
        headers: { 'Content-Type': 'application/json' }
      })
      .then((res) => {
        const userData = res.data.user; // saving the logged in user data
        const tokenExpiration = res.data.tokenExpiration;
        store.commit('setUser', userData); // Storing the user data in Vuex store
        store.commit('setAuthentication', true)
        store.commit('setTokenExpiration', tokenExpiration);

        router.push({ path: '/dashboard' })
        console.log(res.data.message)
      })
      .catch((err) => {
        error.value = err.response.data.message
      })
  } catch (error) {
    console.log(error)
  }

}
</script>

<style scoped>
div:first-child {
  --primary: #53a86c;
  --input: #607d8b;
  --hover: #2ab353;
}

section {
  position: relative;
  width: 100%;
  height: 100vh;
  display: flex;
}
section .info-box {
  position: relative;
  width: 50%;
  height: 100%;
}
section .info-box:before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
section .info-box .overlay-text {
  position: absolute;
  text-align: center;
  top: 45%;
  left: 10%;
  color: #483c3c;
}
section .content-box {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  width: 50%;
  height: 100%;
  background-color: #f7f6f9;
}
.err-msg {
  font-size: 13px;
  font-weight: 550;
  margin-bottom: 1rem;
  color: darkred;
  text-align: center;
}
section .content-box .form-box {
  width: 50%;
}
section .content-box .form-box h2 {
  color: var(--primary);
  font-weight: 600;
  font-size: 1.5em;
  margin-bottom: 20px;
  border-bottom: 4px solid var(--primary);
  display: inline-block;
  letter-spacing: 1px;
}
section .content-box .form-box .input-box,
section .content-box .form-box .signin-box,
section .content-box .form-box .signup-box {
  margin-bottom: 20px;
}
section .content-box .form-box .input-box input {
  width: 100%;
  padding: 10px 20px;
  border: none;
  outline: none;
  font-weight: 400;
  font-size: 16px;
  color: var(--input);
  background: transparent;
  box-shadow:
    2px 2px 4px #d1d9ed,
    inset -2px -2px 4px #f9f9f9;
  border-radius: 30px;
  transition: 0.25s ease;
}

section .content-box .form-box .input-box .input-form {
  color: #010101;
  font-weight: 500;
}

section .content-box .form-box .signin-box button {
  width: 100%;
  padding: 10px 20px;
  outline: none;
  font-weight: 600;
  border: 1px solid var(--primary);
  font-size: 16px;
  color: #fff;
  background-color: var(--primary);
  border-radius: 30px;
  text-transform: uppercase;
  cursor: pointer;
}

section .content-box .form-box .signin-box button:hover {
  background-color: var(--hover);
}

section .content-box .form-box .signup-box {
  text-align: center;
}

section .content-box .form-box .signup-box .signup-link {
  color: var(--primary);
  font-weight: 600;
}

section .content-box .form-box .signup-box .signup-link:hover {
  color: var(--hover);
}

@media (max-width: 768px) {
  section .info-box {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }
  section .info-box .overlay-text {
    display: none;
  }
  section .content-box {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    z-index: 1;
  }
  section .content-box .form-box {
    width: 100%;
    margin: 50px;
    padding: 40px;
    background: rgb(255 255 255 / 0.9);
  }
  section .content-box .form-box h2 {
    color: var(--primary);
    text-align: center;
    font-weight: 600;
    font-size: 2rem;
  }
  section .content-box .form-box .signup-box {
    font-size: 1.3rem;
  }
}
</style>
