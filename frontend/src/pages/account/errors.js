
export function addUsernameError(errors, username) {
  if (username.length < 3) {
    return {
      ...errors,
      username: 'Username minimum length is 3 characters',
    };
  }

  if (username.length > 20) {
    return {
      ...errors,
      username: 'Username maximum length is 20 characters',
    };
  }

  return errors;
}

export function addPasswordError(errors, password) {
  if (password.length < 4) {
    return {
      ...errors,
      password: 'Password minimum length is 4 characters',
    };
  }

  return errors;
}
