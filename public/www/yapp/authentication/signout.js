(function() {
    'use strict';

    angular
        .module('yapp.authentication')
        .controller('SignOut', SignOut);

    SignOut.$inject = ["$scope", "$auth", "StateRouter"];
    function SignOut($scope, $auth, StateRouter) {
        $scope.doSignOut = doSignOut;

        ////////////////////

        function doSignOut() {
            $auth.signOut();
        }
    }

})();