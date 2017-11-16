
import React from 'react';
import defaultTo from 'lodash/defaultTo';
import capitalize from 'lodash/capitalize';

const FormInput = ({
  type = 'text',
  data,
  attr,
  onChange,
  placeholder,
}) => (
  <div className="form-group">
    <input
      type={type}
      placeholder={defaultTo(placeholder, capitalize(attr))}
      className="form-control"
      value={data[attr]}
      onChange={onChange(attr)}
    />
  </div>
);

export default FormInput;
