import { createRouter, createWebHistory } from 'vue-router';
import Login from "../views/Login.vue";
import Chat from "../views/Chat.vue";

const routes = [
  {
    path: "/",
    name: "login",
    component: Login,
  },
  {
    path: "/chat",
    name: "chat",
    component: Chat,
  },
];

const router = new createRouter({
  history: createWebHistory(),
  routes,
});

export default router;

