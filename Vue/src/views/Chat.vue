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
import Stomp from 'webstomp-client';
import SockJS from 'sockjs-client';

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

  destroyed() {
    // Stomp 클라이언트 종료 로직
    this.stompClient.disconnect();
  },

  methods: {
    ...mapMutations({
      pushMsgData: "pushMsgData",
    }),

    send(msg) {

      if (this.stompClient && this.stompClient.connected) {

        const username = this.userData.userName;
        const avatar = this.userData.userImage;

        let time = new Date();
        let hours = ('0' + time.getHours()).slice(-2); 
        let minutes = ('0' + time.getMinutes()).slice(-2);

        let timeString = hours + ':' + minutes;

        this.pushMsgData({
          from: {
            name: "CalledMe",
            avatar: avatar,
          },
          msg,
          timeString
        });

        const data = { 
          userName: username,
          content: msg 
        };
        console.log("보내는 메시지:" + msg);
        this.stompClient.send("/receive", JSON.stringify(data), {});

        setTimeout(() => {
          const element = document.getElementById("chat__body");
          element.scrollTop = element.scrollHeight;
        }, 0);
      }
    }, 
    connect() {
      const serverURL = "http://118.36.148.208:8080";
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

            let data = JSON.parse(res.body);
            let msg = data.content;

            let time = new Date();
            let hours = ('0' + time.getHours()).slice(-2); 
            let minutes = ('0' + time.getMinutes()).slice(-2);

            let timeString = hours + ':' + minutes;

            if(this.userData.userName != data.userName) {
              this.pushMsgData({
                from: {
                  name: data.userName
                },
                msg,
                timeString
              });
            }

            setTimeout(() => {
              const element = document.getElementById("chat__body");
              element.scrollTop = element.scrollHeight;
            }, 0);

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
