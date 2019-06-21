import vuexAlong from 'vuex-along'
var store = new Vuex.Store({
  state: {
    cardID: '', // 患者ID
    sickMessage: {}, // 患者基本信息
    woundInfoHistory: [], // 患者伤口历史
    allConstList: [], // 常量列表
    allConst: [], // 所有常量
    allWoundType: [], // 伤口类型列表
    history: [], // 伤口历史
    cardId: '', // 患者ID号1
    Num: 0, // 底部序号
    tempData: [], // 临时数据
    recordId: [], // 伤口记录ID
    infoId: []
  },
  mutations: {
    setCardID (state, msg) {
      state.cardID = msg
    },
    setCardID1 (state, msg) {
      state.cardId = msg
    },
    setSickMessage (state, msg) {
      state.sickMessage = msg
    },
    setHistory (state, msg) {
      state.woundInfoHistory = msg
    },
    setConstList (state, msg) {
      state.allConstList = msg
    },
    setWoundType (state, msg) {
      state.allWoundType = msg
    },
    historySet (state, msg) {
      state.history = msg
    },
    setNum (state, msg) {
      state.Num = msg
    },
    setTempData (state, msg) {
      state.tempData[msg.index] = msg.data
    },
    setTempData1 (state, data) {
      state.tempData = data
    },
    setRecordId (state, msg) {
      state.recordId = msg
    },
    setAllConst (state, msg) {
      state.allConst = msg
    },
    setInfoId (state, msg) {
      state.infoId = msg
    }
  },
  plugins: [vuexAlong]
})
export default store
