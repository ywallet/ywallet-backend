(function() {
    "use strict";

    angular
        .module("yapp.authentication")
        .controller("SignIn", SignIn);

    SignIn.$inject = ["$scope", "$auth", "StateRouter", "DSUser"];

    function SignIn($scope, $auth, StateRouter, DSUser) {
        $scope.signinData = {
            email: "",
            password: ""
        };

        $scope.doSignIn = doSignIn;

        ////////////////////

        function doSignIn() {
            var data = {
                email: $scope.signinData.email,
                password: $scope.signinData.password
            };
            $scope.signinData.password = "";
            $auth.submitLogin(data)
                .then(onSignInSuccess)
                .catch(onSignInError);
        }


        function onSignInSuccess(resp) {
            DSUser.putUser(resp.data);
            StateRouter.goAndForget("yapp.dashboard");
        }

        function onSignInError(resp) {
            if (resp && resp.errors && false) {
                console.error("error authenticating", resp.errors);
            } else {
                // TODO development only
                onSignInSuccess({
                    data: {
                        id:         1,
                        provider:   "email",
                        uid:        "teste@teste.com",
                        name:       "teste",
                        nickname:   null,
                        image:      null,
                        email:      "teste@teste.com",
                        manager_id: 1,
                        child_id:   null,
                        address:    null,
                        phone:      null,
                        birthday:   null
                    }
                });
            }
        }
    }
})();