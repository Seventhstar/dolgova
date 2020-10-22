<template>
  <div>
    <div class="write-in">
      <button class="v-btn v-btn--contained v-btn--rounded theme--dark v-size--default red ripple"
              @click="switchShow()">
        <span class="v-btn__content"></span>
        <i class="v-icon notranslate mr-2 material-icons theme--dark" aria-hidden="true">edit </i>
        Записаться
      </button>
    </div>
    <div class="v-overlay" v-show="showWriteInDialog">
      <div class="v-overlay__scrim"
           style="opacity: 0.46; background-color: rgb(33, 33, 33); border-color: rgb(33, 33, 33);"></div>
    </div>

    <transition name="slide-fade">
      <div id="write-in-modal" v-show="showWriteInDialog" :style="style()">

        <div class="ma-10 write-in-modal-content"


             height="80%"
             width="95%"
             absolute
             right
             temporary>
          <div class="write-in-header">
            <div class="write-in-header-content">
              <div class="write-in-title">Записаться на прием</div>
            </div>
          </div>

          <div class="table-wrap">
            <div class="row">
              <div class="col">
                <div class="grid_short_label_name">
                  <label for="name">ФИО:</label>
                  <input type="text" v-model="name" id="name"/>
                  <label for="phone">Номер телефона:</label>
                  <input type="text" v-model="phone" id="phone"/>
                  <label for="email">Е-mail:</label>
                  <input type="text" v-model="email" id="email"/>
                </div>
              </div>
              <div class="col"></div>
            </div>
            <div class="row">
              <div class="add_task v-btn theme--dark v-size--default btn-active ripple" @click="doWrite()">Записаться</div>
            </div>
          </div>

          <!--        <div class="d-flex flex-no-wrap justify-space-between">-->
          <!--          <v-list-item-content>-->
          <!--            <v-calendar></v-calendar>-->
          <!--          </v-list-item-content>-->

          <!--          <v-list-item-content aria-rowindex="1" class="ml-8" top>-->
          <!--            <v-list>-->
          <!--              <v-list-item-content>-->
          <!--                <v-list-item-title>Формат консультации</v-list-item-title>-->
          <!--              </v-list-item-content>-->
          <!--              <v-list-item>-->
          <!--                <v-list-item-action>-->
          <!--                  <v-switch v-model="isGroup" color="purple"></v-switch>-->
          <!--                </v-list-item-action>-->
          <!--                <v-list-item-title>Семейная</v-list-item-title>-->
          <!--              </v-list-item>-->
          <!--              <v-list-item>-->
          <!--                <v-list-item-action>-->
          <!--                  <v-switch v-model="isOnline" color="purple"></v-switch>-->
          <!--                </v-list-item-action>-->
          <!--                <v-list-item-title>Онлайн</v-list-item-title>-->
          <!--              </v-list-item>-->
          <!--            </v-list>-->

          <!--          </v-list-item-content>-->
          <!--        </div>-->
        </div>

      </div>
    </transition>
  </div>
</template>

<script>
  import rorHTTP from "../mixins/rorHTTP";

  export default {
    name: 'WiteIn',
    mixins: [rorHTTP],
    data: function () {
      return {
        showWriteInDialog: false,
        isGroup: false,
        isOnline: false,
        name: '',
        phone: '',
        email: ''
      }
    },

    methods: {
      switchShow() {
        this.showWriteInDialog = !this.showWriteInDialog
      },

      style() {
        //return this.showWriteInDialog ? 'transform: translateX(0%);' : 'transform: translateX(100%);'
      },

      doWrite() {
        rorHTTP.sendToServer('users', )
      }
    }
  }
</script>
<style>
  .write-in-header {
    background-color: #b8999f;
    padding: 10px;
    border-radius: 4px 4px 0 0;
  }

  .write-in-card {
    border-radius: 5px
  }

  .write-in-title {
    text-align: center;
    align-items: center;
    color: white;
    font-size: 24px;
    font-family: roboto;
  }

</style>