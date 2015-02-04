(function() {
    'use strict';

    angular
        .module('yapp.savings')
        .controller('Savings', Savings)

 	Savings.$inject = ['$scope', '$ionicModal', 'DSavings'];
	function Savings($scope, $ionicModal, DSavings)
	{
		DSavings.getSavings().then(function(data){

			$scope.savings = data;

			// Add Saving
			$scope.savingData = {};

			// Add Saving - Init Modal
			$ionicModal.fromTemplateUrl('yapp/savings/addSaving.html', {
				scope: $scope
			}).then(function(modal) {
				$scope.modal = modal;
			});

			$scope.openAddSaving = function() {
				$scope.modal.show();
			};

			$scope.closeAddSaving = function() {
				$scope.modal.hide();
			};

			$scope.addSaving = function() {

				DSavings.addSaving($scope.savingData.title, $scope.savingData.description, $scope.savingData.qty, $scope.savingData.deadline).then(function(data){

					$scope.savings.push(	{
						"id": data.id, 
						"title": $scope.savingData.title,
						"description": $scope.savingData.description,
						"qty": $scope.savingData.qty,
						"deadline": $scope.savingData.deadline 
					});

					$scope.savingData = {};
					$scope.closeAddSaving();

				});
			};

			// Remove Saving
	        $scope.rmSaving = function(id) {
	        	var lengthSavings = $scope.savings.length;
	        	var i = 0, index = -1;
	        		
	        	for(; i < lengthSavings && index == -1; i++)
	        	{
	        		if( $scope.savings[i].id == id )
	        			index = i;
	        	}

	        	$scope.savings.splice(index, 1);
	        	
	            DSavings.rmSaving(id);           
	        }			
		});

		
	}

})();