/*
 * Fuel UX Data components - static data source
 * https://github.com/ExactTarget/fuelux-data
 *
 * Copyright (c) 2012 ExactTarget
 * Licensed under the MIT license.
 */

(function (root, factory) {
	if (typeof define === 'function' && define.amd) {
		define(['underscore'], factory);
	} else {
		root.SubscriberSearchDataSource = factory();
	}
}(this, function () {

	var SubscriberSearchDataSource = function (options) {
		this._formatter = options.formatter;
		this._columns = options.columns;
		this._delay = options.delay || 0;
		this._data = options.data;
	};
	var searchTerm = '';
	var results = {};
	
	SubscriberSearchDataSource.prototype = {

		columns: function () {
			return this._columns;
		},

		data: function (options, callback) {
			
			
			var self = this;

// SEARCHING
				if (options.search) {					
					if (options.search != searchTerm) {
// Until a reload option is added to data grid, we need to use the search to reload it which is why this workaround is needed.
						if (options.search != '_RELOAD'){
							searchTerm = options.search;
						}
						var $url = "/subscribers?searchString=" + searchTerm;
						$.ajax($url).done(function(response){
							var data = JSON.parse(response).subscribers;
							results = data;
							popGrid(results,options,callback);							
						});
					} else {
						popGrid(results,options,callback);
					}
					
				} else {
// No search. Return zero results to Datagrid
					callback({ data: [], start: 0, end: 0, count: 0, pages: 0, page: 0 });					
				}

		}
	}
	
//popGrid sets all of the information required for the data grid - including paging and formatting for the view data buttons.
	
	function popGrid(results,options,callback)
	{
		var count = results.length;
		var startIndex = options.pageIndex * options.pageSize;
		var endIndex = startIndex + options.pageSize;
		var end = (endIndex > count) ? count : endIndex;
		var pages = Math.ceil(count / options.pageSize);
		var page = options.pageIndex + 1;
		var start = startIndex + 1;						
		data = results.slice(startIndex, endIndex);
				
		if (self._formatter) self._formatter(data);
		callback({ data: data, start: start, end: end, count: count, pages: pages, page: page });
	}

	return SubscriberSearchDataSource;
}));