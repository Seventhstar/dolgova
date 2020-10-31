<template>
  <div class="event-list">
    <div :class="'event-row'+[type==='week' ? '-week': '']"
         :style="{ 'background-color': event.color }"
         v-for="event in events" @dblclick="editEvent(event)">
      <div class="event-list-item">
        <span>{{formatTime(event.time_from)}}</span>
        <span :style="{ 'background-color': '#'+event.color }" class="color-column" v-if="type===undefined"></span>
        <span>{{name(event)}}</span>
        <span v-if="type===undefined">{{event.meeting_name}}</span>
        <span v-if="type===undefined">баланс</span>
        <event-icon :event="event" :show="type!==undefined"></event-icon>

        <span class="second_row">{{formatTime(event.time_to)}}</span>
        <span :style="{ 'background-color': '#'+event.color }" class="color-column" v-if="type===undefined"></span>
        <span class="second_row">{{event.linked_user_phone}}</span>
        <span class="second_row" v-if="type===undefined">{{event.comment}}</span>
        <span class="second_row" v-if="type===undefined">{{event.tarif_info}}</span>
      </div>
      <event-icon :event="event" :show="type===undefined"></event-icon>
    </div>
  </div>
</template>

<script>
  import EventForm from "./EventForm.vue";
  import EventIcon from "./EventIcon.vue";


  export default {
    name: "DayEventsList",
    props: ["events", "type"],
    data() {
      return {
        id: null,
        currentEvent: 0,
        showModal: false,
        // events: [],
      }
    },

    created() {
      // console.log('this.$dt', this)
      // console.log('events inside day', this.events)
    },

    methods: {
      name(event) {
        switch (event.event_type_id) {
          case 1:
            // TODO: переделать на текст из настроек
            return 'Свободное время'
          case 4:
          case 2:
            return event.linked_user_name
        }

        return event.comment
      },

      editEvent(event) {
        this.currentEvent = event
        this.showModal = true
        this.$emit('showModal', {showModal: true, currentEvent: event})
      },

      formatTime(str) {
        return this.$dt.formatTime(str)
      },
    },

    components:
        {EventForm, EventIcon}
  }
</script>

<style scoped>

</style>