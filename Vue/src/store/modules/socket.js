const state = {
  msgData: [],
};

const getters = {};

const actions = {};

const mutations = {
  pushMsgData: ($state, $payload) => {
    $state.msgData.push($payload);
  },
};

export default {
  state,
  getters,
  actions,
  mutations,
};
