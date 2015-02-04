(function() {
    'use strict';

    angular
        .module('yapp.rules')
        .controller('Rules', Rules)

 	Rules.$inject = ['$scope', '$ionicModal', 'DSRules'];
	function Rules($scope, $ionicModal, DSRules)
	{
		DSRules.getRules().then(function(data){

			$scope.rules = data;

			// Add Rule
			$scope.ruleData = {};

			// Add Rule - Init Modal
			$ionicModal.fromTemplateUrl('yapp/rules/addRule.html', {
				scope: $scope
			}).then(function(modal) {
				$scope.modal = modal;
			});

			$scope.openAddRule = function() {
				$scope.modal.show();
			};

			$scope.closeAddRule = function() {
				$scope.modal.hide();
			};

			$scope.addRule = function() {

				console.log($scope.ruleData);
				DSRules.addRule($scope.ruleData.qty, $scope.ruleData.period, $scope.ruleData.active).then(function(data){

					$scope.rules.push(	{
						"id": data.id, 
						"period": $scope.ruleData.period,
						"qty": $scope.ruleData.qty,
						"active": $scope.ruleData.activate					 
					});

					$scope.ruleData = {};
					$scope.closeAddRule();

				});
			};

			// Remove Rule
	        $scope.rmRule = function(id) {
	        	var lengthRules = $scope.rules.length;
	        	var i = 0, index = -1;
	        		
	        	for(; i < lengthRules && index == -1; i++)
	        	{
	        		if( $scope.rules[i].id == id )
	        			index = i;
	        	}

	        	$scope.rules.splice(index, 1);
	        	
	            DSRules.rmRule(id);
	        }

	        // Toggle Activate
			$scope.toogleAtivate = function(id, ativate) {
	            DSRules.toogleAtivate(id, ativate);
	        }		
		});

		
	}

})();