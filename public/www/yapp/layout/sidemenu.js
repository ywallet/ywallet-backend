(function() {
	'use strict';

	angular
		.module('yapp.layout')
		.controller('Sidemenu', Sidemenu)

    Sidemenu.$inject = ['$scope', '$location'];
    function Sidemenu($scope, $location) {
      $scope.isItemActive = function(path) {
        return $location.path().indexOf(path) > -1;
      };
    }
})();