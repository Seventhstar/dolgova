<template>
  <div class="modal" id="myModal">
    <div class="modal-content">
      <div class="modal-head">{{eventName}}
        <span @click="deleteEvent()" class="icon icon_remove right" title="Удалить" v-show="event.id!=null"></span>
      </div>
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
          <template v-show="clientIsVisible">
            <span v-show="clientIsVisible">Клиент:</span>
            <v-select :options="users" :reduce="v=>v.value" v-model="event.linked_user_id" v-show="clientIsVisible"></v-select>
            <span v-show="clientIsVisible">Вид консультации:</span>
            <v-select :options="meetings" :reduce="v=>v.value" v-model="event.meeting_id" v-show="clientIsVisible"></v-select>
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
  import rorHTTP from "../mixins/rorHTTP.vue"

  export default {
    name: "EventForm",
    props: ['value'],
    mixins: [rorHTTP],
    // props: ['currentEvent'],
    data: function () {
      return {
        phrases: {ok: "Выбрать", cancel: "Отменить"},
        date: '',
        time_from: '',
        all_weeks: false,
        duration: 60,
        lastInserted: null,
        minutesBetween: 10,
        eventTemplate: {
          id: null,
          comment: '',
          date: new Date().toISOString(),
          time_from: '2020-09-29T06:00:00.000Z',
          time_to: '2020-09-29T07:00:00.000Z',
          event_type_id: 1
        },
        event: {event_type_id: 1},
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
        if (newVal !== undefined && newVal !== null && newVal !== '')
          this.event.time_to = new Date(new Date(newVal).getTime() + this.duration * 60000).toISOString()
      },

      'event.linked_user_id': function (oldVal, newVal) {
        console.log('newVal != 2', newVal, newVal != 2)
      },

      'event.event_type_id': function (newVal, oldVal) {
        console.log('newVal', newVal, 'oldVal', oldVal, newVal !== 2)
        if (newVal !== 2) {
          // this.event.meeting_id = null
          // this.event.linked_user_id = null
        }
      }

    },

    computed: {
      eventName() {
        return this.event['id'] == null ? 'Новое событие' : 'Редактирование'
      },

      clientIsVisible() {
        return this.event.event_type_id === 2 || this.event.event_type_id === 4
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
        this.minutesBetween = element.dataset.minutesBetween
      }

      this.fillEventData(this.eventTemplate)
    },

    methods: {
      fillEventData(newVal) {
        let eventData = newVal

        if (newVal === undefined || newVal === null) {
          eventData = this.eventTemplate
        } else if (newVal.time_from !== undefined) {
          eventData = newVal
        } else if (newVal.data !== undefined) {
          eventData = newVal.data
        } else {
          eventData = this.eventTemplate
        }

        let duration = Math.abs(new Date(eventData.time_to) - new Date(eventData.time_from)) / 60000
        if (duration < 60 || duration > 120) duration = 60

        // console.log('this.duration', duration, 'eventData.time_to', eventData.time_to, 'eventData.time_from', eventData.time_from)
        // console.log('eventData', eventData)
        let time = new Date(this.lastInserted).getTime()

        if (newVal === null) {
          if (this.lastInserted !== null) {
            eventData.time_from = new Date(time + this.minutesBetween * 60000).toISOString() //- currentTimeZoneOffsetInHours
          }
        }

        for (let i in eventData) {
          this.$set(this.event, i, eventData[i])
        }
        this.setDuration(duration)
        this.duration = duration
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
            console.log('t.event.time_from', t.event.time_from, 'response.data.time_to', response.data.time_to)
            t.lastInserted = response.data.time_to
          }).catch(function (error) {
            t.showError(t, error)
          })

        }
      },

      deleteEvent() {
        rorHTTP.deleteObject(this, 'event', this.event.id)
      }

    }
  }
</script>

<style scoped>

</style>