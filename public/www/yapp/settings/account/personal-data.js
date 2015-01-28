(function() {
    "use strict";

    angular
        .module("yapp.settings")
        .controller("PersonalData", PersonalData);

    PersonalData.$inject = ["$scope", "$auth", "StateRouter", "DSUser"];

    function PersonalData($scope, $auth, StateRouter, DSUser) {
        $scope.personalData = {
            name: "",
            email: ""
        };

        $scope.changeData = changeData;

        ////////////////////

        function changeData() {
            /*$rootScope.yUser = {
                name: $scope.personalData.name,
                email: $scope.personalData.email
            };
            StateRouter.goAndForget("yapp.dashboard");*/
            $auth.updateAccount($scope.personalData)
                .then(onUpdateSuccess)
                .catch(onUpdateError);
        }


        function onUpdateSuccess(resp) {
            DSUser.putUser(resp);
            StateRouter.goAndForget("yapp.settings");
        }

        function onUpdateError(resp) {
            if (resp && resp.errors) {
                console.error("error authenticating", resp.errors);
                StateRouter.goAndForget("yapp.settings");
            } else {
                // TODO development only
                onUpdateSuccess({
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
                });
            }
        }
    }
})();