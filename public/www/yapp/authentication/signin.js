(function() {
    "use strict";

    angular
        .module("yapp.authentication")
        .controller("SignIn", SignIn);

    SignIn.$inject = ["$scope", "$auth", "StateRouter", "DSUser", "$q"];

    function SignIn($scope, $auth, StateRouter, DSUser, $q) {
        $scope.blocked = false;
        $scope.signinData = {
            email: "",
            password: ""
        };

        $scope.doSignIn = doSignIn;

        ////////////////////

        function doSignIn() {
            $scope.blocked = true;
            DSUser.auth = $auth.submitLogin($scope.signinData)
                .then(onSignInSuccess, onSignInError);
        }


        function onSignInSuccess(resp) {
            console.log("SIGNED IN", resp);
            if (resp.manager_id != null) {
                resp.role = "parent";
                resp.children = [];
            } else {
                resp.role = "child";
            }
            DSUser.putUser(resp);
            StateRouter.goAndForget("home");
            return resp;
        }

        function onSignInError(resp) {
            console.error("error authenticating", resp);
            StateRouter.goAndForget("home");
            return $q.reject("error authenticating");
        }
    }
})();