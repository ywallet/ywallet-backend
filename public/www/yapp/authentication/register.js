(function() {
    "use strict";

    angular
        .module("yapp.authentication")
        .controller("Register", Register);

    Register.$inject = ["$scope", "$http", "$auth", "StateRouter", "Authenticator", "DSUser"];

    function Register($scope, $http, $auth, StateRouter, Authenticator, DSUser) {
        var userData = null;

        $scope.registerData = {
            email: "",
            password: "",
            cpass: "",
            agrees: false
        };

        $scope.doRegister = doRegister;

        ////////////////////

        function doRegister() {
            var data;
            if ($scope.registerData.password !== $scope.registerData.cpass) {
                return;
            }
            if (!$scope.registerData.agrees) {
                return;
            }
            data = {
                email: $scope.registerData.email,
                password: $scope.registerData.password,
                password_confirmation: $scope.registerData.cpass,
                plan: "FREE"
            };
            $scope.registerData.password = "";
            $scope.registerData.cpass = "";
            // register the user
            $auth.submitRegistration(data, { config: "manager" })
                .then(onRegisterSuccess)
                .catch(onRegisterError);
        }

        function onRegisterSuccess(resp) {
            userData = resp;
            // proceed to coinbase login
            Authenticator.authenticate("coinbase", onServiceSuccess, onServiceError);
        }

        function onRegisterError(resp) {
            if (resp && resp.errors) {
                console.error("register error", resp.errors);
                StateRouter.goAndForget("authentication.index");
            } else {
                // TODO development only
                onRegisterSuccess({
                    name: "yUser",
                    role: "parent",
                    email: "yUser@email.com"
                });
            }
        }


        function onServiceSuccess(code) {
            // send code to exchange for token
            $http.post("https://ywallet.herokuapp.com/bitcoin_accounts", {
                authentication_code: code
            })
                .success(onTokenSuccess)
                .error(onTokenError);
        }

        function onServiceError(error) {
            console.error(error);
            // TODO remove following code, development only
            onTokenSuccess(null, null, null, null);
        }


        function onTokenSuccess(data, status, headers, config) {
            DSUser.putUser(userData);
            // window.localStorage.setItem("access_token", result.access_token);
            StateRouter.goAndForget("yapp.dashboard");
        }

        function onTokenError(data, status, headers, config) {
            if (data && data.errors) {
                console.error("token exchange error", data.errors);
                StateRouter.goAndForget("authentication.index");
            } else {
                // TODO development only
                onTokenSuccess(null, status, headers, config);
            }
        }
    }
})();