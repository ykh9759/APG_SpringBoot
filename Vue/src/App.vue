<template>
  <div>
    <router-link v-if="!hideLink" @click.native="handleLinkClick" to="/home" class="btn btn-primary">방생성</router-link>
    {{  hideLink}}
    <router-view></router-view>
  </div>
</template>

<script>

  export default {
    data() {
      return {
        hideLink: false
      };
    },
    methods: {
      handleLinkClick() {
        // 값을 변경합니다.
        this.hideLink = true;

        // 페이지가 이동됩니다.
      },
      resetLink() {
        this.hideLink = false;
      }
    },
    mounted() {
      window.addEventListener('popstate', this.resetLink);
    }
  };
</script>

