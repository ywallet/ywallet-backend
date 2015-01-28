(function() {
    'use strict';

    angular
        .module('yapp.savings')
        .controller('Savings', Savings)

 	Savings.$inject = ['$scope', '$ionicModal', '$cordovaDevice', 'DSavings'];
	function Savings($scope, $ionicModal, $cordovaDevice, DSavings)
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
				console.log('Doing login', $scope.loginData);

				// Simulate a login delay. Remove this and replace with your login
				// code if using a login system
				$timeout(function() {
				$scope.closeLogin();
				}, 1000);
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