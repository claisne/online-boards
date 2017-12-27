import React from 'react';

import loadingImg from '../../img/loading.svg';

const SubmitButton = ({
  type = 'submit',
  loading,
  text,
  loadingText,
}) => (
  <button
    type={type}
  >
    {loading ? <img alt="Loading" src={loadingImg} /> : null}
    {loading ? loadingText : text}
  </button>
);

export default SubmitButton;
