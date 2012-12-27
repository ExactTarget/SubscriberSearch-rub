$(function() {

//Create the data source and options for the data grid.
				
				var dataSource = new SubscriberSearchDataSource({
					columns: [{
						property: 'EmailAddress',
						label: 'Email Address',
						sortable: false
					}, 
					{
						property: 'SubscriberKey',
						label: 'Subscriber Key',
						sortable: false
					},
					{
						property: 'Status',
						label: 'Status',
						sortable: false
					}
					],
					delay: 250
				});
				
//Initialize the data grid.
				
				$('#subscriberGrid').datagrid({
					dataSource: dataSource,
					renderData: true
				});
											

				
			});	