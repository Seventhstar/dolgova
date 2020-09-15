import Vue from 'vue'
import App from './components/schedule.vue'
import vSelect from "vue-select"
//import VueNoty from 'vuejs-noty'

// Vue.component("v-select", vSelect);
//Vue.use(VueNoty)

function showSchedule() {
  const app = new Vue({
    el: '#schedule_app',
    render: h => h(App)
  }).$mount()
  console.log('schedule app', app)
}

document.addEventListener('DOMContentLoaded', () => {
  showSchedule();
})

document.addEventListener('turbolinks:load', () => {
  showSchedule();
});

