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
						property: 'ViewDetails',
						label: '',
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
											
//Get the data for the subscriber detail section.
				
				$('.viewDetails').live('click', function(){
					var $url = "/subscriber/" + this.id;
					$.ajax({url: $url, 				
						
						complete:function(result){	
							console.log(result)												
							$('#subscriberDetails').html(result.responseText);					
						}		
					});						

					return false;
				});

//Use the update route to update the subscribers status.
	
				$('.saveStatus').live('click', function(){
					var $url = "/subscriber/update/" + this.id + "/" + $('#statusValue').combobox().val() ;
					$.ajax({url: $url, 				
						
						complete:function(result){
// Once the update is complete, refresh the grid
							var $gridsearch = jQuery('#subscriberGrid').find('.search');
							var search = $gridsearch.find('input').val();
							$gridsearch.trigger('searched', "_RELOAD");
						}		
					});						
				 
					return false;
				});
				
			});	