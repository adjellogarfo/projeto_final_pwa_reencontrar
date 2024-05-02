<template>
  <section class="general-info">
  <div class="dashboard-page">
    <h1 style="color: #15a04a; font-size: 2.0rem; padding: 5px;">Bem-vindo a sua Dashboard, {{ userFullName }}.</h1><br/>
    <p style="font-size: 1.2rem;">Esta p&aacute;gina &eacute; somente para utilizadores autenticados. No futuro, ser&atilde;o adicionados conte&uacute;dos e funcionalidades espec&iacute;ficos para utilizadores autenticados.</p><br/><br/>
    <router-link to="/">Voltar a P&aacute;gina Inicial</router-link>
  </div>  
</section>
</template>

<script setup>
import { computed } from 'vue';
import { useStore } from 'vuex';

const store = useStore();

const userFullName = computed(() => {
  return store.state.user ? store.state.user.full_name : '';
});

</script>

<style scoped>
.dashboard-page {
  text-align: center;
  margin-top: 50px;
}


.general-info {
  padding: 7rem 7% 1.4rem;
}
</style>
