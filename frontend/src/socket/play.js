import { send } from './index';

export default function (game) {
  send({ type: 'PLAY_CHECKERS', ...game });
}
