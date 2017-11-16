import * as Api from './index';

export function get(name) {
  return Api.get(`/users/${name}`);
}

export function create(data) {
  return Api.post('/users', data);
}
