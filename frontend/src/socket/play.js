import { send } from './index';

export default function (gameType) {
  send({ type: 'PLAY', payload: gameType });
}
