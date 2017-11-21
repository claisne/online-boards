import ReconnectingWebsocket from 'reconnecting-websocket';

const listeners = {};

const ws = new ReconnectingWebsocket('ws://localhost:3001');

ws.onmessage = (evt) => {
  const msg = JSON.parse(evt.data);
  if (listeners[msg.type] != null) {
    listeners[msg.type].forEach(cb => cb(msg));
  }
};

export function send(message) {
  ws.send(JSON.stringify(message));
}

export function listen(type, cb) {
  if (listeners[type] == null) {
    listeners[type] = [cb];
  } else {
    listeners[type].push(cb);
  }
}
