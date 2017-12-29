import { send } from './index';

export default function (game) {
  send({ type: 'GAME_PLAY', ...game });
}
