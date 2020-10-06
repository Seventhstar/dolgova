<template>
  <div class="modal" id="myModal">
    <div class="modal-content">
      <div class="modal-head">{{eventName}}</div>
      <div class="modal-body">
        <div class="grid_short_label_name">
          <span>Дата:</span>
          <div class="date-week">
            <datetime v-model="event.date" class="date" :phrases="phrases" :auto=true></datetime>

            <div class="check-container">
              <input type="checkbox" v-model="all_weeks" id="all_weeks" class="custom-checkbox">
              <label for="all_weeks">Каждую неделю</label>
            </div>
          </div>

          <span>Время c:</span>
          <div class="times">
            <datetime v-model="event.time_from" type="time" :minute-step="5" class="time" title="Начало события"
                      :phrases="phrases"></datetime>
            <span>по:</span>
            <datetime v-model="event.time_to" type="time" :minute-step="5" class="time" :phrases="phrases"></datetime>
            <span :class="'duration'+[duration===60? ' active': '']" @click="setDuration(60)">1ч</span>
            <span :class="'duration'+[duration===90? ' active': '']" @click="setDuration(90)">1.5ч</span>
          </div>
          <span>Вид события:</span>
          <v-select :options="event_names" :reduce="v=>v.value" v-model="event.event_type_id"></v-select>

          <template v-if="event.event_type_id == 2">
            <span>Клиент:</span>
            <v-select :options="users" :reduce="v=>v.value" v-model="event.linked_user_id"></v-select>
            <span>Вид консультации:</span>
            <v-select :options="meetings" :reduce="v=>v.value" v-model="event.meeting_id"></v-select>
          </template>

          <span>Комментарий:</span>
          <textarea v-model="event.comment">

          </textarea>
          <br></div>
        <div class="actions">
          <span @click="onSaveTarget()" class="btn btn-min btn-success">Сохранить</span>
          <span @click="onCancel()" class="btn btn_reset mr-2">Отменить</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

  import axios from "axios";

  export default {
    name: "EventForm",
    props: ['value'],
    // props: ['currentEvent'],
    data: function () {
      return {
        phrases: {ok: "Выбрать", cancel: "Отменить"},
        date: '',
        time_from: '',
        all_weeks: false,
        duration: 60,
        eventTemplate: {
          id: null,
          comment: '',
          date: new Date().toISOString(),
          time_from: '2020-09-29T06:00:00.000Z',
          time_to: '2020-09-29T07:00:00.000Z',
          event_type_id: 2,
          linked_user_id: 3,
          meeting_id: 1,
        },
        event: {},
        event_names: '',
        meetings: '',
        users: '',
        type_id: 1,
      }
    },

    watch: {
      value: function (newVal) {
        this.fillEventData(newVal)
      },

      'event.time_from': function (newVal) {
        this.event.time_to = new Date(new Date(newVal).getTime() + this.duration * 60000).toISOString()
      },

      'event.event_type_id': function (newVal) {
        if (newVal != 2) {
          this.event.meeting_id = null
          this.event.linked_user_id = null
        }
      }

    },

    computed: {
      eventName() {
        return this.event['id'] == null ? 'Новое событие' : 'Редактирование'
      }
    },

    mounted() {
      document.body.addEventListener('keyup', e => {
        if (e.code === "Escape") this.onCancel()
        else if (e.code === "Enter" && e.ctrlKey) this.onSaveTarget()
      })
      // console.log('mounted')
    },

    created() {
      this.token = document.querySelector("meta[name=csrf-token]").content
      let element = document.getElementById('event-data')
      if (element !== null) {
        this.users = JSON.parse(element.dataset.users)
        this.meetings = JSON.parse(element.dataset.meetings)
        this.event_names = JSON.parse(element.dataset.eventtypes)
      }
      this.fillEventData(null)
    },

    methods: {
      fillEventData(newVal) {
        let eventData = newVal === null ? this.eventTemplate : newVal
        for (let i in eventData) {
          this.$set(this.event, i, eventData[i])
        }

        this.duration = Math.abs(new Date(this.event.time_to) - new Date(this.event.time_from)) / 60000
      },

      setDuration(minutes) {
        this.duration = minutes
        this.event.time_to = new Date(new Date(this.event.time_from).getTime() + minutes * 60000).toISOString()
      },

      onCancel() {
        this.$emit('input')
      },

      showError(t, error) {
        let msg = error.response.status + ' : ' + error.response.statusText
        let err = error.response.data.errors
        if (typeof (err) === 'object')
          for (const [key, value] of Object.entries(err)) {
            msg += '<br/>' + `${key}: ${value}`
          }
        t.$noty.error(msg)
        t.$emit('input', e)
      },

      onSaveTarget() {
        const t = this
        axios.defaults.headers.common['X-CSRF-TOKEN'] = this.token

        // console.log('this.event.id', this.event.id)
        if (this.event.id !== null) {
          axios.patch(`/events`, {
            format: 'json',
            id: this.event.id,
            event: this.event
          }).then(function (response) {
            t.$emit('input', {update: true, data: response.data})
          }).catch(function (error) {
            t.showError(t, error)
          })
        } else {
          axios.post(`/events`, {
            format: 'json',
            event: this.event
          }).then(function (response) {
            t.$emit('input', {update: false, data: response.data})
          }).catch(function (error) {
            t.showError(t, error)
          })
        }
      }
    }
  }
</script>

<style scoped>

</style>