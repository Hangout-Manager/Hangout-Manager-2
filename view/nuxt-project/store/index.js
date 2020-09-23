import createPersistedState from 'vuex-persistedstate'
export const state = () => ({
  accessToken: '',
  client: '',
  uid: '',
  tokenType: ''
})

export const getters = {
  getAccessToken: (state) => state.accessToken,
  getClient: (state) => state.client,
  getUid: (state) => state.Uid,
  getTokenType: (state) => state.tokenType
}

export const mutations = {
  setAccessToken(state, accessToken){
      state.accessToken = accessToken;
  },
  setClient(state, client){
      state.client = client;
  },
  setUid(state, uid){
      state.uid = uid;
  },
  setTokenType(state, tokenType){
      state.tokenType = tokenType;
  },
}
