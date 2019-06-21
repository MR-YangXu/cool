import App from './App'
import store from './store'
import router from './router'
import "@babel/polyfill"
import Icon from 'vue-svg-icon/Icon.vue'
import vuexAlong from 'vuex-along'
import API from './common/api'
Vue.use(VueAwesomeSwiper)
Vue.component('icon', Icon)
Vue.prototype.API = API
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  store,
  router,
  components: { App },
  template: '<App/>'
})
