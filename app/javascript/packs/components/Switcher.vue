<template>
  <div class="row switch-container" @click="click()">
    <label :class="getClass(!isActive)" :style="style()">{{labels[0]}}</label>
    <div class="switcher_slot">
      <div class="switcher_controls">
        <input role="switch"
               type="checkbox" :value="isActive">
        <div :class="{'switch_track text': true, 'active': isActive}"></div>
        <div :class="{'switch_thumb text': true, 'active': isActive}"></div>
      </div>
    </div>
    <label :class="getClass(isActive)">{{labels[1]}}</label>
  </div>
</template>
<script>
  export default {
    name: 'Switcher',
    props: ['labels', 'width', 'value'],
    data: function () {
      return {
        isActive: false,
      }
    },

    created() {
      this.isActive = this.value
    },

    methods: {
      getClass(active) {
        let add = active ? '' : ' disabled'
        return `left mr-3 ml-3 ${add}`
      },

      style() {
        if (this.width !== undefined)
          return `width: ${this.width}px`
        return ''
      },

      click() {
        this.isActive = !this.isActive
        this.$emit('input', this.isActive)
      }
    }
  }
</script>
<style>

  .switcher_slot {
    cursor: pointer;
  }

  .switch-container label {
    padding: 0 !important;
  }

  .switcher_slot input {
    opacity: 0;
  }


  .switcher_slot .active {
    color: #730E15;
    background-color: #730E15;
  }


  .switcher_controls {
    width: 38px;
    color: inherit;
    display: inline-flex;
    flex: 0 0 auto;
    height: 24px;
    position: relative;
    transition: .3s cubic-bezier(.25, .8, .5, 1);
    transition-property: transform;
  }

  .switcher_slot input {
    max-height: 32px;
  }

  .switch_track {
    background-color: gray;
    border-radius: 8px;
    width: 36px;
    height: 14px;
    left: 2px;
    position: absolute;
    opacity: .6;
    right: 2px;
    top: calc(50% - 7px);
  }

  .switch_thumb {
    background-color: white;
    border-radius: 50%;
    top: calc(50% - 10px);
    margin-left: -14px;
    height: 20px;
    position: relative;
    width: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: .3s cubic-bezier(.25, .8, .5, 1);
    box-shadow: 0 2px 4px -1px rgba(0, 0, 0, .2), 0 4px 5px 0 rgba(0, 0, 0, .14), 0 1px 10px 0 rgba(0, 0, 0, .12);
  }

  .switch_thumb.active {
    transform: translate(20px);
    background-color: #730E15;
  }

</style>