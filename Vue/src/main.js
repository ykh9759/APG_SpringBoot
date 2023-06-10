import './assets/main.css'

import { createApp } from '@vue/compat';
import BootstrapVue from 'bootstrap-vue';
import App from './App.vue';
import router from './router';
import axios from 'axios';

import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';

const app = createApp(App);
app.use(BootstrapVue)
app.use(router)
app.use(axios)
app.mount('#app');
