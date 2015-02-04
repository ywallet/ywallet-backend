(function() {
    "use strict";

    angular
        .module("yapp.settings")
        .controller("RegisterChild", RegisterChild);

    RegisterChild.$inject = ["$scope", "$rootScope", "$http", "StateRouter"];

    function RegisterChild($scope, $rootScope, $http, StateRouter) {
        $scope.blocked = false;
        $scope.childData = {
            name: "",
            email: "",
            pass: "",
            cpass: ""
        };

        $scope.registerChild = registerChild;

        ////////////////////

        function registerChild() {
            /*$rootScope.yUser = {
                name: $scope.coinData.name,
                email: $scope.coinData.email
            };
            StateRouter.goAndForget("yapp.dashboard");*/
            var data;
            if ($scope.childData.password !== $scope.childData.cpass) {
                return;
            }
            data = {
                child: {
                    //manager_id: $rootScope.yUser.id,
                    account_attributes: {
                        name: $scope.childData.name,
                        email: $scope.childData.email,
                        password: $scope.childData.password,
                        password_confirmation: $scope.childData.cpass
                    }
                }
            };
            // register the user
            $http.post("http://ywallet.co/children.json", data)
                .success(onRegisterSuccess)
                .error(onRegisterError);
            $scope.blocked = true;
        }

        function onRegisterSuccess(data, status, headers, config) {
            // data is an object with child info: id, ...
            console.log("CHILD REGISTER", data);
        }

        function onRegisterError(data, status, headers, config) {
            if (data && data.errors) {
                console.error("register error", data.errors);
                StateRouter.goAndForget("yapp.settings");
            } else {
                // TODO development only
                onRegisterSuccess({}, null, null, null);
            }
        }
    }
})();