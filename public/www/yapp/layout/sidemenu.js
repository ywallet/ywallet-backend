(function() {
	'use strict';

	angular
		.module('yapp.layout')
		.controller('Sidemenu', Sidemenu)

    Sidemenu.$inject = ['$scope', '$rootScope', '$location', 'StateRouter'];

    function Sidemenu($scope, $rootScope, $location, StateRouter) {
        $scope.isItemActive = function(path) {
            return $location.path().indexOf(path) > -1;
        };

        if ($rootScope.yUser == null) {
            StateRouter.goAndForget("home");
        }
    }
})();