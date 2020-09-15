<template>
  <div id="schedule-tabs">
    <span :class="tabClass(index)" @click="currentTab=index" v-for="tab, index in tabs">
      {{tab}}
    </span>
  </div>
</template>

<script>
  export default {
    name: "ScheduleTabs",
    data() {
      return {
        currentTab: 0,
        tabs: ["Сегодня", "Завтра", "Неделя", "Месяц"],
      }
    },

    methods: {
      tabClass(index) {
        if (this.currentTab === index) return "active tab"
        return "tab"
      }
    }
  }
</script>

<style scoped>


</style>