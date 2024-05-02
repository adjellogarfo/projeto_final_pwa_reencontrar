<template>
 
  <section class="page-title">
        <div class="row">   
          <h2 style="color: #15a04a; font-size: 2.0rem; padding: 5px;">Reportar pessoa desaparecida</h2>
      <RouterLink to="/" class="home-route"><i class="bi bi-arrow-left-circle"></i></RouterLink>
        </div>
  </section>
  <div class="report-form-container">
    
    <form @submit.prevent="submitForm" class="report-form" enctype="multipart/form-data">
      <div class="form-group">
        <label for="name">Nome da pessoa desaparecida:</label>
        <input type="text" id="name" v-model="newMissingPerson.name" required>
      </div>
      <div class="form-group">
        <label for="age">Idade:</label>
        <input type="number" id="age" v-model="newMissingPerson.age">
      </div>
      <div class="form-group">
        <label for="gender">G&ecirc;nero:</label>
        <select id="gender" v-model="newMissingPerson.gender" required>
          <option value="Masculino" selected>Masculino</option>
          <option value="Feminino">Feminino</option>
        </select>
      </div>
      <div class="form-group">
        <label for="missing_person_description">Descri&ccedil;&atilde;o da pessoa:</label>
        <textarea id="missing_person_description" v-model="newMissingPerson.missing_person_description" required></textarea>
      </div>
      <div class="form-group">
        <label for="contact_info">Informa&ccedil;&otilde;es de contacto:</label>
        <input type="text" id="contact_info" v-model="newMissingPerson.contact_info" required>
      </div>
      
      <div class="form-group">
        <label for="province">Prov&iacute;ncia da &uacute;ltima localiza&ccedil;&atilde;o:</label>
        <select id="province" v-model="newMissingPerson.province" @change="updateDistricts" required>
          <option value="">Selecione a prov&iacute;ncia</option>
          <option v-for="province in provinces" :key="province.id" :value="province.id">{{ province.province_name }}</option>
        </select>
      </div>
      <div class="form-group">
        <label for="district">Distrito da &uacute;ltima localiza&ccedil;&atilde;o:</label>
        <select id="district" v-model="newMissingPerson.district_id" required>
          <option value="">Selecione o distrito</option>
          <option v-for="district in districts" :key="district.district_id" :value="district.district_id">{{ district.district_name }}</option>
        </select>
      </div>

      <div class="form-group">
        <label for="location_description">Informa&ccedil;&otilde;es adicionais:</label>
        <textarea id="location_description" v-model="newMissingPerson.location_description"></textarea>
      </div>
      <div class="form-group">
        <label for="image">Foto:</label>
        <input type="file" id="image" accept="image/*" @change="handleImageUpload">
      </div>
      <button type="submit" class="submit-button">Reportar o desaparecimento</button>
    </form>
  </div>
</template>


<script setup>
    import { ref } from 'vue';
    import axios from 'axios'
    import { useRouter} from 'vue-router'

    const router = useRouter()

    const newMissingPerson = ref({
      name: '',
      age: null,
      gender: '',
      missing_person_description: '',
      contact_info: '',
      location_description: '',
      district_id: '',
      image: null,
    });

    const provinces = ref([
      { id: 1, province_name: 'Maputo' },
      { id: 2, province_name: 'Gaza' },
      { id: 3, province_name: 'Inhambane' },
      { id: 4, province_name: 'Sofala' },
      { id: 5, province_name: 'Manica' },
      { id: 6, province_name: 'Zambezia' },
      { id: 7, province_name: 'Tete' },
      { id: 8, province_name: 'Niassa' },
      { id: 9, province_name: 'Cabo Delgado' }
    ]);

    const districts = ref([]);

    const allDistricts = [
      { district_id: 1, district_name: 'Maputo Cidade', province_id: 1 },
      { district_id: 2, district_name: 'Matola', province_id: 1 },
      { district_id: 3, district_name: 'Manhiça', province_id: 1 },
      { district_id: 4, district_name: 'Chibuto', province_id: 2 },
      { district_id: 5, district_name: 'Chókwè', province_id: 2 },
    ];

    function handleImageUpload(event) {
      const file = event.target.files[0];
      newMissingPerson.value.image = file;
    }

    function resetForm() {
      newMissingPerson.value = {
        name: '',
        age: null,
        gender: '',
        missing_person_description: '',
        location_description: '',
        district_id: '',
        contact_info: '',
        image: null,
      };
    }

    function updateDistricts() {
      const selectedProvinceId = newMissingPerson.value.province;
      districts.value = allDistricts.filter(district => district.province_id === selectedProvinceId);
    }

    const submitForm = () => {
      
      reportMissingPerson(newMissingPerson);
      resetForm();
    }

    const reportMissingPerson = async (newMissingPerson) => {

      try {
        
        const formData = new FormData();
        formData.append('name', newMissingPerson.value.name);
        formData.append('age', parseInt(newMissingPerson.value.age));
        formData.append('gender', newMissingPerson.value.gender);
        formData.append('missing_person_description', newMissingPerson.value.missing_person_description);
        formData.append('contact_info', newMissingPerson.value.contact_info);
        formData.append('location_description', newMissingPerson.value.location_description);
        formData.append('district_id', parseInt(newMissingPerson.value.district_id));
        formData.append('image', newMissingPerson.value.image);

        const response = await axios.post('/missing-persons', formData, {
          headers: {'Content-Type': 'multipart/form-data' }
          });
        
        if (response.status === 200 && response.data && response.data.success) {
        // Request was successful and a missing person instance was created
        alert("O registo de pessoa desaparecida foi reportado com sucesso!");
        
        console.log("Registo criado com sucesso:", response.data.message);
        router.push({ path: '/missing-persons'});
        
      } else {
        // Request was successful but the missing person instance was not created
        
        alert("Erro ao criar o registo de pessoa desaparecida:  \n"+response.data.message);
        console.error("Erro ao criar o registo de pessoa desaparecida:", response.data.message);
      }

      } catch (error) {
        alert("Erro no reporte de pessoa desaparecida: \n"+error);
        console.error('Erro no reporte de pessoa desaparecida:', error);
      }
    }
    
</script>

<style scoped>

.page-title {
  padding: 7rem 7% 1.4rem;
}

.page-title h2 {
  text-align: center;
  font-size: 2.6rem;
}

.report-form-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.report-form {
  max-width: 400px;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.form-group {
  margin-bottom: 20px;
}

label {
  font-weight: bold;
}

input[type="text"],
input[type="number"],
textarea,
select {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.submit-button {
  width: 100%;
  padding: 10px;
  border: none;
  border-radius: 5px;
  background-color: #007bff;
  color: #fff;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.submit-button:hover {
  background-color: #0056b3;
}
.home-route {
  color: #53a86c;
  position: relative;
  top: 10px;
  left: 5px;
  font-size: 1.5rem;
  top: 10px;
  padding: 0px 10px;
}
.home-route:hover {
  color: rgb(33, 116, 69);
}

</style>