/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
  requireNativeComponent
} from 'react-native';

//Big thanks to http://almostobsolete.net/react-native/custom-ios-views-with-react-native.html
var CustomLoginView = requireNativeComponent('Auth0Login', null);
module.exports = CustomLoginView;

class ReactNativeExampleApp extends Component {
  render() {
    return (
      <CustomLoginView style={{flex: 1, backgroundColor: 'lightgray'}}/>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('ReactNativeExampleApp', () => ReactNativeExampleApp);
