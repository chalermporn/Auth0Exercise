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

var CustomLoginView = requireNativeComponent('Auth0Login', null);
module.exports = CustomLoginView;

class ReactNativeExampleApp extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
        <TouchableHighlight
    	  style={styles.button}
          onPress={this.buttonClicked}>
          <View>
            <Text style={styles.buttonText}>Please tap me!</Text>
          </View>
        </TouchableHighlight>
        <CustomLoginView style={{width: 300, height: 400, backgroundColor: 'lightgray'}}/>
      </View>
    );
  }
  buttonClicked(event) {
    console.log('button clicked');
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
