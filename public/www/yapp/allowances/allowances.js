(function() {
    'use strict';

    angular
        .module('yapp.allowances')
        .controller('Allowances', Allowances)

    Allowances.$inject = ["$scope"];
    function Allowances($scope)
    {
        console.log('Allowances');
		$scope.mesadas = [];
    }

})();