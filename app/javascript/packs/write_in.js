import Vue from 'vue'
import App from './components/WriteIn.vue'
import vSelect from "vue-select"
import {Datetime} from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'

import test from './mixins/test.vue'

import VueNoty from 'vuejs-noty'

Vue.use(VueNoty)
Vue.use(test)
//Vue.use(Datetime)

Vue.component("v-select", vSelect);
Vue.component('datetime', Datetime);

const axios = require('axios').default;

function showSchedule() {
  let schedule = document.getElementById('write-in-form')
  if (schedule !== null) {
    const app = new Vue({
      el: '#write-in-form',
      render: h => h(App)
    }).$mount()
    console.log('schedule app', app)
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