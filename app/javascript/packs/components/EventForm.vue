<template>
  <div class="modal" id="myModal" v-show="$attrs.value">
    <div class="modal-content">
      <div class="modal-head">Редактирование: "{{eventName}}"</div>
      <div class="modal-body">
        <div class="grid_short_label_name">
          <span>Дата</span>
          <div class="date-times">
            <datetime v-model="event.date" class="date" :phrases="phrases"></datetime>
            <span>c:</span>
            <datetime v-model="time_from" type="time" :minute-step="5" class="time" title="Начало события"
                      :phrases="phrases"></datetime>
            <span>по:</span>
            <datetime v-model="time_from" type="time" :minute-step="5" class="time" :phrases="phrases"></datetime>

          </div>

          <span>Вид события</span>
          <v-select :options="event_names" :reduce="v=>v.value" v-model="event.event_type_id"></v-select>

          <br></div>
        <div class="actions">
          <span @click="onSaveTarget($event.target.value)" class="btn btn-min btn-success">Сохранить</span>
          <span @click="$emit('input', $event.target.value)" class="btn btn_reset mr-2"> Отменить</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

  import axios from "axios";

  export default {
    name: "EventForm",
    // props: ['showModal'],
    data: function () {
      return {
        phrases: {ok: "Выбрать", cancel: "Отменить"},
        date: '',
        time_from: '',
        event: {
          date: new Date().toLocaleString(),
          id: null,
          event_type_id: 1,
        },
        eventName: 'eventN1231ame',
        event_names: '',
        type_id: 1,
      }
    },

    created() {
      this.token = document.querySelector("meta[name=csrf-token]").content
      let element = document.getElementById('event-data')
      if (element !== null) {
        console.log('vue created()')
        this.event_names = JSON.parse(element.dataset.eventtypes)
      }

    },

    methods: {
      onSaveTarget(target_value) {
        const t = this
        const e = target_value
        // if (this.id !== undefined) {
        axios.defaults.headers.common['X-CSRF-TOKEN'] = this.token

        // axios.patch(`/events/${this.id}`, {
        axios.post(`/events`, {
          format: 'json',
          event: this.event
        }).then(function (response) {
          console.log('response', response)
          t.$emit('input', {e: e, data: response.data, status: response.status})
        }).catch(function (error) {
          let msg = error.response.status + ' : ' + error.response.statusText
          let err =  error.response.data.errors
          if (typeof (err) === 'object')
            for (const [key, value] of Object.entries(err)) {
              msg += '<br/>' + `${key}: ${value}`
            }
          t.$noty.error(msg)
          t.$emit('input', e)
        });
      }

      //}
    }
  }
</script>

<style scoped>

</style>