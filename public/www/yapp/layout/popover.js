(function() {
	'use strict';

	angular
		.module('yapp.layout')
		.controller('Popover', Popover)

    Popover.$inject = ["$scope", "$ionicPopover"];
	function Popover($scope, $ionicPopover) {

		$ionicPopover.fromTemplateUrl('yapp/layout/popover.html', {
			scope: $scope
		}).then(function(popover) {
			$scope.popover = popover;
		});
    }
})();