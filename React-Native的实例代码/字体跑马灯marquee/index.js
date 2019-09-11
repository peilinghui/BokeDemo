import PropTypes from 'prop-types';
import React, { Component } from 'react';

import { Animated, Dimensions, Easing, View, Text, ViewPropTypes } from 'react-native';

import isEqual from 'lodash/isEqual';

const width = Dimensions.get('window').width;
const mHeight = 32;

export default class Marquee extends Component {
  static propTypes = {
    backgroundColor: PropTypes.string,
    messages: PropTypes.any,
    duration: PropTypes.number,
    style: ViewPropTypes.style,
  };

  static defaultProps = {
    backgroundColor: 'rgba(255, 255, 255, 0.4)',
  };

  constructor(props) {
    super(props);

    this.state = {
      anim: new Animated.Value(0),
      initialize: false,
    };
    this.animatedWidth = 0;
  }

  componentDidMount() {
    this.timerid = setTimeout(() => {
      this.initialize = true;
      this.needAnim = this.animatedWidth > width;
      this.setState({ initialize: true });
      if (this.needAnim) {
        this.start();
      }
    }, 1000);
  }

  shouldComponentUpdate(nextProps) {
    return !isEqual(nextProps.messages, this.props.messages) || !this.state.initialize;
  }

  componentWillUnmount() {
    clearTimeout(this.timerid);
  }

  onLayout = ({ nativeEvent }) => {
    if (this.initialize) return;
    this.animatedWidth = nativeEvent.layout.width;
    this.animatedHeight = nativeEvent.layout.height;
  };

  start() {
    const {
      duration,
      messages,
    } = this.props;
    const play = () => {
      Animated
      .timing(this.state.anim, {
        toValue: 1,
        duration: duration || 5000 * messages.length,
        easing: Easing.linear,
      })
      .start(() => {
        this.state.anim.setValue(0);
        play();
      });
    };
    play();
  }

  render() {
    const {
      backgroundColor,
      messages,
      style,
    } = this.props;

    const height = style && style.height || mHeight;

    const animStyle = this.needAnim ? {
      transform: [{
        translateX: this.state.anim.interpolate({
          inputRange: [0, 1],
          outputRange: [width, -this.animatedWidth],
        }),
      }],
    } : {};

    if (this.state.initialize && !this.needAnim) {
      animStyle.position = 'relative';
    }
    return messages.length ?
      <View
        style={[{
          height,
          opacity: this.state.initialize + 0,
        }, style]}>
        <View style={{
          position: 'absolute',
          top: 0,
          left: 0,
          backgroundColor,
          height,
          width,
        }} />
        <Animated.View
          onLayout={this.onLayout}
          style={{
            height,
            position: 'absolute',
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'flex-start',
            backgroundColor: 'transparent',
            ...animStyle,
          }}>
          {
            messages.map((msg, index) => {
              let s = { marginRight: 45 };
              if (index === messages.length - 1) {
                s = null;
              }
              if (index === 0) {
                s.marginLeft = 20;
              }
              return (
                <Text
                  key={index}
                  style={[{
                    color: '#fff',
                    fontSize: 12,
                  }, s]}>
                  {msg}
                </Text>
              );
            })
          }
        </Animated.View>
      </View>
    : null;
  }
}
