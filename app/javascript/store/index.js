import Vuex from 'vuex';
import Vue from 'vue';
import axios from 'axios';

Vue.use(Vuex);

const state = {
  code: {},
  count: 0
};

const mutations = {
  submitCode (state, { data }) {
    state.code = data;
  }
};

const actions = {
  submitCode: ({ commit }, code) => {
    return axios.post('/api/inputs', {
      input: code }).then( response => commit('submitCode', response) );
  }
};


export default new Vuex.Store({
  state,
  mutations,
  actions
});
