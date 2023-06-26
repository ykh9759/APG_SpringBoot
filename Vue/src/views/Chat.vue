<template>
  <div class="chat">
    <div class="chat__header">
      <span class="chat__header__greetings">
        안녕하세요. {{ userData.userName }}님!
      </span>
    </div>
    <chat-list :msgs="msgData"></chat-list>
    <chat-form @submitMessage="send"></chat-form>
  </div>
</template>

<script>
import { mapMutations, mapState } from "vuex";
import ChatList from "@/components/ChatList.vue";
import ChatForm from "@/components/ChatForm.vue";
import Constant from "@/Constant";
import Stomp from 'webstomp-client'
import SockJS from 'sockjs-client'

export default {
  data() {
    return {
      userData: null,
    };
  },
  components: {
    ChatList,
    ChatForm,
  },
  computed: {
    ...mapState({
      msgData: (state) => state.socket.msgData,
    }),
  },
  created() {
    const storedData = localStorage.getItem('user');
    this.userData = JSON.parse(storedData);
    this.connect();
  },

  // mounted() {
  //   this.$socket.on("chat", (data) => {
  //     this.pushMsgData(data);

  //     setTimeout(() => {
  //       const element = document.getElementById("chat__body");
  //       element.scrollTop = element.scrollHeight;
  //     }, 0);
  //   });
  // },

  methods: {
    ...mapMutations({
      pushMsgData: Constant.PUSH_MSG_DATA,
    }),

    sendMessage(msg) {
      const username = this.userData.userName;
      const avatar = this.userData.userImage;

      this.pushMsgData({
        from: {
          name: "DevplaCalledMe",
          avatar: avatar,
        },
        msg,
      });

      this.$sendMessage({
        name: username,
        msg,
        avatar: avatar,
      });

      setTimeout(() => {
        const element = document.getElementById("chat__body");
        element.scrollTop = element.scrollHeight;
      }, 0);
    },
    send(msg) {

      console.log("Send message:" + msg);
      if (this.stompClient && this.stompClient.connected) {

        const data = { 
          userName: this.userData.userName,
          content: msg 
        };

        this.stompClient.send("/receive", JSON.stringify(data), {});
      }
    }, 
    connect() {
      const serverURL = "http://localhost:8080"
      let socket = new SockJS(serverURL);
      this.stompClient = Stomp.over(socket);
      console.log(`소켓 연결을 시도합니다. 서버 주소: ${serverURL}`)
      this.stompClient.connect(
        {},
        frame => {
          // 소켓 연결 성공
          this.connected = true;
          console.log('소켓 연결 성공', frame);
          // 서버의 메시지 전송 endpoint를 구독합니다.
          // 이런형태를 pub sub 구조라고 합니다.
          this.stompClient.subscribe("/send", res => {
            console.log('구독으로 받은 메시지 입니다.', res.body);

            // 받은 데이터를 json으로 파싱하고 리스트에 넣어줍니다.
            this.recvList.push(JSON.parse(res.body))
          });
        },
        error => {
          // 소켓 연결 실패
          console.log('소켓 연결 실패', error);
          this.connected = false;
        }
      );        
    }
  },
};
</script>

<style scoped>
.chat {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.chat__header {
  background: #ffffff;
  box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.05);
  border-radius: 24px 24px 0px 0px;
  padding: 1.8rem;
  font-size: 16px;
  font-weight: 700;
}

.chat__header__greetings {
  color: #292929;
}
</style>
