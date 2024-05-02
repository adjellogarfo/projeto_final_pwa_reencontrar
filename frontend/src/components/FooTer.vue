<template>
  <div>
    <footer>
      <div class="social">
        <p>
          Created By
          Adjello Garfo.
        </p>
      </div>
    </footer>
  </div>
</template>

<style scoped>
footer {
  position: fixed;
  text-align: center;
}

footer .social {
  padding: 21rem 0;
}
footer .social p {
  color: #000000;
  margin: -5rem 0 0 50rem;
  font-weight: 500;
}
footer .social a {
  color: #000000;
}

/* Responsive */
@media (max-width: 768px) {
  footer .social p {
    margin: -5rem 0 0 21rem;
  }
}

/* Mobile Phone */
@media only screen and (min-device-width: 320px) and (max-device-width: 480px) and (-webkit-min-device-pixel-ratio: 2) and (orientation: portrait) {
  footer .social p {
    margin: -5rem 0 0 15rem;
  }
}
</style>
