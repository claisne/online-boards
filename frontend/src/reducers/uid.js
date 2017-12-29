
import createReducer from '../utils/create-reducer';

const SET = 'UID/SET';

const initialState = null;

export default createReducer(initialState, {
  [SET](state, action) {
    return action.uid;
  },
});

export function set(uid) {
  return { type: SET, uid };
}
