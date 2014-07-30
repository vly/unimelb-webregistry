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

var search = 'http://nikki.unimelb.edu.au:9393/search/';

var FrontEndApp = React.createClass({
	getInitialState: function () {
		return {
    		searchText: '',
			data: []
    	};
	},
    handleSearch: function(searchTerm){
    	var searchUrl =  search+searchTerm
		$.ajax({
			url: searchUrl,
			dataType: 'json',
      		success: function(data) {
        		this.setState({data: data});
      		}.bind(this),
      		error: function(xhr, status, err) {
        		console.error(searchUrl, status, err.toString());
      		}.bind(this)
    	});
	},
	render: function(){
		return(
	      <div className='main'>
	      	<SearchBox onSearchSubmit={this.handleSearch} />
	      	<DataTable sitedata={this.state.data}/>
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
		if(this.props.sitedata.length!=0){
		this.props.sitedata.data.forEach(function(webdata){
        	  rows.push(<DataRows webdata={webdata} key={webdata.website} />); 
        });
        }
		return(
			<table>
				<thead>
	                <tr>
	                    <th>Website </th>
	                    <th>Title </th>
	                    <th>Department </th>
	                    <th>Contact</th>
	                    <th>Maintainer </th>
	                </tr>
	            </thead>
	            <tbody>{rows}</tbody>
            </table>
			);
	}

});

var SearchBox = React.createClass({
    handleSubmit:function(){
    	var search = this.refs.searchTerm.getDOMNode().value.trim();
		this.props.onSearchSubmit(search);
 		this.refs.searchTerm.getDOMNode().value = '';
    	return false;

    },
	render:function(){
    return (
            <form className="SearchBox" onSubmit={this.handleSubmit}>
            	<input  
            	    type="text"
                    placeholder="Search..."
                    ref ="searchTerm"
                />
                <input
                   type="submit"
                   value="Search"
                />

            </form>
        );

	}

});

React.renderComponent(<FrontEndApp />, document.getElementById('content')); // jshint ignore:line

module.exports = FrontEndApp;
