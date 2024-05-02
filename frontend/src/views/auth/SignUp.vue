<template>
  <div  class="general-info">
    <section>
      <div class="content-box">
        <div class="form-box">
          <h2>Cria&ccedil;&atilde;o de conta de usu&aacute;rio</h2>
          <p class="err-msg" v-if="error">{{ error }}</p>
          <form @submit.prevent="submitForm">
            <div class="input-box">
              <input type="text" placeholder="Nome completo" class="input-form" name="full_name" v-model="user.full_name"/>
            </div>
            <div class="input-box">
              <input type="email" placeholder="Email" class="input-form" name="email" v-model="user.email"/>
            </div>
            <div class="input-box">
              <input type="text" placeholder="Nome de usu&aacute;rio" class="input-form" name="username" v-model="user.username"/>
            </div>
            <div class="input-box">
              <input type="password" placeholder="Senha" class="input-form" name="password" v-model="user.password"/>
            </div>
            <div class="input-box">
              <input type="password" placeholder="Confirme a senha" class="input-form" v-model="user.confPassword"/>
            </div>
            <div class="input-box">
              <label for="gender">G&ecirc;nero:</label>
              <select id="gender" v-model="user.gender" required>
                <option value="Masculino" selected>Masculino</option>
                <option value="Feminino">Feminino</option>
              </select>
            </div>
            <div class="input-box">
              <label for="type">Tipo de usu&aacute;rio:</label>
              <select id="type" v-model="user.type" required>
                <option value="Individual" selected>Individual</option>
                <option value="Group">Organiza&ccedil;&atilde;o</option>
              </select>
            </div>
            <div class="input-box">
              <input type="text" placeholder="Telefone" class="input-form" name="contact_phone" v-model="user.contact_phone"/>
            </div>    
            <div class="input-box">
              <label for="district">Distrito de resid&ecirc;ncia:</label>
              <select id="district_id" v-model="user.district_id" required>
                <option value="1" selected>Maputo Cidade</option>
                <option value="2">Matola</option>
                <option value="3">Manhiça</option>
                <option value="4">Chibuto</option>
                <option value="5">Chókwè</option>
              </select>
            </div>
            <div class="input-box">
              <input type="text" placeholder="Endere&ccedil;o/Morada" class="input-form" name="contact_address" v-model="user.contact_address"/>
            </div>
            <div class="signup-box">
              <button type="submit" class="button">Criar</button>
            </div>
            <div class="signin-box">
              <p>Caso tenha uma conta e queira Entrar</p>
              <RouterLink to="/auth/signin" class="signin-link">Por favor, use este link</RouterLink>
            </div>
          </form>
          
        </div>
      </div>
      <div class="info-box">
        <div class="overlay-text">
          <p style="font-size: 1.5rem;">Crie uma conta para reportar algu&eacute;m desaparecido ou enviar coment&aacute;rios no registo de uma pessoa desaparecida.</p><br/>
          <p style="font-size: 1.5rem;">N&atilde;o precisa de uma conta para procurar por pessoas desaparecidas.</p>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import axios from 'axios'
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const error = ref()
const router = useRouter()

const user = ref({
  full_name: null,
  email: null,
  username: null,
  password: null,
  confPassword: null,
  gender: null,
  type: null,
  contact_phone: null,
  district_id: null,
  contact_address: null
})

function resetForm() {
      user.value = {
        full_name: null,
        email: null,
        username: null,
        password: null,
        confPassword: null,
        gender: null,
        type: null,
        contact_phone: null,
        district_id: null,
        contact_address: null
      };
    }
    
const submitForm = () => {
      
  signUp(user);
  resetForm();
}

const signUp = () => {
  try {

    const formData = new FormData();

    formData.append('full_name', user.value.full_name);
    formData.append('email', user.value.email);
    formData.append('username', user.value.username);
    formData.append('password', user.value.password);
    formData.append('confPassword', user.value.confPassword);
    formData.append('gender', user.value.gender);
    formData.append('type', user.value.type);
    formData.append('contact_phone', user.value.contact_phone);
    formData.append('district_id', parseInt(user.value.district_id));
    formData.append('contact_address', user.value.contact_address);

    axios
      .post('/users', user.value, {
        headers: { 'Content-Type': 'application/json' }
      })
      .then((res) => {
        
        alert("Usuário registado com sucesso!");
        router.push({ name: 'signin' })
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

.general-info {
  padding: 7rem 7% 1.4rem;
}

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
section .content-box {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  width: 50%;
  height: 100%;
  background-color: #ffffff;
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
section .content-box .form-box .signup-box button {
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
section .content-box .form-box .signup-box button:hover {
  background-color: var(--hover);
}
section .content-box .form-box .signin-box {
  text-align: center;
}
section .content-box .form-box .signin-box .signin-link {
  color: var(--primary);
  font-weight: 600;
}
section .content-box .form-box .signin-box .signin-link:hover {
  color: var(--hover);
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
section .info-box .landing-route {
  position: absolute;
  color: #fff;
  left: 2%;
  bottom: 1%;
}
section .info-box .landing-route:hover {
  color: var(--hover);
}
section .info-box .overlay-text {
  position: absolute;
  text-align: center;
  top: 25%;
  left: 10%;
  color: #483c3c;
}

@media (max-width: 768px) {
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
  section .content-box .form-box .signin-box {
    font-size: 1.3rem;
  }

  section .info-box {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }
  section .info-box .overlay-text,
  section .info-box .landing-route {
    display: none;
  }
}
</style>
