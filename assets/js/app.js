import Vue from 'vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import App from './App';

Vue.use(Vuetify);

// new Vue({
//     template: '<App/>',
//     components: { App }
// }).$mount('#app');


new Vue({
    el: '#app',
    render: h => h(App)

});