/** @jsx React.DOM */
'use strict';

var TestUtils;
var DataTable = require('../../../src/scripts/components/FrontEndApp.jsx');

describe('Main', function () {
  var FrontEndApp,component,table, mockData,instance;
  
  beforeEach(function () {
    TestUtils  = React.addons.ReactTestUtils;
    var container = document.createElement('div');
    mockData = {query:'site', data:[{ WebSite: "gradstudies.unimelb.edu.au", Title: "MSGR website has moved!", Faculty: "Melbourne School of Graduate Research", Contact: "George Duke", Maintainer: "George Duke"}]}
    container.id = 'content';
    document.body.appendChild(container);
    FrontEndApp  = require('../../../src/scripts/components/FrontEndApp.jsx');
    component = FrontEndApp();
    // var tmp = React.renderComponent(<DataTable />, container);
    //instance = TestUtils.renderIntoDocument(< FrontEndApp />);
  });

  it('should create a new instance of FrontEndApp', function () {
    console.log(component);
    expect(component).toBeDefined();
  });

  it('should check if table is rendered', function () {

    
  });


});
