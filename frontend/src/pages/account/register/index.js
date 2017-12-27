import React from 'react';
import { connect } from 'react-redux';
import { Redirect, Link } from 'react-router-dom';
import isEmpty from 'lodash/isEmpty';

import history from '../../../utils/history';
import DefaultLayout from '../../../layouts/default';

import { LOADING } from '../../../api';
import { create } from '../../../api/users';

import FormInput from '../../../components/form-input';
import Button from '../../../components/button';

import { set } from '../../../reducers/user';

import '../index.css';
import { addUsernameError, addPasswordError } from '../errors';

class Register extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      data: {
        username: '',
        password: '',
        email: '',
      },
      errors: {},
    };

    this.onChange = this.onChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  onChange(attribute) {
    return evt => this.setState({
      ...this.state,
      data: {
        ...this.state.data,
        [attribute]: evt.target.value,
      },
    });
  }

  onSubmit(evt) {
    evt.preventDefault();

    const { username, password } = this.state.data;

    let errors = {};
    errors = addUsernameError(errors, username);
    errors = addPasswordError(errors, password);

    this.setState({ errors });

    if (isEmpty(errors)) {
      this.register();
    }
  }

  async register() {
    this.setState({ request: LOADING });

    try {
      const { error, data } = await create(this.state.data);
      this.setState({ request: null });

      if (error) {
        if (data.type === 'postgres' && data.constraint === 'users_name_index') {
          this.setState({
            errors: {
              username: 'Username is already taken',
            },
          });
        } else {
          this.setState({
            errors: {
              server: 'Failed to create your account',
            },
          });
        }
      } else {
        this.props.onRegister(data);
        history.push('/');
      }
    } catch (e) {
      this.setState({
        errors: { server: 'Could not perform the request' },
        request: null,
      });
    }
  }

  labelError(attribute) {
    const error = this.state.errors[attribute];
    if (error != null) {
      return <div className="account-error">{error}</div>;
    }

    return null;
  }

  render() {
    const { user } = this.props;
    const { data, request } = this.state;

    if (user != null) {
      return <Redirect to="/" />;
    }

    return (
      <DefaultLayout>
        <div className="account">
          <form
            className="account-form"
            onSubmit={this.onSubmit}
          >
            <h2>Register</h2>
            <FormInput
              data={data}
              attr="username"
              onChange={this.onChange}
            />
            <FormInput
              type="password"
              data={data}
              attr="password"
              onChange={this.onChange}
            />
            <FormInput
              type="email"
              data={data}
              attr="email"
              placeholder="Email (Optional)"
              onChange={this.onChange}
            />
            <div className="form-group">
              <Button
                loading={request === LOADING}
                text="Register"
                loadingText="Registering..."
              />
            </div>
            <div className="form-group">
              {this.labelError('username')}
              {this.labelError('password')}
              {this.labelError('server')}
            </div>
            <Link to="/sign_in">Already have an account ?</Link>
          </form>
        </div>
      </DefaultLayout>
    );
  }
}

function mapStateToProps({ user }) {
  return { user };
}

function mapDispatchToProps(dispatch) {
  return {
    onRegister: user => dispatch(set(user)),
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(Register);
