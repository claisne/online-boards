
export const LOADING = 'LOADING';

function api(path, method, body) {
  return fetch(path, {
    method,
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(body),
  })
    .then(resp => resp.json().then(data => ({
      data,
      error: !resp.ok,
    })));
}

export function get(path, data) {
  return api(path, 'POST', data);
}

export function post(path, data) {
  return api(path, 'POST', data);
}
