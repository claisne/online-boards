import React from 'react';
import { connect } from 'react-redux';
import { Redirect, Link } from 'react-router-dom';
import isEmpty from 'lodash/isEmpty';

import history from '../../../utils/history';
import DefaultLayout from '../../../layouts/default';

import { LOADING } from '../../../api';
import auth from '../../../api/auth';

import FormInput from '../../../components/form-input';
import Button from '../../../components/button';

import { set } from '../../../reducers/user';

import '../index.css';
import { addUsernameError, addPasswordError } from '../errors';

class SignIn extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      data: {
        username: '',
        password: '',
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
      this.login();
    }
  }

  async login() {
    this.setState({ request: LOADING });
    try {
      const { error, data } = await auth(this.state.data);
      this.setState({ request: null });

      if (error) {
        this.setState({
          errors: { server: 'Invalid username or password' },
        });
      } else {
        this.props.onSignin(data);
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
            <h2>Sign in</h2>
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
            <div className="form-group">
              <Button
                loading={request === LOADING}
                text="Sign in"
                loadingText="Signing in..."
              />
            </div>
            <div className="form-group">
              {this.labelError('username')}
              {this.labelError('password')}
              {this.labelError('server')}
            </div>
            <Link to="/register">Do not have an account yet ?</Link>
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
    onSignin: user => dispatch(set(user)),
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(SignIn);
