<template>
  <div>
    <body>
      <section class="missing-person">
        <h2 style="color: #15a04a; font-size: 2.0rem; padding: 5px;">Pessoas desaparecidas</h2>
        <div class="user">
          <h5 style="color: #000000;">Bem-vindo {{ user }}</h5>
        </div>
        <div>
        <form @submit.prevent="searchMissingPersons">
          <input type="text" class="search-box" v-model="searchQuery" placeholder="Pesquisar...">
          <button class="search" type="submit">Pesquisar</button>
        </form>
        
        </div>
        
        <!-- List of missing persons -->
        <div v-if="missingPersonsFilter.length">
          <div class="wrapper">
            <div class="row">
              <div class="card" v-for="(p, index) in missingPersonsFilter" :key="index">
                <div class="card-img">
                    <h3>{{ p.name }}</h3>
                  <img alt="foto da pessoa" :src="getImage(p.image)"/>
                </div>
                <div class="card-content">
                  <div class="card-text">
                    <p>Idade: {{ p.age }}</p>
                    <p>G&ecirc;nero: {{ p.gender }}</p>
                    <p>&Uacute;ltima localiza&ccedil;&atilde;o: {{ p.location.district.district_name}}</p>
                  <br/>Reportado em: {{ formatDate(p.reported_at) }}
                    <!--<p>Desaparecido a: {{ p.status }}</p>-->
                  </div>
                </div>
                <RouterLink :to="{ name: 'missingpersonprofile', params: { id: p.missing_person_id } }" class="edit_comment-route"
                  >Ver / Comentar</RouterLink
                >
              </div>
            </div>
          </div>
        </div>
        <div v-else>
          <p class="data-not-found">Sem dados de pessoas desaparecidas.</p>
        </div>

      </section>
    </body>
  </div>
</template>

<script setup>
import axios from 'axios'
import { ref, computed } from 'vue'

const user = ref()
const missingPersons = ref([])
const searchQuery = ref('')


const getMissingPersons = async () => {
  try {
      const response = await axios.get('/missing-persons');
      missingPersons.value = response.data.missingpersons;

  } catch (error) {
    console.error('Erro ao procurar pessoas desaparecidas:', error);
  }
}
getMissingPersons()

const getImage = (img) => {
  return `${axios.defaults.baseURL}/uploads/images/${img}`;
}

const missingPersonsFilter = computed(() => {
  return missingPersons.value.filter((item) => {
    return item.name.toLowerCase().includes(searchQuery.value.toLowerCase())
  })
})

const formatDate = (isoDateString) => {
  const date = new Date(isoDateString);
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    return `${day}/${month}/${year}, ${hours}h:${minutes}m`;
  }

</script>

<style scoped>
div:first-child {
  --primary: #53a86c;
  --hover: #327747;
  --edit: #2f54cc;
  --editHover: #1c3da7;
  --delete: rgb(160, 20, 20);
  --delHover: rgb(124, 19, 19);
  --sectionBg: #f7f6f9;
}

body {
  color: #fff;
}

