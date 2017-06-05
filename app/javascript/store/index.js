import Vuex from 'vuex';
import Vue from 'vue';

Vue.use(Vuex);

const state = {
  code: 'state code',
  count: 0
};

const mutations = {
  submitCode (state, { data }) {
    state.code = data + 'abcd';
  },
  increment (state) {
    state.count++
  }
};

const actions = {
  submitCode: ({ commit }, code) => {
    axios.post('')
    return commit('submitCode', {data: code});
  },
  increment: ({ commit }) => commit('increment')
};


export default new Vuex.Store({
  state,
  mutations,
  actions
})
