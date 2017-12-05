import createReducer from '../utils/create-reducer';

const SET = 'ONLINE/SET';

const initialState = null;

export default createReducer(initialState, {
  [SET](state, action) {
    return action.online;
  },
});

export function set(online) {
  return { type: SET, online };
}
