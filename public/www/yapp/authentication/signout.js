(function() {
    'use strict';

    angular
        .module('yapp.authentication')
        .controller('SignOut', SignOut);

    SignOut.$inject = ["$scope", "StateRouter", "DSUser"];
    function SignOut($scope, StateRouter, DSUser) {
        $scope.doSignOut = doSignOut;

        ////////////////////

        function doSignOut() {
            DSUser.rmUser();
            // window.localStorage.removeItem("access_token");
            StateRouter.goAndForget("home");
        }
    }

})();