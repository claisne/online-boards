import React from 'react';

import { LOADING } from '../../api';
import loading from '../../img/loading.svg';

const SubmitButton = ({ request, text, loadingText }) => (
  <button
    type="submit"
  >
    {request === LOADING ? <img alt="Loading" src={loading} /> : null}
    {request === LOADING ? loadingText : text}
  </button>
);

export default SubmitButton;
