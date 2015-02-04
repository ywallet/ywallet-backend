(function() {
    'use strict';

    angular
        .module('yapp.settings')
        .controller('Settings', Settings)

	Settings.$inject = ["$scope", "$rootScope", "$translate"];

	function Settings($scope, $rootScope, $translate) {
        // $scope.isParent = $rootScope.yUser.role == "parent";
        $scope.curlang = $translate.use();
        $scope.changeLanguage = function(key) {
            $translate.use(key);
            $scope.curlang = key;
        };
    }
})();