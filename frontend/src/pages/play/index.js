import React from 'react';
import classNames from 'classnames';

import DefaultLayout from '../../layouts/default';

import './index.css';

import { DefaultStartingBoard } from '../../components/board';

import sendPlay from '../../socket/play';

import {
  BULLET,
  BLITZ,
  CLASSIC,
} from '../../constants/play';

const SizeButton = ({ size, disabled, onClick }) => (
  <button
    className={classNames('white', { disabled })}
    onClick={onClick}
  >
    {size}x{size}
  </button>
);

const SizeOptions = ({ size, onChangeSize }) => (
  <div className="play-options-size">
    {[8, 10, 12].map(s => (
      <SizeButton
        key={s}
        size={s}
        disabled={size !== s}
        onClick={() => onChangeSize(s)}
      />
    ))}
  </div>
);

const TypeButton = ({ type, disabled, children, onClick }) => (
  <button
    className={classNames('white', { disabled })}
    onClick={() => onClick(type)}
  >
    {children}
  </button>
);

class Play extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      size: 10,
      type: CLASSIC,
    };

    this.onChangeSize = this.onChangeSize.bind(this);
    this.onChangeType = this.onChangeType.bind(this);
    this.onFindClick = this.onFindClick.bind(this);
  }

  onChangeSize(size) {
    this.setState({ size });
  }

  onChangeType(type) {
    this.setState({ type });
  }

  onFindClick() {
    sendPlay(this.state);
  }

  render() {
    const { size, type } = this.state;

    return (
      <DefaultLayout>
        <div className="play">
          <div className="play-card">
            <DefaultStartingBoard size={size} className="play-board" />
            <div className="play-options">
              <SizeOptions
                size={size}
                onChangeSize={this.onChangeSize}
              />
              <div className="play-options-type">
                <div className="play-options-type-line">
                  <TypeButton
                    type={BULLET}
                    disabled={type !== BULLET}
                    onClick={this.onChangeType}
                  >
                    Bullet (1M)
                  </TypeButton>
                  <TypeButton
                    type={BLITZ}
                    disabled={type !== BLITZ}
                    onClick={this.onChangeType}
                  >
                    Blitz (5M)
                  </TypeButton>
                </div>
                <div className="play-options-type-line">
                  <TypeButton
                    type={CLASSIC}
                    disabled={type !== CLASSIC}
                    onClick={this.onChangeType}
                  >
                    Classic (10M)
                  </TypeButton>
                </div>
              </div>
              <button
                onClick={this.onFindClick}
              >
                Find a Match
              </button>
            </div>
          </div>
        </div>
      </DefaultLayout>
    );
  }
}

export default Play;
