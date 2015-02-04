(function() {
    'use strict';

    angular
        .module('yapp.history')
        .controller('History', History)

    History.$inject = ['$scope', 'DSHistory'];
    function History($scope, DSHistory)
    {
		DSHistory.getHistory().then(function(data){
			$scope.transactions = data;	
		});        
    }

})();