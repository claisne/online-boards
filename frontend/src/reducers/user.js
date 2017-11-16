import decode from 'jwt-decode';

import createReducer from '../utils/create-reducer';

const SET = 'USER/SET';

const initialState = null;

export default createReducer(initialState, {
  [SET](state, action) {
    const tokenExpiresAt = decode(action.user.token).exp;
    return { ...action.user, tokenExpiresAt };
  },
});

export function set(user) {
  return { type: SET, user };
}
