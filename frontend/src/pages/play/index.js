import React from 'react';
import classNames from 'classnames';

import DefaultLayout from '../../layouts/default';

import './index.css';

import Button from '../../components/button';
import { DefaultStartingBoard } from '../../components/board';

import { listen } from '../../socket';
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

const ModeButton = ({ mode, disabled, children, onClick }) => (
  <button
    className={classNames('white', { disabled })}
    onClick={() => onClick(mode)}
  >
    {children}
  </button>
);

class Play extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      size: 10,
      mode: CLASSIC,
      waiting: false,
    };

    this.onChangeSize = this.onChangeSize.bind(this);
    this.onChangeMode = this.onChangeMode.bind(this);
    this.onPlay = this.onPlay.bind(this);
    this.onQueueWaiting = this.onQueueWaiting.bind(this);
  }

  componentWillMount() {
    listen('QUEUE_WAITING', this.onQueueWaiting);
  }

  onQueueWaiting() {
    this.setState({ waiting: true });
  }

  onChangeSize(size) {
    this.setState({ size });
  }

  onChangeMode(mode) {
    this.setState({ mode });
  }

  onPlay(evt) {
    evt.preventDefault();
    sendPlay(this.state);
  }

  render() {
    const { size, mode } = this.state;

    return (
      <DefaultLayout>
        <div className="play">
          <div className="play-card">
            <DefaultStartingBoard size={size} className="play-board" />
            <form
              className="play-options"
              onSubmit={this.onPlay}
            >
              <SizeOptions
                size={size}
                onChangeSize={this.onChangeSize}
              />
              <div className="play-options-mode">
                <div className="play-options-mode-line">
                  <ModeButton
                    mode={BULLET}
                    disabled={mode !== BULLET}
                    onClick={this.onChangeMode}
                  >
                    Bullet (1M)
                  </ModeButton>
                  <ModeButton
                    mode={BLITZ}
                    disabled={mode !== BLITZ}
                    onClick={this.onChangeMode}
                  >
                    Blitz (5M)
                  </ModeButton>
                </div>
                <div className="play-options-mode-line">
                  <ModeButton
                    mode={CLASSIC}
                    disabled={mode !== CLASSIC}
                    onClick={this.onChangeMode}
                  >
                    Classic (10M)
                  </ModeButton>
                </div>
              </div>
              <Button
                loading={this.state.waiting}
                text="Play"
                loadingText="Searching..."
              />
            </form>
          </div>
        </div>
      </DefaultLayout>
    );
  }
}

export default Play;
