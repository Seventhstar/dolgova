import Vue from 'vue'
import App from './components/Schedule.vue'
import vSelect from "vue-select"
import {Datetime} from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'

import underscore from 'vue-underscore'

import VueNoty from 'vuejs-noty'
import dt from './mixins/dt-mixin.js'

Vue.use(VueNoty)
Vue.use(dt)
Vue.use(underscore)

Vue.component("v-select", vSelect);
Vue.component('datetime', Datetime);

const axios = require('axios').default;

function showSchedule() {
  let schedule = document.getElementById('schedule_app')
  if (schedule !== null) {
    const app = new Vue({
      el: '#schedule_app',
      render: h => h(App)
    }).$mount()
    // console.log('schedule app', app)
  }
}

document.addEventListener('turbolinks:load', function () {
  showSchedule();
});

document.addEventListener('DOMContentLoaded', () => {
  showSchedule();
})

setTimeout(() => {
  showSchedule()
}, 100)