import { send } from './index';

export default function (token) {
  send({ type: 'TOKEN', payload: { token } });
}
