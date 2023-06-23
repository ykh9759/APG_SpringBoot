import Vue, { createApp } from '@vue/compat';
import BootstrapVue from 'bootstrap-vue';
import axios from 'axios';
import App from './App.vue';
import router from './router';
import store from "./store";

import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';


Vue.use(BootstrapVue);

const app = createApp(App);
app.config.globalProperties.$axios = axios; 
app.config.productionTip = false;
app.use(router)
app.use(store)
app.mount('#app');
