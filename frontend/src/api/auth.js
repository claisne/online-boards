import * as Api from './index';

export default function (data) {
  return Api.post('/auth', data);
}
