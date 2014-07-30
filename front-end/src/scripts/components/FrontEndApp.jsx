/**
 * @jsx React.DOM
 */

'use strict';

var React = require('react/addons');
var ReactTransitionGroup = React.addons.TransitionGroup;

// Export React so the devtools can find it
(window !== window.top ? window.top : window).React = React;

// CSS
require('../../styles/reset.css');
require('../../styles/main.css');

var imageURL = '../../images/yeoman.png';

var FrontEndApp = React.createClass({
  render: function() {
    return (
      <div className='main'>
      <SearchBox />
      <DataTable sitedata={this.props.sitedata}/>
      </div>
    );
  }
});

var DataRows = React.createClass({
	render:function(){
		return (
            <tr>
                <td>{this.props.webdata.WebSite}</td>
                <td>{this.props.webdata.Title}</td>
                <td>{this.props.webdata.Faculty}</td>
                <td>{this.props.webdata.Contact}</td>
                <td>{this.props.webdata.Maintainer}</td>
            </tr>
        );
	}

});


var DataTable = React.createClass({
	render:function(){
		var rows=[];
		this.props.sitedata.forEach(function(webdata){
        	  rows.push(<DataRows webdata={webdata} key={webdata.website} />); 
        });

		return(
			<table>
				<thead>
	                <tr>
	                    <th>Website</th>
	                    <th>Title</th>
	                    <th>Department</th>
	                    <th>Contact</th>
	                    <th>Maintainer</th>
	                </tr>
	            </thead>
	            <tbody>{rows}</tbody>
            </table>
			);

	}

});

var SearchBox = React.createClass({
	render:function(){

        return (
            <form>
                <input type="text" placeholder="Search..." />

            </form>
        );

	}

});

var SITEDATA = [{
WebSite: "soapbox.unimelb.edu.au",
Title: "THE SOAPBOX: Website no longer available",
Faculty: "#Unknown",
Contact: "Unknown",
Maintainer: "Sally Young"
},
{
WebSite: "www.oznet.unimelb.edu.au",
Title: "OzNet Monitoring Network Website",
Faculty: "Engineering",
Contact: "Tony Zara",
Maintainer: "Jeffrey Phillip Walker"
}];


React.renderComponent(<FrontEndApp  sitedata={SITEDATA}/>, document.getElementById('content')); // jshint ignore:line

module.exports = FrontEndApp;