.missing-person {
  padding: 7rem 7% 1.4rem;
}
.missing-person .user {
  margin: 1.5rem 0 0 10.5rem;
  font-size: 1.3rem;
}
.missing-person .home-route {
  color: #fff;
  position: fixed;
  top: 1%;
  left: 1%;
}
.missing-person .home-route:hover {
  color: var(--hover);
}
.missing-person h2 {
  text-align: center;
  font-size: 2.6rem;
}
.missing-person h2 span {
  color: var(--primary);
}
.missing-person .search-box {
  display: block;
  width: 440px;
  margin: 1.4rem 0.3em 0.3em 10.5em;
  padding: 10px 45px;
  background: white url('../assets/img/search-icon.png') no-repeat 15px center;
  background-size: 15px 15px;
  font-size: 16px;
  border: none;
  border-radius: 5px;
  box-shadow:
    rgba(50, 50, 93, 0.25) 0px 2px 5px -1px,
    rgba(0, 0, 0, 0.3) 0px 1px 3px -1px;
}
.missing-person .search {
  margin: 1rem 0.3em 0em 13em;
  display: inline-block;
  padding: 1rem 3rem;
  font-size: 0.8rem;
  font-weight: 500;
  color: #fff;
  background-color: #53a86c;
  border-radius: 0.5rem;
  box-shadow: 1px 1px 3px rgba(1, 1, 3, 0.5);
}
.missing-person .wrapper {
  padding: 3rem 7% 1.4rem;
}
.missing-person .wrapper .row {
  display: flex;
  flex-wrap: wrap;
  width: 100%;
  height: 70%;
  gap: 40px;
  justify-content: center;
}
.missing-person .wrapper .row .card {
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 10px 10px 15px;
  border-radius: 10px;
  transition: 0.3s;
  width: fit-content;
  width: -moz-fit-content;
  height: 100%;
  background-color: var(--sectionBg);
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
  color: black;
}
.missing-person .wrapper .row .card:hover {
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
}
.missing-person .wrapper .row .card .card-img {
  display: grid;
  place-items: center;
  width: 100%;
  height: 60%;
}
.missing-person .wrapper .row .card .card-img img {
  width: 240px;
}
.missing-person .wrapper .row .card .card-img h3 {
  margin-bottom: 0.5rem;
}
.missing-person .wrapper .row .card .card-content .card-text {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: 1rem;
  width: 100%;
}
.missing-person .wrapper .row .card .card-content .card-desc p {
  margin-top: 0.5rem;
  font-size: 1em;
  line-height: 25px;
}
.missing-person .wrapper .row .card .edit_comment-route {
  display: inline-block;    
  padding: 0.4em 0.4em;
  margin: 0.3em 3em 0.3em 3em;
  border-radius: 0.15em;
  box-sizing: border-box;
  text-decoration: none;
  font-weight: 400;
  background-color: var(--edit);
  color: #fff;
  border-radius: 0.5rem;
  box-shadow: 1px 1px 3px rgba(1, 1, 3, 0.5);
  text-align: center;
  position: relative;
}
.missing-person .wrapper .row .card .edit_comment-route:hover {
  background-color: var(--editHover);
}
.missing-person .wrapper .row .card .delete {
  display: inline-block;
  padding: 0.7em 1.4em;
  margin: 0.3em 3em 0.3em 3em;
  border-radius: 0.15em;
  box-sizing: border-box;
  text-decoration: none;
  font-weight: 400;
  background-color: var(--delete);
  color: #fff;
  border-radius: 0.5rem;
  box-shadow: 1px 1px 3px rgba(1, 1, 3, 0.5);
  text-align: center;
  position: relative;
}
.missing-person .wrapper .row .card .delete:hover {
  background-color: var(--delHover);
}
.missing-person .data-not-found {
  margin: 3rem 0.3em 0.3em 10.5em;
  color: #000000;
  font-size: 2.5rem;
  text-decoration: underline;
}

/* Media Queries */
@media (max-width: 768px) {
  .missing-person .home-route {
    top: 1%;
  }
  .missing-person h2 {
    margin: 0;
  }
  .missing-person .user {
    margin: 3rem 0 0 1.5rem;
    font-size: 1.3rem;
  }
  .missing-person .search-box {
    margin: 1.5rem 0.3em 0.3em 1.5em;
    width: 300px;
    font-size: 10px;
  }
  .missing-person .search {
    margin: 1.5rem 0.3em 0.3em 1.5em;
    font-size: 1rem;
  }
  .missing-person .data-not-found {
    margin: 7rem 0.3em 0.3em 4em;
  }
  .missing-person .row .card .card-content .card-text h3,
  .missing-person .row .card .card-content .card-text p {
    font-size: 1.7em;
  }
  .missing-person .row .card .card-content .card-desc p {
    font-size: 1.3em;
  }
}

/* Laptop */
@media screen and (min-device-width: 1200px) and (max-device-width: 1600px) and (-webkit-min-device-pixel-ratio: 1) {
  .missing-person .user {
    margin: 3rem 0 0 9rem;
  }
  .missing-person .search-box {
    margin: 1rem 0.3em 0.3em 9em;
  }
  .missing-person .search {
    margin: 1rem 0.3em -2em 11em;
  }
  .missing-person .data-not-found {
    margin: 7rem 0.3em 0.3em 15em;
    font-size: 2rem;
  }
}

/* Mobile Phone */
@media only screen and (min-device-width: 320px) and (max-device-width: 480px) and (-webkit-min-device-pixel-ratio: 2) and (orientation: portrait) {
  .missing-person .user {
    margin: 3rem 0 0 2rem;
    font-size: 1.6rem;
  }
  .missing-person .search-box {
    margin: 1.5rem 0.3em 0.3em 1.5em;
    width: 300px;
    font-size: 10px;
  }
  .missing-person .search {
    margin: 1.5rem 0.3em 0.3em 1.5em;
    font-size: 1.2rem;
  }
  .missing-person .data-not-found {
    margin: 7rem 0.3em 0.3em 2em;
  }
}
</style>
