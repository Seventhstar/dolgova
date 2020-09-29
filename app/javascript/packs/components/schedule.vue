<template>
  <div>
    <div class="schedule_head">
      <div class="h2">Расписание</div>
      <div class="add_task v-btn theme--dark v-size--default btn-active ripple" @click="onAdd()">Добавить</div>
    </div>
    <ScheduleTabs/>
    <EventForm v-model="currentEvent" @input="onInput($event)" v-show="showModal"/>
    <div id="event-list">
      <div class="event_row" v-for="event in events" @dblclick="editEvent(event)">
        <span :style="{'background-color': event.color}"></span>
        <div class="event-list-item">
          <span>{{formatTime(event.time_from)}}</span>
          <span>{{event.linked_user_name}}</span>
          <span>{{event.meeting_name}}</span>
          <span>баланс</span>

          <span class="second_row">{{formatTime(event.time_to)}}</span>
          <span class="second_row">{{event.linked_user_phone}}</span>
          <span class="second_row">{{event.comment}}</span>
          <span class="second_row">{{event.tarif_info}}</span>
        </div>
        <span class="event_icon">
            <template v-if="event.online">
              <span class="online"></span>
            </template>
            <template v-else>
              <span class="sofa"></span>
            </template>
          </span>
      </div>
    </div>
  </div>
</template>

<script>

  import axios from "axios"
  import ScheduleTabs from "./scheduletabs.vue";
  import EventForm from "./EventForm.vue";

  export default {
    name: "schedule",
    data() {
      return {
        id: null,
        token: '',
        target: null,
        showModal: false,
        currentEvent: {},
        sets_names: [],
        parents: [],
        groups: [],
        events: [],
        count_names: []
      }
    },

    created() {
      let element = document.getElementById('event-data')
      if (element !== null) {
        this.events = JSON.parse(element.dataset.events)
      }
    },

    methods: {
      onInput(e) {
        this.showModal = false
        if (e === undefined) return
        if (!e.update) {
          this.events.push(e.data)
        } else {
          let id = e.data.id
          let forUpdate = this.events.filter(e => e.id === id)
          if (forUpdate.length > 0) {
            let i = this.events.indexOf(forUpdate[0])
            console.log('forUpdate', forUpdate, i)
            this.$set(this.events, i, e.data)
          }

        }
        console.log('onInput', e)
      },

      onAdd() {
        this.showModal = true
        this.currentEvent = null
      },

      editEvent(event) {
        this.currentEvent = event
        this.showModal = true
      },

      formatTime(str) {
        return formatTime(str)
      }
    },

    components: {
      ScheduleTabs: ScheduleTabs,
      EventForm: EventForm,
    }

  }
</script>