import { createRouter, createWebHistory } from 'vue-router'
import { useStore } from 'vuex'
import MainLayout from '../layouts/MainLayout.vue'
import HomePage from '../views/Home.vue'
import MissingPersonLayout from '../layouts/MissingPersonLayout.vue'
import MissingPersonPage from '../views/MissingPersonList.vue'
import MissingPersonProfile from '../views/MissingPersonProfile.vue'
import AddMissingPerson from '../views/AddMissingPerson.vue'
import DashboardPage from '../views/DashboardPage.vue'
import Auth from '../layouts/AuTh.vue'
import Signin from '../views/auth/SignIn.vue'
import Signup from '../views/auth/SignUp.vue'

import Nav from '../components/NavBar.vue'
import Foo from '../components/FooTer.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'mainlayout',
      component: MainLayout,
      children: [
        {
          path: '',
          name: 'homepage',
          components: {
            default: HomePage,
            nav: Nav,
            foo: Foo
          }
        }
      ]
    },    
    {
      path: '/missing-persons',
      name: 'missingpersonlayout',
      component: MissingPersonLayout,
      children: [
        {
          path: '',
          name: 'missingpersons',
          components: {
            default: MissingPersonPage,
            nav: Nav,
            foo: Foo
          }
        },
        {
          path: '/missing-persons/add',
          name: 'addmissingperson',
          beforeEnter: requireAuth,
          components: {
            default: AddMissingPerson,
            nav: Nav,
            foo: Foo
          }
        },
        {
          path: '/missing-persons/person/:id',
          name: 'missingpersonprofile',
          components: {
            default: MissingPersonProfile,
            nav: Nav,
            foo: Foo
          }
        }
      ]
    },
    {
      path: '/auth',
      name: 'auth',
      component: Auth,
      children: [
        {
          path: 'signin',
          name: 'signin',
          components: {
            default: Signin,
            nav: Nav,
            foo: Foo
          }
        },
        {
          path: 'signup',
          name: 'signup',
          components: {
            default: Signup,
            nav: Nav,
            foo: Foo
          }
        }
      ]
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: MainLayout,
      beforeEnter: requireAuth,
      children: [
        {
          path: '',
          name: 'dashboardpage',
          components: {
            default: DashboardPage,
            nav: Nav,
            foo: Foo
          }
        }
      ]
    }, 
  ]
})

function requireAuth(to, from, next) {
  const store = useStore()

  const tokenExpiration = store.state.tokenExpiration

  if (!store.state.authenticated) {
    next({ name: 'signin' }) // Redirect to login page if not authenticated
  } else {
    // Check if token has expired

    const currentTime = Math.floor(Date.now() / 1000)

    if (tokenExpiration && tokenExpiration < currentTime) {
      
      store.commit('setAuthentication', false);
      store.commit('setUser', null);
      store.commit('setTokenExpiration', null);
      next({ name: 'signin' });
      
    } else {
      // Token is valid
      next() 
    }
  }

}

export default router
