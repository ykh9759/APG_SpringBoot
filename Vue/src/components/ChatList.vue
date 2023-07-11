<template>
  <div class="chat_body" id="chat_body">
    <chat-message
      v-for="(msg, index) in msgs"
      :key="index"
      :msg="msg"
      :prev="[index == 0 ? null : msgs[index - 1]]"
    >
    </chat-message>
  </div>
</template>

<script>
import ChatMessage from "@/components/ChatMessage.vue";

export default {
  components: {
    ChatMessage,
  },
  props: ["msgs"],
};
</script>

<style>
.chat__body {
  padding: 2rem;
  overflow: scroll;
  scroll-behavior: smooth;
}

.chat__body::-webkit-scrollbar {
  display: none;
}
</style>
