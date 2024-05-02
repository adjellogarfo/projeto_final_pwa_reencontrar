<template>
  <div>
      <section class="general-info">
        <div class="row">   
        <h2 style="color: #15a04a; font-size: 2.0rem; padding: 5px;">Bem-vindo ao <span style="color:#4285f4">ReEncontrar!</span></h2>
        </div>
      </section>
      <div class="main">
      <div class="row">   
        <div class="action-outer start">
            <div class="action-inner">
              <RouterLink to="/missing-persons" class="search-person">Procuro alguém</RouterLink>
            </div>
        </div>
        <div class="action-outer end">
          <div class="action-inner">
            <RouterLink to="/missing-persons/add" class="report-person">Quero reportar alguém desaparecido</RouterLink>
          </div>
        </div>
      </div>
      
      <div class="row">
        <div class="description-text">
          <p>ReEncontrar! é uma plataforma compassiva dedicada a reunir entes queridos que foram separados por crises como cheias, guerras e outras emergências.</p>
          <p>Quer esteja à procura de uma pessoa desaparecida ou tenha informações que possam ajudar a trazer alguém de volta a casa, o ReEncontrar! oferece um espaço para se conectar e colaborar.</p>
      </div> 
      </div>     
    </div>
  </div>
</template>

<script setup>


</script>

<style scoped>

.main {
    font-size: 16px;
    width: 100%;
}

.main .row {
    margin: 24px;
    text-align: center;
}

.main .action-outer.start {
    background: #4285f4;
}

.main .action-outer.end {
    background: #15a04a;
}

.main .action-outer {
    display: inline-block;
    margin: 10px;    
    border: none;
    font-size: 18px;
    margin-bottom: 1em;
    max-width: 240px;
    min-height: 70px;
    padding: 16px;
    width: 100%;
    border-radius: 3px;
    box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.26);
}

.main .action-inner {
    width: 240px;
    height: 70px;
    display: table-cell;
    vertical-align: middle;
    text-align: center;
}
.search-person, .report-person {
  color: #ffffff;
}

.description-text {
  display: table;
  margin: 24px auto;
  font-size: 16px;  
  text-align: center;
  max-width: 800px;
  color: #483c3c;
}

.description-text p{
  display: block;
  margin-block-start: 1em;
  margin-block-end: 1em;
  margin-inline-start: 0px;
  margin-inline-end: 0px;

}

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

.main .row {
    margin: 24px;
    text-align: center;
}


.general-info {
  padding: 7rem 7% 1.4rem;
}
.general-info .user {
  margin: 1.5rem 0 0 10.5rem;
  font-size: 1.3rem;
}
.general-info .home-route {
  color: #fff;
  position: fixed;
  top: 1%;
  left: 1%;
}
.general-info .home-route:hover {
  color: var(--hover);
}
.general-info h2 {
  text-align: center;
  font-size: 2.6rem;
}
.general-info h2 span {
  color: var(--primary);
}
.general-info .search-box {
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

.general-info .wrapper {
  padding: 7rem 7% 1.4rem;
}
.general-info .wrapper .row {
  display: flex;
  flex-wrap: wrap;
  width: 100%;
  height: 70%;
  gap: 40px;
  justify-content: center;
}
.general-info .wrapper .row .card {
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 20px 20px 40px;
  border-radius: 10px;
  transition: 0.3s;
  width: 450px;
  height: 100%;
  background-color: var(--sectionBg);
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
  color: black;
}
.general-info .wrapper .row .card:hover {
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
}
.general-info .wrapper .row .card .card-img {
  display: grid;
  place-items: center;
  width: 100%;
  height: 60%;
}
.general-info .wrapper .row .card .card-img img {
  width: 240px;
}
.general-info .wrapper .row .card .card-content .card-text {
  display: flex;
  justify-content: space-between;
  margin-top: 1rem;
  width: 100%;
}
.general-info .wrapper .row .card .card-content .card-text p {
  font-weight: 540;
}
.general-info .wrapper .row .card .card-content .card-desc p {
  margin-top: 0.5rem;
  font-size: 1em;
  line-height: 25px;
}
.general-info .wrapper .row .card .edit-route {
  display: inline-block;
  padding: 0.7em 1.4em;
  margin: 2rem 3em 0.3em 3em;
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
.general-info .wrapper .row .card .edit-route:hover {
  background-color: var(--editHover);
}
.general-info .wrapper .row .card .delete {
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
.general-info .wrapper .row .card .delete:hover {
  background-color: var(--delHover);
}
.general-info .data-not-found {
  margin: 9rem 0.3em 0.3em 14.5em;
  color: #fff;
  font-size: 2.5rem;
  text-decoration: underline;
}

/* Media Queries */
@media (max-width: 768px) {
  .general-info .home-route {
    top: 1%;
  }
  .general-info h2 {
    margin: 0;
  }
  .general-info .user {
    margin: 3rem 0 0 1.5rem;
    font-size: 1.3rem;
  }
  .general-info .search-box {
    margin: 1.5rem 0.3em 0.3em 1.5em;
    width: 300px;
    font-size: 10px;
  }
  .general-info .data-not-found {
    margin: 7rem 0.3em 0.3em 4em;
  }
  .general-info .row .card .card-content .card-text h3,
  .general-info .row .card .card-content .card-text p {
    font-size: 1.7em;
  }
  .general-info .row .card .card-content .card-desc p {
    font-size: 1.3em;
  }
}

/* Laptop */
@media screen and (min-device-width: 1200px) and (max-device-width: 1600px) and (-webkit-min-device-pixel-ratio: 1) {
  .general-info .user {
    margin: 3rem 0 0 9rem;
  }
  .general-info .search-box {
    margin: 1rem 0.3em 0.3em 9em;
  }
  .general-info .data-not-found {
    margin: 7rem 0.3em 0.3em 15em;
    font-size: 2rem;
  }
}

/* Mobile Phone */
@media only screen and (min-device-width: 320px) and (max-device-width: 480px) and (-webkit-min-device-pixel-ratio: 2) and (orientation: portrait) {
  .general-info .user {
    margin: 3rem 0 0 2rem;
    font-size: 1.6rem;
  }
  .general-info .search-box {
    margin: 1.5rem 0.3em 0.3em 1.5em;
    width: 300px;
    font-size: 10px;
  }
  .general-info .data-not-found {
    margin: 7rem 0.3em 0.3em 2em;
  }
}
</style>