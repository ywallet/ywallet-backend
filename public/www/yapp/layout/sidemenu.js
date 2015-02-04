(function() {
	'use strict';

	angular
		.module('yapp.layout')
		.controller('Sidemenu', Sidemenu)

    Sidemenu.$inject = ['$scope', '$rootScope', '$location', 'StateRouter'];

    function Sidemenu($scope, $rootScope, $location, StateRouter) {
			$scope.yUser = $rootScope.yUser;
			$scope.yUser.balance = 123;
			$scope.isItemActive = function(path) {
					return $location.path().indexOf(path) > -1;
			};

			if ($rootScope.yUser == null) {
					StateRouter.goAndForget("home");
			}
    }
})();
