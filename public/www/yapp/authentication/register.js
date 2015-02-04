(function() {
    "use strict";

    angular
        .module("yapp.authentication")
        .controller("Register", Register);

    Register.$inject = ["$scope", "$http", "$auth", "StateRouter", "Authenticator", "DSUser", "$q"];

    function Register($scope, $http, $auth, StateRouter, Authenticator, DSUser, $q) {
        $scope.blocked = false;
        $scope.registerData = {
            email: "",
            password: "",
            cpass: "",
            agrees: false
        };

        //$scope.$on("auth:registration-email-success", onRegisterSuccess);

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
                manager: {
                    account_attributes: {
                        // plan: "FREE"
                        name: "yUser",
                        email: $scope.registerData.email,
                        password: $scope.registerData.password,
                        password_confirmation: $scope.registerData.cpass
                    }
                }
            };
            // register the user
            $auth.submitRegistration(data, { config: "manager" })
                .then(onRegisterSuccess)
                .catch(onRegisterError);
            $scope.blocked = true;
        }

        function onRegisterSuccess(resp) {
            resp = resp.data;
            console.log("REGISTERED", resp);
            if (resp.children_ids != null) {
                resp.role = "parent";
                resp.children = [];
            } else {
                resp.role = "child";
            }
            DSUser.putUser(resp);
            goToService();
            /*DSUser.auth = $auth.submitLogin({
                email: $scope.registerData.email,
                password: $scope.registerData.password
            })
                .then(goToService);*/
                //.catch(goHome);
        }

        function onRegisterError(resp) {
            console.error("register error", resp);
            StateRouter.goAndForget("authentication.index");
        }


        function goToService() {
            // proceed to coinbase login
            console.log("Redirecting to Coinbase...");
            Authenticator.authenticate("coinbase", onServiceSuccess, onServiceError);
        }

        function goHome() {
            // console.error("Validation error after register.");
            StateRouter.goAndForget("home");
        }


        function onServiceSuccess(code) {
            // send code to exchange for token
            $http.post("http://ywallet.co/bitcoin_accounts", {
                authentication_code: code
            })
                .success(onTokenSuccess)
                .error(onTokenError);
        }

        function onServiceError(error) {
            // normal behaviour:
            console.error(error);
            // goHome();

            // TODO remove following code, development only
            onTokenSuccess(null, null, null, null);
        }


        function onTokenSuccess(data, status, headers, config) {
            DSUser.auth = $auth.submitLogin({
                email: $scope.registerData.email,
                password: $scope.registerData.password
            }).then(goHome, function () {
                goHome();
                return $q.reject("error authenticating");
            });
        }

        function onTokenError(data, status, headers, config) {
            console.error("token exchange error", data);
            StateRouter.goAndForget("authentication.index");
        }
    }
})();