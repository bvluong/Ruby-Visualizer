import Vuex from 'vuex';
import Vue from 'vue';
import axios from 'axios';

Vue.use(Vuex);

const state = {
  code: 'state code',
  count: 0
};

const mutations = {
  submitCode (state, { data }) {
    console.log(data.data);
    state.code = data + 'abcd';
  }
};

const actions = {
  submitCode: ({ commit }, code) => {
    return axios.post('/api/inputs', {
      input: code }).then( response => commit('submitCode', {data: response}) );
  }
};


export default new Vuex.Store({
  state,
  mutations,
  actions
})
