<template>
    <div class="container">
        <h2 style="color: #15a04a; font-size: 2.0rem; padding: 5px;">Perfil de pessoa desaparecida</h2>

        <RouterLink to="/missing-persons" class="missing-person-route"><i class="bi bi-arrow-left-circle"></i></RouterLink>
        
        <div class="missing-person-details">
          <h3>{{ missingPerson.name }}</h3>
            <div class="missing-person-image">
              <img :src="getImage(missingPerson.image)" alt="" class="person-image" />
            </div>
        </div>
        <div class="details-grid">
          <div>
            <p><span>Idade:</span> {{ missingPerson.age }}</p>
          </div>
          <div>
            <p><span>G&ecirc;nero:</span> {{ missingPerson.gender}}</p>
          </div>
          <div>
            <p><span>Informa&ccedil;&otilde;es de contacto:</span> {{ missingPerson.contact_info}}</p>
          </div>
          
        </div>
        
        <div class="details-row">
          <div>
            <p v-if="missingPerson.location"><span>&Uacute;ltima localiza&ccedil;&atilde;o (Prov&iacute;ncia, distrito):</span> 
              {{ missingPerson.location.district.province.province_name}}, {{ missingPerson.location.district.district_name}}</p><br/>
          </div>
          <div>
            <p v-if="missingPerson.location"><span>Informa&ccedil;&otilde;es adicionais de localiza&ccedil;&atilde;o:</span> 
              {{ missingPerson.location.description }}</p><br/>
          </div>
          <div>
            <p><span>Descri&ccedil;&atilde;o da pessoa:</span></p>{{ missingPerson.description}}
          </div>
          <div>
            <br/><p v-if="missingPerson.user"><span>Reportado por:</span> <br/>{{ missingPerson.user.full_name}} a {{ missingPerson.reported_at}}</p><br/>
          </div>
          <div>
            <p><span>Estado:</span> {{ missingPerson.status}}</p><br/>
          </div>
        </div>
        <!-- Comments Section -->
        <div class="comments-section">
          <h4>Coment&aacute;rios</h4><br/>
        <div v-if="missingPerson.comment?.length > 0">
          <ul>
            <li v-for="comment in missingPerson.comment" :key="comment.comment_id">
              <p><strong>{{ comment.user.full_name }}:</strong> {{ comment.comment }}</p>
              <p><em>{{ comment.timestamp }}</em></p>
            </li>
          </ul>
        </div>
        <div v-else>
          <p>N&atilde;o h&aacute; coment&aacute;rios dispon&iacute;veis.</p>
        </div>
      </div>
        <!-- Form for adding new comments -->
        <div class="comment-form">
          <div>
            <p><span>Novo coment&aacute;rio</span></p>
            
          <form @submit.prevent="submitForm">
            <textarea v-model="newComment" placeholder="Contribuir, adicionando quaisquer coment&aacute;rios sobre a pessoa desaparecida" rows="6" cols="100" required></textarea>
            <button class="btn" type="submit">Adicionar coment&aacute;rio</button>
      
          </form>
          </div>
        </div>
        
    </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRoute, useRouter} from 'vue-router'
import axios from 'axios'
import { useStore } from 'vuex'

const route = useRoute()
const router = useRouter()
const store = useStore()

const isLoggedIn = store.state.authenticated;

const missingPerson = ref({})
const newComment = ref('');

const missing_person_id = route.params.id

const getMissingPersonById = async (id) => {
  try {
      const response = await axios.get(`/missing-persons/${id}`);
      missingPerson.value = response.data.missingperson;
      
  } catch (error) {
    console.error('Erro ao procurar pessoa desaparecida:', error);
  }
}

getMissingPersonById(missing_person_id)

const getImage = (img) => {
  
  return `${axios.defaults.baseURL}/uploads/images/${img}`;
}

const submitForm = () => {
    if(isLoggedIn){ 
      postComment(missing_person_id, newComment.value);
    }else{
      alert("Inicie sessão para enviar comentários");
    }
    
}

const postComment = async (id, comment) => {

    try {
      
      const data = {
        comment: comment
      };

      const response = await axios.put(`/missing-persons/${id}`, data);
      
      if (response.status === 200 && response.data && response.data.success) {
      // Request was successful and data was updated

      //router.push({ path: `/missing-persons/person/${id}`});
        alert("O comentário foi enviado com sucesso!");
      router.push({ path: '/missing-persons'});
      console.log("Dados atualizados com sucesso:", response.data.message);
      
    } else if(response.status === 401) {
      // Request was successful but data was not updated
        alert("Precisa iniciar sessão para enviar comentários");
      console.error("Erro na atualizacao de dados:", response.data.message);
    } else {
      // Request was successful but data was not updated
        alert("Erro no envio do comentário:  \n"+response.data.message);
      console.error("Erro na atualizacao de dados:", response.data.message);
    }

  } catch (error) {
    alert("Erro ao adicionar comentario:  \n"+error);
    console.error('Erro ao adicionar comentario:', error);
  }
}

</script>

<style scoped>
div:first-child {
  --fontColor: #010101;
  --primary: #53a86c;
}

.missing-person-route {
  color: #53a86c;
  position: relative;
  top: 10px;
  left: 5px;
  font-size: 1.5rem;
  top: 10px;
  padding: 0px 10px;
}
.missing-person-route:hover {
  color: rgb(33, 116, 69);
}

button {
  border: none;
  padding: 10px 20px;
  background: #32a755;
  color: #ffffff;
  border-radius: 3px;
}

button:disabled {
  background: #37ac5a88;
}

.missing-person-details {
  margin-bottom: 10px;
}

.missing-person-image img {
  max-width: 100%;
  height: auto;
}

.details-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 10px;
}

.comments-section {
  margin-bottom: 20px;
  border-bottom: 1px solid #ccc;
  border-top: 1px solid #ccc;
}

.comment-form textarea {
  width: 100%;
  margin-bottom: 10px;
}

/* Media Queries  */

/* Laptop */
@media screen and (min-device-width: 1200px) and (max-device-width: 1600px) and (-webkit-min-device-pixel-ratio: 1) {
  img {
    width: auto;
    height: 95px;
  }
}

.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.container {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 20px;
}

.h2 {
  margin-bottom: 10px;
}

.p {
  margin: 5px 0;
}

.details-row p span{
    font-weight: 600;
  }

.image {
  max-width: 200px;
  border-radius: 8px;
  margin-bottom: 10px;
  display: grid;
  place-items: center;
  width: fit-content;
  height: 60%;
}
.row_center {
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.row p {
  margin-top: 0.5rem;
}

.row textarea {
  margin-top: 0.5rem;
}

.row span {
  font-weight: 600;
}

</style>