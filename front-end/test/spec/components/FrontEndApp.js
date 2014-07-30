'use strict';

describe('Main', function () {
  var FrontEndApp, component;

  beforeEach(function () {
    var container = document.createElement('div');
    container.id = 'content';
    document.body.appendChild(container);

    FrontEndApp = require('../../../src/scripts/components/FrontEndApp.jsx');
    component = FrontEndApp();
  });

  it('should create a new instance of FrontEndApp', function () {
    expect(component).toBeDefined();
  });
});
