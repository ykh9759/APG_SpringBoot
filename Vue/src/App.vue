<template>
  <div class="h-100">
    <div class="col-12">
      <router-link v-if="createLink" to="/home" v-slot="{ navigate }">
        <button class="btn btn-primary" @click="handleLinkClick('1'); navigate()">방생성</button>
      </router-link>

      <router-link v-if="homeLink" to="/"  v-slot="{ navigate }">
        <button class="btn btn-primary" @click="handleLinkClick('2'); navigate()">HOME</button>
      </router-link>
    </div>
    {{ createLink }}{{ homeLink }}
    
    <router-view></router-view>
  </div>
</template>

<script>

  export default {
    data() {
      return {
        createLink: true,
        homeLink: false
      };
    },
    methods: {
      handleLinkClick(type) {
        if(type == '1') {
          this.$axios.get('http://localhost:8080/front/createChatRoom')
            .then(response => {
              console.log(response);
              this.createLink = false;
              this.homeLink = true;
            })
            .catch(error => {
              console.error(error);
            });

        } else if(type == '2') {
          this.createLink = true;
          this.homeLink = false;
        }

        // 페이지가 이동됩니다.
      },
      resetLink() {
        this.createLink = true;
        this.homeLink = false;
      }
    },
    mounted() {
      window.addEventListener('popstate', this.resetLink);
    }
  };
</script>

