<template>
  <div>
    <div class="schedule_head">
      <div class="h2">Расписание</div>
      <div class="add_task v-btn theme--dark v-size--default red ripple" @click="showModal=true">Добавить</div>
    </div>
    <ScheduleTabs/>
    <EventForm v-model="showModal" @input="onInput($event)"/>
    <div id="event-list">
      <div v-for="event in events" class="event-list-item">
        <span :style="{'background-color': event.color}"></span>
        <span>{{event.time_from}}</span>
        <span>{{event.linked_user_name}}</span>
        <span>{{event.event_type_name}}</span>
        <template v-if="event.online">
          <span class="online"></span>
        </template>
        <template v-else>
          <span class="sofa"></span>
        </template>
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
        sets_names: [],
        parents: [],
        groups: [],
        events: [{
          date: '2020.09.20',
          time_from: '10:00',
          event_type_name: 'Индивидуальная консультация',
          online: true,
          linked_user_name: 'Татьяна',
          color: 'ef608c',
          icon: 'online'
        },
          {
            date: '2020.09.20',
            time_from: '11:15',
            event_type_name: 'Индивидуальная консультация',
            online: true,
            linked_user_name: 'Николай',
            color: 'ef608c',
            icon: 'online'
          },
          {
            date: '2020.09.20',
            time_from: '14:00',
            event_type_name: 'Семейная консультация',
            online: false,
            linked_user_name: 'Саша + Маша',
            color: '2dcd87',
            icon: 'sofa'
          },
        ],
        count_names: []
      }
    },

    methods: {
      onInput(e) {
        this.showModal = false
        console.log(e)

      }
    },

    components: {
      ScheduleTabs: ScheduleTabs,
      EventForm: EventForm,
    }

  }
</script>