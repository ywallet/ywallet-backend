(function() {
    "use strict";

    angular
        .module("yapp.authentication")
        .controller("ForgotPassword", ForgotPassword);

    ForgotPassword.$inject = ["$scope", "$rootScope", "StateRouter"];

    function ForgotPassword($scope, $rootScope, StateRouter) {
        $scope.recoveryData = {
            email: ""
        };

        $scope.doRecovery = doRecovery;

        ////////////////////

        function doRecovery() {
            StateRouter.goAndForget("yapp.dashboard");
        }
    }
})();