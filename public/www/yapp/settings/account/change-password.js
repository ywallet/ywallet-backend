(function() {
    "use strict";

    angular
        .module("yapp.settings")
        .controller("ChangePassword", ChangePassword);

    ChangePassword.$inject = ["$scope", "StateRouter"];

    function ChangePassword($scope, StateRouter) {
        $scope.passwordData = {
            current: "",
            password: "",
            cpass: ""
        };

        $scope.changePassword = changePassword;

        ////////////////////

        function changePassword() {
            if ($scope.passwordData.password !== $scope.passwordData.cpass) {
                return;
            }
            $scope.passwordData.current = "";
            $scope.passwordData.password = "";
            $scope.passwordData.cpass = "";
            // StateRouter.goAndForget("yapp.dashboard");
        }
    }
})();