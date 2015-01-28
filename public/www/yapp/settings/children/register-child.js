(function() {
    "use strict";

    angular
        .module("yapp.settings")
        .controller("RegisterChild", RegisterChild);

    RegisterChild.$inject = ["$scope", "$http", "StateRouter"];

    function RegisterChild($scope, $http, StateRouter) {
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
                name: $scope.childData.name,
                email: $scope.childData.email,
                password: $scope.childData.password,
                password_confirmation: $scope.childData.cpass,
                uid: $scope.childData.email
            };
            $scope.childData.password = "";
            $scope.childData.cpass = "";
            // register the user
            $http.post("https://ywallet.herokuapp.com/children.json", data)
                .success(onRegisterSuccess)
                .error(onRegisterError);
        }

        function onRegisterSuccess(data, status, headers, config) {
            // data is an object with child info: id, ...
        }

        function onRegisterError(data, status, headers, config) {
            if (data && data.errors) {
                console.error("register error", data.errors);
                // StateRouter.goAndForget("authentication.index");
            } else {
                // TODO development only
                onRegisterSuccess({}, null, null, null);
            }
        }
    }
})();